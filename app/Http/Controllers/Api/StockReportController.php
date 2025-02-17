<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\StockAdjustmentItem;
use App\Models\StockTransaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class StockReportController extends Controller
{
    // Laporan Status Stok Barang
    public function stockStatus(Request $request)
    {
        try {
            Log::info('Starting Stock Status Report from stock_adjustment_items');
            
            // Tambahkan logging untuk parameter input
            $status = $request->input('status', ['Normal', 'Rusak', 'Hilang', 'Expired']);
            
            // Pastikan status adalah array
            if (is_string($status)) {
                $status = [$status];
            }
            
            Log::info('Requested Status: ' . json_encode($status));
            
            // Ambil data dari stock_adjustment_items dengan join ke products
            $stockStatus = DB::table('stock_adjustment_items')
                ->join('products', 'stock_adjustment_items.product_id', '=', 'products.id')
                ->select(
                    'stock_adjustment_items.id',
                    'products.name',
                    'products.sku',
                    'products.category',
                    'stock_adjustment_items.quantity',
                    'stock_adjustment_items.status',
                    'stock_adjustment_items.created_at'
                )
                ->whereIn('stock_adjustment_items.status', $status)
                ->get();

            Log::info('Total Stock Adjustment Items Found: ' . $stockStatus->count());
            
            return response()->json($stockStatus);
        } catch (\Exception $e) {
            Log::error('Stock Status Report Error: ' . $e->getMessage());
            Log::error('Trace: ' . $e->getTraceAsString());
            
            return response()->json([
                'message' => 'Gagal mengambil laporan status stok',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Laporan Transaksi Barang
    public function transactionReport(Request $request)
    {
        try {
            // Validasi input tanggal
            $startDate = $request->input('start_date', now()->startOfYear());
            $endDate = $request->input('end_date', now());

            // Konversi ke Carbon untuk memudahkan manipulasi tanggal
            $startDate = Carbon::parse($startDate)->startOfDay();
            $endDate = Carbon::parse($endDate)->endOfDay();

            Log::info("Transaction Report - Date Range: {$startDate} to {$endDate}");

            // Ambil semua transaksi dalam rentang tanggal
            $transactions = StockTransaction::with('product')
                ->whereBetween('transaction_date', [$startDate, $endDate])
                ->get();

            // Hitung ringkasan transaksi
            $summary = [
                'total_transactions' => $transactions->count(),
                'total_in_quantity' => $transactions->where('transaction_type', 'in')->sum('quantity'),
                'total_out_quantity' => $transactions->where('transaction_type', 'out')->sum('quantity'),
                'total_in_value' => $transactions->where('transaction_type', 'in')->sum('total_price'),
                'total_out_value' => $transactions->where('transaction_type', 'out')->sum('total_price')
            ];

            // Format data transaksi untuk respons
            $formattedTransactions = $transactions->map(function ($transaction) {
                return [
                    'id' => $transaction->id,
                    'product' => [
                        'id' => $transaction->product->id,
                        'name' => $transaction->product->name
                    ],
                    'transaction_type' => $transaction->transaction_type,
                    'quantity' => $transaction->quantity,
                    'total_price' => $transaction->total_price,
                    'transaction_date' => $transaction->transaction_date
                ];
            });

            Log::info('Transaction Report Generated');

            return response()->json([
                'summary' => $summary,
                'transactions' => $formattedTransactions
            ]);
        } catch (\Exception $e) {
            Log::error('Transaction Report Error: ' . $e->getMessage());
            Log::error('Trace: ' . $e->getTraceAsString());
            
            return response()->json([
                'message' => 'Gagal mengambil laporan transaksi',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // Laporan Penilaian Inventori
    public function inventoryValuation()
    {
        try {
            Log::info('Starting Inventory Valuation Report');

            // Ambil semua produk dengan perhitungan nilai inventori
            $products = Product::all()->map(function ($product) {
                // Hitung total kuantitas masuk
                $totalInQuantity = StockTransaction::where('product_id', $product->id)
                    ->where('transaction_type', 'in')
                    ->sum('quantity');

                // Hitung total nilai masuk
                $totalInValue = StockTransaction::where('product_id', $product->id)
                    ->where('transaction_type', 'in')
                    ->sum('total_price');

                // Hitung harga rata-rata
                $averageCost = $totalInQuantity > 0 
                    ? $totalInValue / $totalInQuantity 
                    : 0;

                // Hitung total nilai inventori
                $totalInventoryValue = $product->current_stock * $averageCost;

                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'sku' => $product->sku,
                    'category' => $product->category ?? 'Tidak Berkategori',
                    'current_stock' => $product->current_stock,
                    'average_cost' => round($averageCost, 2),
                    'total_inventory_value' => round($totalInventoryValue, 2)
                ];
            });

            // Grouping berdasarkan kategori
            $groupedProducts = $products->groupBy('category');

            // Hitung total nilai inventori per kategori dan keseluruhan
            $categoryTotals = $groupedProducts->map(function ($categoryProducts) {
                return [
                    'total_stock' => $categoryProducts->sum('current_stock'),
                    'total_inventory_value' => $categoryProducts->sum('total_inventory_value')
                ];
            });

            $totalInventoryValue = $products->sum('total_inventory_value');

            Log::info('Inventory Valuation Report Generated');

            return response()->json([
                'products' => $products,
                'grouped_products' => $groupedProducts,
                'category_totals' => $categoryTotals,
                'total_inventory_value' => round($totalInventoryValue, 2)
            ]);
        } catch (\Exception $e) {
            Log::error('Inventory Valuation Report Error: ' . $e->getMessage());
            Log::error('Trace: ' . $e->getTraceAsString());
            
            return response()->json([
                'message' => 'Gagal mengambil laporan penilaian inventori',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

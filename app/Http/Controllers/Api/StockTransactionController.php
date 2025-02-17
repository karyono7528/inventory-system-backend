<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\StockTransaction;
use App\Models\Product;
use Illuminate\Http\Request;

class StockTransactionController extends Controller
{
    public function index(Request $request)
    {
        $query = StockTransaction::with(['product', 'creator']);
        
        if ($request->product_id) {
            $query->where('product_id', $request->product_id);
        }
        
        if ($request->transaction_type) {
            $query->where('transaction_type', $request->transaction_type);
        }
        
        if ($request->date_from) {
            $query->whereDate('created_at', '>=', $request->date_from);
        }
        
        if ($request->date_to) {
            $query->whereDate('created_at', '<=', $request->date_to);
        }

        return $query->orderBy('created_at', 'desc')
                    ->paginate($request->per_page ?? 15);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'vendor_id' => 'required|exists:vendors,id',
            'transaction_type' => 'required|in:in,out',
            'quantity' => 'required|numeric|min:0.01',
            'unit_price' => 'required|numeric|min:0',
            'reference_number' => 'required|string',
            'notes' => 'nullable|string'
        ]);

        if ($validated['transaction_type'] === 'out') {
            $product = Product::findOrFail($validated['product_id']);
            if ($product->current_stock < $validated['quantity']) {
                return response()->json([
                    'message' => 'Insufficient stock'
                ], 422);
            }
        }

        $validated['created_by'] = $request->user()->id;
        $transaction = StockTransaction::create($validated);

        return response()->json($transaction->load(['product', 'creator']), 201);
    }

    public function show(StockTransaction $transaction)
    {
        return response()->json($transaction->load(['product', 'creator']));
    }

    public function report(Request $request)
    {
        $request->validate([
            'date_from' => 'required|date',
            'date_to' => 'required|date|after_or_equal:date_from'
        ]);

        $transactions = StockTransaction::with(['product', 'creator'])
            ->whereDate('created_at', '>=', $request->date_from)
            ->whereDate('created_at', '<=', $request->date_to)
            ->orderBy('created_at', 'desc')
            ->get();

        $summary = [
            'total_in' => $transactions->where('transaction_type', 'in')->count(),
            'total_out' => $transactions->where('transaction_type', 'out')->count(),
            'total_in_value' => $transactions->where('transaction_type', 'in')->sum('total_price'),
            'total_out_value' => $transactions->where('transaction_type', 'out')->sum('total_price'),
        ];

        return response()->json([
            'transactions' => $transactions,
            'summary' => $summary
        ]);
    }

    public function update(Request $request, StockTransaction $transaction)
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'vendor_id' => 'nullable|exists:vendors,id',
            'transaction_type' => 'required|in:in,out',
            'quantity' => 'required|numeric|min:0.01|max:99999.99',
            'unit_price' => 'required|numeric|min:0|max:999999.99',
            'reference_number' => 'required|string|min:3|max:255',
            'notes' => 'nullable|string|max:500'
        ]);

        // Cek stok untuk transaksi keluar
        if ($validated['transaction_type'] === 'out') {
            $product = Product::findOrFail($validated['product_id']);
            
            // Hitung selisih kuantitas
            $quantityDiff = $validated['quantity'] - $transaction->quantity;
            
            if ($product->current_stock < $quantityDiff) {
                return response()->json([
                    'message' => 'Stok tidak mencukupi untuk update transaksi'
                ], 422);
            }
        }

        // Update transaksi
        $transaction->update([
            'product_id' => $validated['product_id'],
            'vendor_id' => $validated['transaction_type'] === 'in' ? $validated['vendor_id'] : null,
            'transaction_type' => $validated['transaction_type'],
            'quantity' => $validated['quantity'],
            'unit_price' => $validated['unit_price'],
            'total_price' => $validated['quantity'] * $validated['unit_price'],
            'reference_number' => $validated['reference_number'],
            'notes' => $validated['notes'] ?? null,
            'updated_by' => $request->user()->id ?? 1 // Sementara hardcode
        ]);

        // Refresh data untuk mendapatkan relasi terbaru
        $transaction->refresh();

        return response()->json([
            'message' => 'Transaksi stok berhasil diperbarui',
            'data' => $transaction->load(['product', 'creator'])
        ]);
    }

    public function destroy($id)
    {
        try {
            $transaction = StockTransaction::findOrFail($id);
            
            // Soft delete
            $transaction->delete();

            return response()->json([
                'message' => 'Transaksi stok berhasil dihapus',
                'data' => $transaction
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Gagal menghapus transaksi stok',
                'error' => $e->getMessage()
            ], 400);
        }
    }
}

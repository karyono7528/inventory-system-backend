<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $query = Product::query();
        
        if ($request->search) {
            $query->where(function($q) use ($request) {
                $q->where('name', 'like', "%{$request->search}%")
                  ->orWhere('sku', 'like', "%{$request->search}%");
            });
        }
        
        if ($request->category) {
            $query->where('category', $request->category);
        }
        
        if ($request->has('is_active')) {
            $query->where('is_active', $request->is_active);
        }

        return $query->paginate($request->per_page ?? 10);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'sku' => 'required|unique:products',
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'category' => 'required|string',
            'minimum_stock' => 'required|numeric|min:0',
            'unit' => 'required|string',
            'current_stock' => 'required|numeric|min:0',
            'is_active' => 'boolean'
        ]);

        $product = Product::create($validated);
        return response()->json($product, 201);
    }

    public function show(Product $product)
    {
        return response()->json($product);
    }

    public function update(Request $request, $sku)
    {
        \Log::info('Update Product Request', [
            'sku' => $sku,
            'data' => $request->all()
        ]);

        $product = Product::where('sku', $sku)->firstOrFail();

        $validated = $request->validate([
            'sku' => 'required|unique:products,sku,' . $product->id,
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'category' => 'required|string',
            'minimum_stock' => 'required|numeric|min:0',
            'unit' => 'required|string',
            'current_stock' => 'required|numeric|min:0',
            'is_active' => 'boolean'
        ]);

        \Log::info('Validated Product Data', $validated);

        $product->update($validated);
        return response()->json($product);
    }

    public function destroy($sku)
    {
        \Log::info('Delete Product Request', [
            'sku' => $sku
        ]);

        $product = Product::where('sku', $sku)->firstOrFail();

        // Cek apakah produk sudah memiliki transaksi
        $hasTransactions = $product->stockTransactions()->exists();
        $hasStockOpnames = $product->stockOpnameItems()->exists();

        if ($hasTransactions || $hasStockOpnames) {
            return response()->json([
                'message' => 'Cannot delete product with existing transactions or stock opname records',
                'can_delete' => false,
                'has_transactions' => $hasTransactions,
                'has_stock_opnames' => $hasStockOpnames
            ], 400);
        }

        // Soft delete
        $product->delete();

        \Log::info('Product Soft Deleted', [
            'sku' => $product->sku,
            'name' => $product->name
        ]);

        return response()->json([
            'message' => 'Product successfully soft deleted',
            'can_delete' => true
        ], 200);
    }

    public function restore($sku)
    {
        \Log::info('Restore Product Request', [
            'sku' => $sku
        ]);

        $product = Product::withTrashed()->where('sku', $sku)->firstOrFail();
        $product->restore();

        \Log::info('Product Restored', [
            'sku' => $product->sku,
            'name' => $product->name
        ]);

        return response()->json([
            'message' => 'Product successfully restored',
            'product' => $product
        ], 200);
    }

    public function lowStock()
    {
        $products = Product::where('current_stock', '<=', 'minimum_stock')
            ->where('is_active', true)
            ->get();
        
        return response()->json($products);
    }

    public function stockMovement(Request $request, Product $product)
    {
        $transactions = $product->stockTransactions()
            ->with('creator')
            ->orderBy('created_at', 'desc')
            ->paginate($request->per_page ?? 15);
        
        return response()->json($transactions);
    }
}

<?php

namespace App\Http\Controllers\Api;

use App\Enums\Types;
use App\Http\Controllers\Controller;
use App\Models\StockAdjustment;
use App\Models\StockAdjustmentItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class StockAdjustmentController extends Controller
{
    public function index(Request $request)
    {
        return StockAdjustment::with(['items.product', 'creator:id,name', 'approver:id,name'])
            ->orderBy('created_at', 'asc')
            ->paginate($request->per_page ?? 10);
    }

    public function store(Request $request)
    {
        \Log::info('Store method reached', $request->all());
        $validated = $request->validate([
            'date' => 'required|date',
           'type' => 'required|in:' . implode(',', array_map(fn($type) => $type->value, Types::cases())),
            'notes' => 'nullable|string',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.notes' => 'nullable|string'
        ]);

        try {
            DB::beginTransaction();

            // Create stock adjustment
            $adjustment = StockAdjustment::create([
                'date' => $validated['date'],
                'type' => $validated['type'],
                'status' => 'draft',
                'notes' => $validated['notes'],
                'created_by' => auth()->id()
            ]);

            // Create stock adjustment items
            foreach ($validated['items'] as $item) {
                $product = Product::findOrFail($item['product_id']);                
                // Check stock availability for 'out' type
                if ($validated['type'] === 'out' && $product->current_stock < $item['quantity']) {
                    throw new \Exception("Insufficient stock for product: {$product->name}");
                }
                StockAdjustmentItem::create([
                    'stock_adjustment_id' => $adjustment->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'notes' => $item['notes'] ?? null
                ]);
            }
            DB::commit();
            return response()->json($adjustment->load('items.product'), 201);

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating stock adjustment: ' . $e->getMessage());            
            return response()->json([
                'message' => $e->getMessage()
            ], 422);
        }
    }

    public function show($id)
    {
        try {
            $adjustment = StockAdjustment::with(['items.product', 'creator:id,name', 'approver:id,name'])
                ->findOrFail($id);
            
            return response()->json($adjustment);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Stock adjustment not found'
            ], 404);
        }
    }

    public function approve($id)
    {
        try {
            // Check if the user is an admin
            if (auth()->user()->role !== 'admin') {
                return response()->json([
                    'message' => 'Only administrators can approve stock adjustments'
                ], 403);
            }

            DB::beginTransaction();

            $adjustment = StockAdjustment::with('items.product')->findOrFail($id);

            if ($adjustment->status !== 'draft') {
                return response()->json([
                    'message' => 'Only draft adjustments can be approved'
                ], 422);
            }

            // Update product stocks
            foreach ($adjustment->items as $item) {
                $product = $item->product;
                $quantity = $adjustment->type === 'in' ? $item->quantity : -$item->quantity;
                
                if ($adjustment->type === 'out' && $product->current_stock < $item->quantity) {
                    throw new \Exception("Insufficient stock for product: {$product->name}");
                }

                // Log the stock change
                Log::info('Stock Adjustment Stock Change', [
                    'adjustment_id' => $adjustment->id,
                    'product_id' => $product->id,
                    'product_name' => $product->name,
                    'previous_stock' => $product->current_stock,
                    'adjustment_type' => $adjustment->type,
                    'adjustment_quantity' => $item->quantity,
                    'new_stock' => $product->current_stock + $quantity
                ]);

                $product->current_stock += $quantity;
                $product->save();
            }

            // Update adjustment status
            $adjustment->update([
                'status' => 'approved',
                'approved_by' => auth()->id(),
                'approved_at' => now()
            ]);

            DB::commit();
            return response()->json($adjustment->load('items.product'));

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error approving stock adjustment: ' . $e->getMessage());
            
            return response()->json([
                'message' => $e->getMessage()
            ], 422);
        }
    }

    public function reject($id)
    {
        try {
            // Check if the user is an admin
            if (auth()->user()->role !== 'admin') {
                return response()->json([
                    'message' => 'Only administrators can reject stock adjustments'
                ], 403);
            }

            $adjustment = StockAdjustment::findOrFail($id);

            if ($adjustment->status !== 'draft') {
                return response()->json([
                    'message' => 'Only draft adjustments can be rejected'
                ], 422);
            }

            $adjustment->update([
                'status' => 'rejected',
                'rejected_by' => auth()->id(),
                'rejected_at' => now()
            ]);

            return response()->json($adjustment->load('items.product'));

        } catch (\Exception $e) {
            Log::error('Error rejecting stock adjustment: ' . $e->getMessage());
            
            return response()->json([
                'message' => 'Failed to reject stock adjustment'
            ], 422);
        }
    }
}

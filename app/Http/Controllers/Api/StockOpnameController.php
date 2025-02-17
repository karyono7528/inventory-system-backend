<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\StockOpname;
use App\Models\StockOpnameItem;
use App\Models\Product;
use App\Models\StockAdjustment;
use App\Models\StockAdjustmentItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class StockOpnameController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request)
    {
        $query = StockOpname::with(['items.product', 'creator', 'approver']);
        
        if ($request->status) {
            $query->where('status', $request->status);
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
        Log::info('Received stock opname data:', $request->all());

        try {
            $validated = $request->validate([
                'date' => 'required|date',
                'status' => 'required|in:draft,pending,approved,rejected',
                'items' => 'required|array',
                'items.*.product_id' => 'required|exists:products,id',
                'items.*.system_stock' => 'required|integer|min:0',
                'items.*.physical_stock' => 'required|integer|min:0',
                'items.*.difference' => 'required|integer',
                'items.*.notes' => 'nullable|string'
            ]);

            Log::info('Validated data:', $validated);

            DB::beginTransaction();

            // Create stock opname header
            $stockOpname = StockOpname::create([
                'date' => $validated['date'],
                'status' => $validated['status'],
                'created_by' => $request->user()->id
            ]);

            Log::info('Created stock opname:', $stockOpname->toArray());

            // Create stock opname items
            foreach ($validated['items'] as $item) {
                $opnameItem = $stockOpname->items()->create([
                    'product_id' => $item['product_id'],
                    'system_stock' => $item['system_stock'],
                    'physical_stock' => $item['physical_stock'],
                    'difference' => $item['difference'],
                    'notes' => $item['notes']
                ]);
                Log::info('Created stock opname item:', $opnameItem->toArray());
            }

            DB::commit();

            $stockOpname->load(['items.product', 'creator']);
            Log::info('Successfully created stock opname with items');

            return response()->json([
                'message' => 'Stock opname created successfully',
                'data' => $stockOpname
            ], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            DB::rollback();
            Log::error('Validation error:', [
                'errors' => $e->errors(),
                'message' => $e->getMessage()
            ]);
            throw $e;
        } catch (\Exception $e) {
            DB::rollback();
            Log::error('Failed to create stock opname:', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'message' => 'Failed to create stock opname',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function show($id)
    {
        Log::info('Attempting to fetch stock opname with ID: ' . $id);
        
        try {
            $stockOpname = StockOpname::with(['items.product', 'creator:id,name', 'approver:id,name'])
                ->findOrFail($id);

            Log::info('Found stock opname: ' . json_encode($stockOpname));
            
            return response()->json($stockOpname);
        } catch (\Exception $e) {
            Log::error('Error fetching stock opname: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            
            return response()->json([
                'message' => 'Stock opname not found',
                'error' => $e->getMessage()
            ], 404);
        }
    }

    public function createStockAdjustment($id)
    {
        try {
            DB::beginTransaction();

            $opname = StockOpname::with('items.product')->findOrFail($id);

            if ($opname->status !== 'draft') {
                return response()->json([
                    'message' => 'Only draft stock opnames can create adjustments'
                ], 422);
            }

            // Detailed logging of initial state
            Log::info('Stock Opname Adjustment Started', [
                'opname_id' => $opname->id,
                'items_count' => $opname->items->count()
            ]);

            // Create a stock adjustment based on the stock opname
            $adjustment = StockAdjustment::create([
                'date' => now()->toDateString(),
                'type' => 'in',
                'status' => 'draft',
                'notes' => "Stock Adjustment from Stock Opname #{$opname->id}",
                'created_by' => auth()->id(),
                'stock_opname_id' => $opname->id
            ]);

            // Create stock adjustment items and update stock opname items
            $adjustmentItems = [];
            $updateLog = [];

            foreach ($opname->items as $item) {
                $product = $item->product;
                $systemStock = $product->current_stock;
                $actualStock = $item->physical_stock;
                
                // Calculate the difference
                $stockDifference = $actualStock - $systemStock;

                // Detailed logging for each item
                $updateLog[] = [
                    'item_id' => $item->id,
                    'product_id' => $product->id,
                    'product_name' => $product->name,
                    'system_stock' => $systemStock,
                    'physical_stock' => $actualStock,
                    'stock_difference' => $stockDifference
                ];

                // Only create adjustment item if there's a difference
                if ($stockDifference != 0) {
                    $adjustmentItem = StockAdjustmentItem::create([
                        'stock_adjustment_id' => $adjustment->id,
                        'product_id' => $product->id,
                        'quantity' => abs($stockDifference),
                        'notes' => $stockDifference > 0 
                            ? "Stock increase from Stock Opname" 
                            : "Stock reduction from Stock Opname"
                    ]);
                    $adjustmentItems[] = $adjustmentItem;

                    // Perform direct database update with logging
                    $updateResult = DB::table('stock_opname_items')
                        ->where('id', $item->id)
                        ->update([
                            'system_stock' => $actualStock,
                            'difference' => 0
                        ]);

                    Log::info('Stock Opname Item Update', [
                        'item_id' => $item->id,
                        'update_result' => $updateResult,
                        'new_system_stock' => $actualStock
                    ]);
                }
            }

            // Log the update log
            Log::info('Stock Opname Adjustment Update Log', $updateLog);

            // Automatically approve the stock adjustment if there are items
            if (!empty($adjustmentItems)) {
                $adjustment->update(['status' => 'draft']);
                
                // Approve the stock adjustment
                foreach ($adjustmentItems as $item) {
                    $product = $item->product;
                    $quantity = $item->quantity;
                    
                    $product->current_stock += $quantity;
                    $product->save();
                }

                $adjustment->update([
                    'status' => 'approved',
                    'approved_by' => auth()->id(),
                    'approved_at' => now()
                ]);
            }

            // Verify the updates
            $verificationQuery = DB::table('stock_opname_items')
                ->where('stock_opname_id', $opname->id)
                ->get();

            Log::info('Verification Query Results', [
                'opname_id' => $opname->id,
                'verification_results' => $verificationQuery->toArray()
            ]);

            // Refresh the opname to get updated items
            $opname->refresh();

            DB::commit();
            return response()->json([
                'opname' => $opname->load('items.product'),
                'adjustment' => $adjustment,
                'update_log' => $updateLog
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating stock adjustment', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ], 422);
        }
    }

    public function approve($id)
    {
        try {
            DB::beginTransaction();

            $opname = StockOpname::with('items.product')->findOrFail($id);

            if ($opname->status !== 'draft') {
                return response()->json([
                    'message' => 'Only draft stock opnames can be approved'
                ], 422);
            }

            // Check if any item has a difference
            $itemsWithDifferences = $opname->items->filter(function ($item) {
                return $item->system_stock !== $item->physical_stock;
            });

            // Create a stock adjustment for items with differences
            $adjustment = StockAdjustment::create([
                'date' => now()->toDateString(),
                'type' => 'in',
                'status' => 'draft',
                'notes' => "Stock Adjustment from Stock Opname #{$opname->id}",
                'created_by' => auth()->id(),
                'stock_opname_id' => $opname->id
            ]);

            // Process items with differences
            foreach ($itemsWithDifferences as $item) {
                $product = $item->product;
                $systemStock = $product->current_stock;
                $actualStock = $item->physical_stock;
                
                // Calculate the difference
                $stockDifference = $actualStock - $systemStock;

                // Create stock adjustment item
                StockAdjustmentItem::create([
                    'stock_adjustment_id' => $adjustment->id,
                    'product_id' => $product->id,
                    'quantity' => abs($stockDifference),
                    'notes' => $stockDifference > 0 
                        ? "Stock increase from Stock Opname" 
                        : "Stock reduction from Stock Opname"
                ]);

                // Update product stock
                $product->current_stock = $actualStock;
                $product->save();
            }

            // Explicitly update system stock for draft stock opname
            $opname->updateSystemStock();

            // Approve the stock adjustment
            $adjustment->update([
                'status' => 'approved',
                'approved_by' => auth()->id(),
                'approved_at' => now()
            ]);

            // Update the stock opname status
            $opname->update([
                'status' => 'approved',
                'approved_by' => auth()->id(),
                'approved_at' => now()
            ]);

            DB::commit();
            return response()->json([
                'opname' => $opname->load('items.product'),
                'adjustment' => $adjustment->load('items')
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error approving stock opname', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'message' => $e->getMessage()
            ], 422);
        }
    }

    public function report(Request $request)
    {
        $request->validate([
            'date_from' => 'required|date',
            'date_to' => 'required|date|after_or_equal:date_from'
        ]);

        $opnames = StockOpname::with(['items.product', 'creator', 'approver'])
            ->whereDate('created_at', '>=', $request->date_from)
            ->whereDate('created_at', '<=', $request->date_to)
            ->get();

        $summary = [
            'total_opnames' => $opnames->count(),
            'total_differences' => $opnames->sum('difference'),
            'total_approved' => $opnames->where('status', 'approved')->count(),
            'total_draft' => $opnames->where('status', 'draft')->count(),
        ];

        return response()->json([
            'opnames' => $opnames,
            'summary' => $summary
        ]);
    }

    /**
     * Manually update system stock for a draft stock opname
     */
    public function updateDraftSystemStock($id)
    {
        try {
            $opname = StockOpname::findOrFail($id);

            if ($opname->status !== 'draft') {
                return response()->json([
                    'message' => 'Only draft stock opnames can be updated'
                ], 422);
            }

            $opname->updateSystemStock();

            return response()->json([
                'message' => 'System stock updated successfully',
                'opname' => $opname->load('items.product')
            ]);

        } catch (\Exception $e) {
            Log::error('Error updating draft system stock', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'message' => $e->getMessage()
            ], 422);
        }
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Product;
use App\Models\User;
use App\Models\StockOpnameItem;
use Illuminate\Support\Facades\DB;

class StockOpname extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'stock_opnames';

    protected $fillable = [
        'date',
        'status',
        'notes',
        'created_by',
        'approved_by',
        'approved_at'
    ];

    protected $casts = [
        'date' => 'date',
        'approved_at' => 'datetime'
    ];

    public function items()
    {
        return $this->hasMany(StockOpnameItem::class);
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function approver()
    {
        return $this->belongsTo(User::class, 'approved_by');
    }

    public function scopeDraft($query)
    {
        return $query->where('status', 'draft');
    }

    public function scopePending($query)
    {
        return $query->where('status', 'pending');
    }

    public function scopeApproved($query)
    {
        return $query->where('status', 'approved');
    }

    public function scopeRejected($query)
    {
        return $query->where('status', 'rejected');
    }

    /**
     * Update system stock for draft stock opname
     * 
     * @return void
     */
    public function updateSystemStock()
    {
        // Only update if the stock opname is in draft status
        if ($this->status !== 'draft') {
            return;
        }

        // Begin transaction to ensure data integrity
        DB::transaction(function () {
            // Reload the items to ensure we have the latest data
            $this->load('items.product');

            foreach ($this->items as $item) {
                // Update system stock to match physical stock
                DB::table('stock_opname_items')
                    ->where('id', $item->id)
                    ->update([
                        'system_stock' => $item->physical_stock,
                        'difference' => 0
                    ]);

                // Optional: Update product current stock if needed
                $product = $item->product;
                $product->current_stock = $item->physical_stock;
                $product->save();
            }
        });
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($opname) {
            if (!$opname->status) {
                $opname->status = 'draft';
            }
        });

        static::updated(function ($opname) {
            // If status changes to approved
            if ($opname->isDirty('status') && $opname->status === 'approved') {
                // Update all related products stock
                foreach ($opname->items as $item) {
                    $product = $item->product;
                    $product->current_stock = $item->physical_stock;
                    $product->save();
                }
            }
        });
    }
}

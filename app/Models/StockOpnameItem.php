<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\StockOpname;

class StockOpnameItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'stock_opname_id',
        'product_id',
        'system_stock',
        'physical_stock',
        'difference',
        'notes'
    ];

    protected $casts = [
        'system_stock' => 'integer',
        'physical_stock' => 'integer',
        'difference' => 'integer'
    ];

    public function stockOpname()
    {
        return $this->belongsTo(StockOpname::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($item) {
            // Calculate difference if not set
            if (!isset($item->difference)) {
                $item->difference = $item->physical_stock - $item->system_stock;
            }
        });

        static::updating(function ($item) {
            // Recalculate difference if physical or system stock changes
            if ($item->isDirty(['physical_stock', 'system_stock'])) {
                $item->difference = $item->physical_stock - $item->system_stock;
            }
        });

        static::updated(function ($item) {
            // If stock opname is approved, update product stock
            if ($item->stockOpname->status === 'approved') {
                $product = $item->product;
                $product->current_stock = $item->physical_stock;
                $product->save();
            }
        });
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class StockAdjustmentItem extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'stock_adjustment_id',
        'product_id',
        'quantity',
        'notes',
        'status'
    ];

    protected $casts = [
        'status' => 'string'
    ];

    public function stockAdjustment()
    {
        return $this->belongsTo(StockAdjustment::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function setStatus($status)
    {
        $validStatuses = ['Normal', 'Rusak', 'Hilang', 'Expired'];
        
        if (!in_array($status, $validStatuses)) {
            throw new \InvalidArgumentException("Status tidak valid. Gunakan: " . implode(', ', $validStatuses));
        }

        $this->status = $status;
        $this->save();

        return $this;
    }
}

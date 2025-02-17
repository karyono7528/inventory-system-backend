<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Product;
use App\Models\User;
use App\Models\StockAdjustmentItem;

class StockAdjustment extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'date',
        'type',
        'status',
        'notes',
        'created_by',
        'approved_by',
        'rejected_by',
        'approved_at',
        'rejected_at'
    ];

    protected $casts = [
        'date' => 'date',
        'approved_at' => 'datetime',
        'rejected_at' => 'datetime'
    ];

    protected $with = ['items'];

    public function items()
    {
        return $this->hasMany(StockAdjustmentItem::class);
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function approver()
    {
        return $this->belongsTo(User::class, 'approved_by');
    }

    public function rejecter()
    {
        return $this->belongsTo(User::class, 'rejected_by');
    }

    public function scopeDraft($query)
    {
        return $query->where('status', 'draft');
    }

    public function scopeApproved($query)
    {
        return $query->where('status', 'approved');
    }

    public function scopeRejected($query)
    {
        return $query->where('status', 'rejected');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($adjustment) {
            if (!$adjustment->status) {
                $adjustment->status = 'draft';
            }
        });

        static::updated(function ($adjustment) {
            if ($adjustment->isDirty('status') && $adjustment->status === 'approved') {
                // Update stock logic can be added here if needed
            }
        });
    }
}

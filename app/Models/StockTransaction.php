<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Product;
use App\Models\User;
use App\Models\Vendor;
use Carbon\Carbon;

class StockTransaction extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'product_id',
        'vendor_id',
        'transaction_type',
        'quantity',
        'unit_price',
        'total_price',
        'transaction_date',
        'reference_number',
        'notes',
        'created_by'
    ];

    protected $casts = [
        'quantity' => 'decimal:2',
        'unit_price' => 'decimal:2',
        'total_price' => 'decimal:2',
        'transaction_date' => 'date'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function setTransactionDate($date)
    {
        $this->transaction_date = $date ? Carbon::parse($date) : null;
        $this->save();

        return $this;
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($transaction) {
            $transaction->total_price = $transaction->quantity * $transaction->unit_price;
        });

        static::created(function ($transaction) {
            if ($transaction->transaction_type === 'in') {
                $transaction->product->increment('current_stock', $transaction->quantity);
            } else {
                $transaction->product->decrement('current_stock', $transaction->quantity);
            }
        });
    }
}

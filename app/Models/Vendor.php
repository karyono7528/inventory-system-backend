<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\StockTransaction;

class Vendor extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'name',
        'email',
        'phone',
        'address',
        'contact_person',
        'is_active',
        'notes'
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    protected $appends = [
        'total_transactions',
        'last_transaction_date'
    ];

    public function stockTransactions()
    {
        return $this->hasMany(StockTransaction::class);
    }

    public function getTotalTransactionsAttribute()
    {
        return $this->stockTransactions()->count();
    }

    public function getLastTransactionDateAttribute()
    {
        $lastTransaction = $this->stockTransactions()->latest()->first();
        return $lastTransaction ? $lastTransaction->created_at : null;
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeSearch($query, $search)
    {
        return $query->where(function($q) use ($search) {
            $q->where('name', 'like', "%{$search}%")
              ->orWhere('email', 'like', "%{$search}%")
              ->orWhere('phone', 'like', "%{$search}%")
              ->orWhere('contact_person', 'like', "%{$search}%");
        });
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($vendor) {
            // Ensure email is lowercase
            $vendor->email = strtolower($vendor->email);
        });

        static::updating(function ($vendor) {
            // Ensure email is lowercase
            if ($vendor->isDirty('email')) {
                $vendor->email = strtolower($vendor->email);
            }
        });
    }
}

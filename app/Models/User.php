<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\SoftDeletes;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function isAdmin()
    {
        return $this->role === 'admin';
    }

    public function isManager()
    {
        return $this->role === 'manager';
    }

    public function isWarehouse()
    {
        return $this->role === 'warehouse';
    }

    public function isStaff()
    {
        return $this->role === 'staff';
    }

    public function hasRole($role)
    {
        return $this->role === $role;
    }

    public function hasAnyRole($roles)
    {
        return in_array($this->role, (array) $roles);
    }

    public function scopeAdmin($query)
    {
        return $query->where('role', 'admin');
    }

    public function scopeManager($query)
    {
        return $query->where('role', 'manager');
    }

    public function scopeWarehouse($query)
    {
        return $query->where('role', 'warehouse');
    }

    public function scopeStaff($query)
    {
        return $query->where('role', 'staff');
    }

    public function createdProducts()
    {
        return $this->hasMany(Product::class, 'created_by');
    }

    public function createdVendors()
    {
        return $this->hasMany(Vendor::class, 'created_by');
    }

    public function createdStockTransactions()
    {
        return $this->hasMany(StockTransaction::class, 'created_by');
    }

    public function createdStockOpnames()
    {
        return $this->hasMany(StockOpname::class, 'created_by');
    }

    public function approvedStockOpnames()
    {
        return $this->hasMany(StockOpname::class, 'approved_by');
    }

    public function createdStockAdjustments()
    {
        return $this->hasMany(StockAdjustment::class, 'created_by');
    }

    public function approvedStockAdjustments()
    {
        return $this->hasMany(StockAdjustment::class, 'approved_by');
    }
}

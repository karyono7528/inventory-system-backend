<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\StockTransaction;
use App\Models\StockOpnameItem;
use App\Models\StockAdjustment;

class Product extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'sku',
        'name',
        'description',
        'category',
        'minimum_stock',
        'unit',
        'average_cost',
        'current_stock',
        'is_active'
    ];

    protected $casts = [
        'minimum_stock' => 'decimal:2',
        'average_cost' => 'decimal:2',
        'current_stock' => 'decimal:2',
        'is_active' => 'boolean'
    ];

    public function stockTransactions()
    {
        return $this->hasMany(StockTransaction::class);
    }

    public function stockOpnameItems()
    {
        return $this->hasMany(StockOpnameItem::class);
    }

    public function stockAdjustments()
    {
        return $this->hasMany(StockAdjustment::class);
    }

    public function updateAverageCost($newQuantity, $newUnitPrice)
    {
        if ($newQuantity <= 0 || $newUnitPrice <= 0) {
            return;
        }

        $currentStock = $this->current_stock ?? 0;
        $currentAvgCost = $this->average_cost ?? 0;

        $totalCurrentValue = $currentStock * $currentAvgCost;
        $newValue = $newQuantity * $newUnitPrice;

        $totalQuantity = $currentStock + $newQuantity;
        $newAverageCost = ($totalCurrentValue + $newValue) / $totalQuantity;

        $this->average_cost = $newAverageCost;
        $this->save();
    }
}

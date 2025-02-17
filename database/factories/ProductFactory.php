<?php

namespace Database\Factories;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    protected $model = Product::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $categories = ['Electronics', 'Office Supplies', 'Furniture', 'Tools', 'Accessories'];
        $units = ['pcs', 'box', 'set', 'unit', 'pack'];
        
        return [
            'sku' => 'SKU-' . strtoupper(fake()->unique()->bothify('??###')),
            'name' => fake()->words(3, true),
            'description' => fake()->paragraph(),
            'category' => fake()->randomElement($categories),
            'minimum_stock' => fake()->numberBetween(5, 20),
            'unit' => fake()->randomElement($units),
            'current_stock' => 0, // Will be updated by stock transactions
            'average_cost' => 0, // Will be updated by stock transactions
            'is_active' => true,
            'created_by' => 1, // admin user
        ];
    }
}

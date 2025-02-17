<?php

namespace Database\Factories;

use App\Models\StockOpname;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\StockOpname>
 */
class StockOpnameFactory extends Factory
{
    protected $model = StockOpname::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $product = Product::inRandomOrder()->first() ?? Product::factory()->create();
        
        return [
            'product_id' => $product->id,
            'system_stock' => $product->current_stock,
            'physical_stock' => function (array $attributes) {
                return fake()->numberBetween(
                    (int)($attributes['system_stock'] * 0.8),
                    (int)($attributes['system_stock'] * 1.2)
                );
            },
            'status' => fake()->randomElement(['draft', 'approved']),
            'notes' => fake()->optional()->sentence(),
            'created_by' => User::factory(),
            'approved_by' => function (array $attributes) {
                return $attributes['status'] === 'approved' 
                    ? User::factory()->manager()->create()->id 
                    : null;
            },
        ];
    }

    public function approved(): static
    {
        return $this->state(function (array $attributes) {
            return [
                'status' => 'approved',
                'approved_by' => User::factory()->manager()->create()->id,
            ];
        });
    }

    public function draft(): static
    {
        return $this->state(function (array $attributes) {
            return [
                'status' => 'draft',
                'approved_by' => null,
            ];
        });
    }
}

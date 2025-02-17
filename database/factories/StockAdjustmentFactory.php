<?php

namespace Database\Factories;

use App\Models\StockAdjustment;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\StockAdjustment>
 */
class StockAdjustmentFactory extends Factory
{
    protected $model = StockAdjustment::class;

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
            'adjustment_type' => fake()->randomElement(['addition', 'reduction']),
            'quantity' => fake()->numberBetween(1, 50),
            'reason' => fake()->randomElement([
                'Damaged goods',
                'Lost in transit',
                'Found additional stock',
                'Quality control rejection',
                'Inventory count adjustment'
            ]),
            'status' => fake()->randomElement(['pending', 'approved', 'rejected']),
            'notes' => fake()->optional()->sentence(),
            'created_by' => User::factory(),
            'approved_by' => function (array $attributes) {
                return in_array($attributes['status'], ['approved', 'rejected'])
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

    public function rejected(): static
    {
        return $this->state(function (array $attributes) {
            return [
                'status' => 'rejected',
                'approved_by' => User::factory()->manager()->create()->id,
            ];
        });
    }

    public function pending(): static
    {
        return $this->state(function (array $attributes) {
            return [
                'status' => 'pending',
                'approved_by' => null,
            ];
        });
    }
}

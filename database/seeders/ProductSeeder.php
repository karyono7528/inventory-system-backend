<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        $products = [
            [
                'sku' => 'SKU001',
                'name' => 'Product 1',
                'description' => 'Description for Product 1',
                'category' => 'Category A',
                'minimum_stock' => 10,
                'unit' => 'pcs',
                'average_cost' => 100,
                'current_stock' => 87,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU002',
                'name' => 'Product 2',
                'description' => 'Description for Product 2',
                'category' => 'Category A',
                'minimum_stock' => 15,
                'unit' => 'pcs',
                'average_cost' => 150,
                'current_stock' => 95,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU003',
                'name' => 'Product 3',
                'description' => 'Description for Product 3',
                'category' => 'Category B',
                'minimum_stock' => 20,
                'unit' => 'pcs',
                'average_cost' => 200,
                'current_stock' => 117,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU004',
                'name' => 'Product 4',
                'description' => 'Description for Product 4',
                'category' => 'Category B',
                'minimum_stock' => 10,
                'unit' => 'pcs',
                'average_cost' => 120,
                'current_stock' => 53,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU005',
                'name' => 'Product 5',
                'description' => 'Description for Product 5',
                'category' => 'Category C',
                'minimum_stock' => 25,
                'unit' => 'pcs',
                'average_cost' => 180,
                'current_stock' => 172,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU006',
                'name' => 'Product 6',
                'description' => 'Description for Product 6',
                'category' => 'Category C',
                'minimum_stock' => 15,
                'unit' => 'pcs',
                'average_cost' => 90,
                'current_stock' => 102,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU007',
                'name' => 'Product 7',
                'description' => 'Description for Product 7',
                'category' => 'Category A',
                'minimum_stock' => 12,
                'unit' => 'pcs',
                'average_cost' => 110,
                'current_stock' => 79,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU008',
                'name' => 'Product 8',
                'description' => 'Description for Product 8',
                'category' => 'Category B',
                'minimum_stock' => 18,
                'unit' => 'pcs',
                'average_cost' => 160,
                'current_stock' => 149,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU009',
                'name' => 'Product 9',
                'description' => 'Description for Product 9',
                'category' => 'Category C',
                'minimum_stock' => 22,
                'unit' => 'pcs',
                'average_cost' => 140,
                'current_stock' => 159,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU010',
                'name' => 'Product 10',
                'description' => 'Description for Product 10',
                'category' => 'Category A',
                'minimum_stock' => 20,
                'unit' => 'pcs',
                'average_cost' => 130,
                'current_stock' => 143,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU011',
                'name' => 'Product 11',
                'description' => 'Description for Product 11',
                'category' => 'Category B',
                'minimum_stock' => 15,
                'unit' => 'pcs',
                'average_cost' => 170,
                'current_stock' => 96,
                'is_active' => true,
            ],
            [
                'sku' => 'SKU012',
                'name' => 'Product 12',
                'description' => 'Description for Product 12',
                'category' => 'Category C',
                'minimum_stock' => 25,
                'unit' => 'pcs',
                'average_cost' => 190,
                'current_stock' => 194,
                'is_active' => true,
            ],
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}

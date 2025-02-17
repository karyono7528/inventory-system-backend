<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\StockOpname;
use App\Models\StockOpnameItem;
use App\Models\Product;
use App\Models\User;
use Carbon\Carbon;

class StockOpnameSeeder extends Seeder
{
    public function run(): void
    {
        // Get admin user for created_by
        $admin = User::where('role', 'admin')->first();
        if (!$admin) {
            $admin = User::factory()->create([
                'name' => 'Admin User',
                'email' => 'admin@example.com',
                'password' => bcrypt('password'),
                'role' => 'admin'
            ]);
        }

        // Get manager user for approver
        $manager = User::where('role', 'manager')->first();
        if (!$manager) {
            $manager = User::factory()->create([
                'name' => 'Manager User',
                'email' => 'manager@example.com',
                'password' => bcrypt('password'),
                'role' => 'manager'
            ]);
        }

        // Get some products
        $products = Product::all();
        if ($products->isEmpty()) {
            // Create some products if none exist
            $products = collect([
                [
                    'name' => 'Product A',
                    'category' => 'Electronics',
                    'current_stock' => 100,
                    'minimum_stock' => 10,
                ],
                [
                    'name' => 'Product B',
                    'category' => 'Electronics',
                    'current_stock' => 50,
                    'minimum_stock' => 5,
                ],
                [
                    'name' => 'Product C',
                    'category' => 'Office',
                    'current_stock' => 200,
                    'minimum_stock' => 20,
                ],
                [
                    'name' => 'Product D',
                    'category' => 'Office',
                    'current_stock' => 75,
                    'minimum_stock' => 15,
                ],
            ])->map(function ($product) {
                return Product::create($product);
            });
        }

        // Create stock opnames with different statuses
        $statuses = ['draft', 'pending', 'approved', 'rejected'];
        $dates = [
            Carbon::now()->subDays(7),
            Carbon::now()->subDays(5),
            Carbon::now()->subDays(3),
            Carbon::now(),
        ];

        foreach ($statuses as $index => $status) {
            $stockOpname = StockOpname::create([
                'date' => $dates[$index],
                'status' => $status,
                'created_by' => $admin->id,
                'approved_by' => in_array($status, ['approved', 'rejected']) ? $manager->id : null,
                'approved_at' => in_array($status, ['approved', 'rejected']) ? $dates[$index] : null,
                'notes' => "Stock opname for {$dates[$index]->format('Y-m-d')}"
            ]);

            // Create items for each stock opname
            foreach ($products as $product) {
                // Generate some random variations in physical stock
                $systemStock = $product->current_stock;
                $variation = rand(-5, 5); // Random variation between -5 and +5
                $physicalStock = max(0, $systemStock + $variation);

                StockOpnameItem::create([
                    'stock_opname_id' => $stockOpname->id,
                    'product_id' => $product->id,
                    'system_stock' => $systemStock,
                    'physical_stock' => $physicalStock,
                    'difference' => $physicalStock - $systemStock,
                    'notes' => $variation !== 0 ? 
                        ($variation > 0 ? "Found extra stock" : "Missing stock") : 
                        "Stock matches system"
                ]);
            }
        }
    }
}

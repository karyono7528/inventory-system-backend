<?php
 
namespace Database\Seeders;
 
use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Product;
use App\Models\Vendor;
use App\Models\StockTransaction;
use App\Models\StockOpname;
use App\Models\StockAdjustment;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // // Create admin user
        // $admin = User::create([
        //     'name' => 'Admin User',
        //     'email' => 'admin@example.com',
        //     'password' => Hash::make('password'),
        //     'role' => 'admin'
        // ]);

        // // Create manager user
        // $manager = User::create([
        //     'name' => 'Manager User',
        //     'email' => 'manager@example.com',
        //     'password' => Hash::make('password'),
        //     'role' => 'manager'
        // ]);

        // // Create staff user
        // $staff = User::create([
        //     'name' => 'Staff User',
        //     'email' => 'staff@example.com',
        //     'password' => Hash::make('password'),
        //     'role' => 'staff'
        // ]);

        // Create vendors
        $vendors = [];
        for ($i = 1; $i <= 5; $i++) {
            $vendors[] = Vendor::create([
                'name' => "Vendor $i",
                'email' => "vendor$i@example.com",
                'phone' => "08123456789$i",
                'address' => "Address for vendor $i"
            ]);
        }

        // Create products with categories
        $categories = ['Electronics', 'Office', 'Furniture', 'Stationery'];
        $products = [];
        
        foreach ($categories as $category) {
            for ($i = 1; $i <= 3; $i++) {
                $products[] = Product::create([
                    'sku' => 'SKU00'.$i+25,
                    'name' => "$category Product $i",
                    'category' => $category,
                    'description' => "Description for $category product $i",
                    'current_stock' => rand(50, 200),
                    'minimum_stock' => rand(10, 30)
                ]);
            }
        }

        // Run stock opname seeder
        // $this->call([
        //     UserSeeder::class,
        // ]);
    }
}

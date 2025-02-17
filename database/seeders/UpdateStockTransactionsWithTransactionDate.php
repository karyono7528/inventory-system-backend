<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\StockTransaction;
use Carbon\Carbon;

class UpdateStockTransactionsWithTransactionDate extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Update semua transaksi yang belum memiliki tanggal transaksi
        StockTransaction::whereNull('transaction_date')->update([
            'transaction_date' => Carbon::now()->format('Y-m-d')
        ]);
    }
}

<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\VendorController;
use App\Http\Controllers\Api\StockTransactionController;
use App\Http\Controllers\Api\StockOpnameController;
use App\Http\Controllers\Api\StockAdjustmentController;
use App\Http\Controllers\Api\StockReportController;

// Public routes
Route::prefix('auth')->group(function () {
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/register', [AuthController::class, 'register'])->middleware('role:admin');

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/user', [AuthController::class, 'user']);
    });
});

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Products
    Route::get('/products', [ProductController::class, 'index']);
    Route::get('/products/low-stock', [ProductController::class, 'lowStock']);
    Route::get('/products/{product}', [ProductController::class, 'show']);
    Route::get('/products/{product}/stock-movement', [ProductController::class, 'stockMovement']);

    // Route::middleware('role:admin,manager,warehouse')->group(function () {
    Route::post('/products', [ProductController::class, 'store']);
    Route::put('/products/{sku}', [ProductController::class, 'update']);
    Route::delete('/products/{sku}', [ProductController::class, 'destroy']);
    Route::post('/products/{sku}/restore', [ProductController::class, 'restore']);
    // });

    // Vendors
    // Route::middleware('role:admin,manager')->group(function () {
        Route::apiResource('vendors', VendorController::class);
        Route::get('vendors/{vendor}/transactions', [VendorController::class, 'transactions']);
    // });

    // Stock Transactions
    Route::get('/stock-transactions', [StockTransactionController::class, 'index']);
    Route::get('/stock-transactions/{transaction}', [StockTransactionController::class, 'show']);
    Route::post('/stock-transactions', [StockTransactionController::class, 'store']);
    Route::put('/stock-transactions/{transaction}', [StockTransactionController::class, 'update']);
    Route::delete('/stock-transactions/{transaction}/destroy', [StockTransactionController::class, 'destroy']);

    // Stock Opname
    Route::get('/stock-opnames', [StockOpnameController::class, 'index']);
    Route::post('/stock-opnames', [StockOpnameController::class, 'store']);
    Route::get('/stock-opnames/{opname}', [StockOpnameController::class, 'show']);
    Route::put('/stock-opnames/{opname}', [StockOpnameController::class, 'update']);
    Route::post('/stock-opnames/{opname}/approve', [StockOpnameController::class, 'approve']);
    Route::post('/stock-opnames/{opname}/create-adjustment', [StockOpnameController::class, 'createStockAdjustment']);
    Route::post('/stock-opnames/{opname}/update-system-stock', [StockOpnameController::class, 'updateDraftSystemStock']);

    // Stock Adjustments
    Route::get('/stock-adjustments', [StockAdjustmentController::class, 'index']);
    Route::post('/stock-adjustment', [StockAdjustmentController::class, 'store']);
    Route::get('/stock-adjustments/{id}', [StockAdjustmentController::class, 'show']);
    Route::put('/stock-adjustments/{id}/approve', [StockAdjustmentController::class, 'approve']);
    Route::put('/stock-adjustments/{id}/reject', [StockAdjustmentController::class, 'reject']);

    // Laporan
    Route::prefix('reports')->group(function () {
        // Laporan Status Stok
        Route::get('/stock-status', [StockReportController::class, 'stockStatus']);
        
        // Laporan Transaksi
        Route::get('/transactions', [StockReportController::class, 'transactionReport']);
        
        // Laporan Penilaian Inventori
        Route::get('/inventory-valuation', [StockReportController::class, 'inventoryValuation']);
    });
});
Route::get('/test', function () {
    return response()->json(['message' => 'Backend is working']);
});

Route::post('/stock-adjustments', [StockAdjustmentController::class, 'store']);
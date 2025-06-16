<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\KaryawanController;
use App\Http\Controllers\Api\KategoriController;
use App\Http\Controllers\Api\MetodePembayaranController;
use App\Http\Controllers\Api\PembelianController;
use App\Http\Controllers\Api\ProdukController;
use App\Http\Controllers\Api\TransaksiController;
use App\Http\Controllers\Api\TransaksiItemController;
use App\Http\Controllers\Api\ExportController;
use App\Http\Controllers\ReportController;
use Illuminate\Support\Facades\Route;


Route::prefix('auth')->group(function () {
    Route::post('/login', [AuthController::class, 'login']);

    Route::get('/verify-email/{id}/{hash}', [AuthController::class, 'verifyEmail'])
        ->name('verification.verify');

    Route::middleware(['throttle:6,1'])->group(function () {
        Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
        Route::post('/verify-verification-code', [AuthController::class, 'verifyVerificationCode']);
        Route::post('/resend-verification-code', [AuthController::class, 'resendVerificationCode']);
        Route::post('/reset-password', [AuthController::class, 'resetPassword']);
    });

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::post('/update-profile-picture', [AuthController::class, 'updateProfilePicture']);
        Route::get('/profile', [AuthController::class, 'getProfile']);
        Route::post('/change-password', [AuthController::class, 'resetPasswordV2']);
    });
});
Route::get('/dashboard/pdf', [DashboardController::class, 'downloadPDF']);

Route::get('/export-pdf', [DashboardController::class, 'exportPdf']);
Route::get('/dashboard/analytics', [DashboardController::class, 'getAnalytics']);


Route::middleware(['auth:sanctum'])->group(function () {


    Route::get('kategori', [KategoriController::class, 'index']);
    Route::get('produk', [ProdukController::class, 'index']);
    Route::get('metode-pembayaran', [MetodePembayaranController::class, 'index']);

    Route::apiResource('transaksi', TransaksiController::class)->only(['index', 'store']);
    Route::apiResource('transaksi-item', TransaksiItemController::class)->only(['index', 'destroy']);
    Route::get('/transaksi/{id}/cetak', [TransaksiController::class, 'cetak']);


    // Export
    Route::post('/export/transactions', [ExportController::class, 'exportTransactionsPdf']);
    Route::post('/export/pembelian', [ExportController::class, 'exportPembelianPdf']);
    // End Export

    Route::middleware(['role:Admin'])->prefix('admin')->group(function () {
        Route::apiResource('karyawan', KaryawanController::class);
        Route::apiResource('kategori', KategoriController::class)->except(['index', 'view']);

        Route::apiResource('produk', ProdukController::class)->except(['store', 'view']);
        Route::get('/produk/{id}/restore', [ProdukController::class, 'restore']);
        Route::get('/produk/print-pdf', [ProdukController::class, 'printPdf']);


        Route::apiResource('pembelian', PembelianController::class)->only(['index', 'store']);
        Route::get('/pembelian/print-pdf', [PembelianController::class, 'printPdf']);
        Route::post('/{id}/tambah-stok', [PembelianController::class, 'tambahStok']);

        Route::apiResource('metode-pembayaran', MetodePembayaranController::class)->only(['store']);
    });
});

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Produk;
use App\Models\Transaksi;
use App\Models\TransaksiItem;
use App\Models\Pembelian;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function getAnalytics(Request $request)
    {
        $bulan = $request->query('bulan');
        $tahun = $request->query('tahun');

        if (!$bulan || !$tahun) {
            return response()->json(['message' => 'Bulan dan tahun wajib diisi'], 400);
        }

        $startOfMonth = Carbon::createFromDate($tahun, $bulan, 1)->startOfMonth();
        $endOfMonth = Carbon::createFromDate($tahun, $bulan, 1)->endOfMonth();

        $pemasukan = (int) Transaksi::whereBetween('created_at', [$startOfMonth, $endOfMonth])->sum('final_amount');
        $totalTransaksi = Transaksi::whereBetween('created_at', [$startOfMonth, $endOfMonth])->count();
        $totalProdukTerjual = (int) TransaksiItem::whereBetween('created_at', [$startOfMonth, $endOfMonth])->sum('jumlah');
        $totalProduk = Produk::count();

        $pengeluaran = (int) TransaksiItem::join('produk', 'transaksi_item.produk_id', '=', 'produk.id')
            ->whereBetween('transaksi_item.created_at', [$startOfMonth, $endOfMonth])
            ->sum(DB::raw('transaksi_item.jumlah * produk.harga_beli'));

        $labaBersih = $pemasukan - $pengeluaran;

        $pendapatanPerHari = Transaksi::select(
            DB::raw('DATE(created_at) as tanggal'),
            DB::raw('SUM(final_amount) as total_harian')
        )
            ->whereBetween('created_at', [$startOfMonth, $endOfMonth])
            ->groupBy('tanggal')
            ->orderBy('tanggal', 'asc')
            ->get()
            ->pluck('total_harian', 'tanggal');

        $grafikLabels = [];
        $grafikData = [];
        $currentDate = $startOfMonth->copy();

        while ($currentDate <= $endOfMonth) {
            $dateString = $currentDate->toDateString();
            $grafikLabels[] = $dateString;
            $grafikData[] = $pendapatanPerHari->get($dateString, 0);
            $currentDate->addDay();
        }

        $grafikPendapatan = [
            'labels' => $grafikLabels,
            'data' => $grafikData,
        ];

        $produkTerlaris = TransaksiItem::select(
            'produk.nama_produk',
            DB::raw('SUM(transaksi_item.jumlah) as total_terjual')
        )
            ->join('produk', 'transaksi_item.produk_id', '=', 'produk.id')
            ->whereBetween('transaksi_item.created_at', [$startOfMonth, $endOfMonth])
            ->groupBy('produk.id', 'produk.nama_produk')
            ->orderByDesc('total_terjual')
            ->limit(5)
            ->get();

        $analyticsData = [
            'laba_bersih' => $labaBersih,
            'pemasukan' => $pemasukan,
            'pengeluaran' => $pengeluaran,
            'total_transaksi' => $totalTransaksi,
            'total_produk_terjual' => $totalProdukTerjual,
            'total_produk' => $totalProduk,
            'grafik_pendapatan' => $grafikPendapatan,
            'produk_terlaris' => $produkTerlaris,
        ];

        return response()->json(['data' => $analyticsData]);
    }

    public function downloadPDF(Request $request)
{
    $bulan = $request->query('bulan');
    $tahun = $request->query('tahun');

    if (!$bulan || !$tahun) {
        return response()->json(['message' => 'Bulan dan tahun wajib diisi'], 400);
    }

    // Ambil data analytics
    $request->merge(['bulan' => $bulan, 'tahun' => $tahun]);
    $analyticsResponse = $this->getAnalytics($request);
    $analyticsData = $analyticsResponse->getData()->data ?? [];

    $pdf = Pdf::loadView('pdf.dashboard', [
        'bulan' => $bulan,
        'tahun' => $tahun,
        'data' => $analyticsData
    ]);

    $namaFile = 'laporan-dashboard-' . $bulan . '-' . $tahun . '.pdf';
    return $pdf->download($namaFile);
}
}

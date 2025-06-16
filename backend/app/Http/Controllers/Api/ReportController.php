<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Models\Transaksi;
use App\Models\Produk;
use Carbon\Carbon;

class ReportController extends Controller
{
    public function exportPdf(Request $request)
    {
        $tipe = $request->query('tipe', 'Hari');
        $tanggal = $request->query('tanggal', Carbon::today()->format('d - F - Y'));

        $pemasukan = Transaksi::where('tipe', 'pemasukan')->sum('jumlah');
        $pengeluaran = Transaksi::where('tipe', 'pengeluaran')->sum('jumlah');
        $laba_bersih = $pemasukan - $pengeluaran;
        $total_transaksi = Transaksi::count();
        $total_produk_terjual = Transaksi::where('tipe', 'penjualan')->sum('jumlah_produk');
        $total_produk = Produk::count();

        $data = [
            'tipe' => $tipe,
            'tanggal' => $tanggal,
            'laba_bersih' => 'Rp ' . number_format($laba_bersih, 0, ',', '.'),
            'pemasukan' => 'Rp ' . number_format($pemasukan, 0, ',', '.'),
            'pengeluaran' => 'Rp ' . number_format($pengeluaran, 0, ',', '.'),
            'total_transaksi' => $total_transaksi,
            'total_produk_terjual' => $total_produk_terjual,
            'total_produk' => $total_produk,
        ];

        $pdf = Pdf::loadView('pdf.dashboard', $data);
        return $pdf->download('laporan-dashboard.pdf');
    }
}

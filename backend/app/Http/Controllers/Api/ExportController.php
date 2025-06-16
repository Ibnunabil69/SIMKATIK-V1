<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;

class ExportController extends Controller
{
    //
    public function exportTransactionsPdf(Request $request)
    {
        $data = [
            'transactions' => $request->transactions,
            'title' => 'Laporan Transaksi & Penjualan',
            'date' => date('d-m-Y')
        ];

        $pdf = Pdf::loadView('pdf.transaction-report', $data)
            ->setPaper('a4', 'landscape')
            ->setOption('isHtml5ParserEnabled', true)
            ->setOption('isRemoteEnabled', true);


        return $pdf->download('laporan-transaksi-' . date('Y-m-d') . '.pdf');
    }

    public function exportPembelianPdf(Request $request)
    {
        $data = [
            'purchases' => $request->purchases,
            'title' => 'Laporan Pembelian',
            'date' => date('d-m-Y')
        ];

        $pdf = Pdf::loadView('pdf.pembelian-report', $data)
            ->setPaper('a4', 'landscape')
            ->setOption('isHtml5ParserEnabled', true)
            ->setOption('isRemoteEnabled', true);


        return $pdf->download('laporan-pembelian-' . date('Y-m-d') . '.pdf');
    }
}

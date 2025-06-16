<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Produk;
use App\Models\Transaksi;
use App\Models\TransaksiItem;
use Illuminate\Support\Facades\Storage;
use Exception;
use PDF;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class TransaksiController extends Controller
{
    public function index()
    {
        $transaksi = Transaksi::with(['items.produk', 'metode_pembayaran', 'user'])->latest()->get();
        return response()->json([
            'status' => true,
            'message' => 'Data transaksi berhasil diambil',
            'data' => $transaksi
        ]);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'metode_pembayaran_id' => 'required|exists:metode_pembayaran,id',
            'items' => 'required|array',
            'items.*.produk_id' => 'required|exists:produk,id',
            'items.*.jumlah' => 'required|integer|min:1'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            DB::beginTransaction();

            $total_harga = 0;
            foreach ($request->items as $item) {
                $produk = Produk::find($item['produk_id']);
                $total_harga += $produk->harga_jual * $item['jumlah'];
            }

            $transaksi = Transaksi::create([
                'users_id' => Auth::id(),
                'total_harga' => $total_harga,
                'final_amount' => $total_harga,
                'metode_pembayaran_id' => $request->metode_pembayaran_id
            ]);

            foreach ($request->items as $item) {
                $produk = Produk::find($item['produk_id']);
                if ($produk->stok < $item['jumlah']) {
                    return response()->json([
                        'status' => false,
                        'message' => "Stok produk {$produk->nama_produk} tidak mencukupi",
                    ], 400);
                }

                $produk->stok -= $item['jumlah'];
                $produk->save();

                $subtotal = $produk->harga_jual * $item['jumlah'];

                TransaksiItem::create([
                    'transaksi_id' => $transaksi->id,
                    'produk_id' => $item['produk_id'],
                    'jumlah' => $item['jumlah'],
                    'subtotal' => $subtotal
                ]);
            }

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Transaksi berhasil disimpan',
                'data' => $transaksi->load('items.produk', 'metode_pembayaran', 'user')
            ], 201);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => false,
                'message' => 'Terjadi kesalahan saat menyimpan transaksi',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function cetak($id)
    {
        $transaksi = Transaksi::with(['items.produk', 'metode_pembayaran', 'user'])->findOrFail($id);

        $pdf = PDF::loadView('pdf.struk', compact('transaksi'));

        // Nama file
        $filename = 'struk-transaksi-' . $transaksi->id . '-' . time() . '.pdf';

        // Simpan ke folder public storage
        Storage::put('public/struk/' . $filename, $pdf->output());

        // Buat URL untuk diakses publik
        $url = asset('storage/struk/' . $filename);

        return response()->json([
            'status' => true,
            'message' => 'Struk berhasil dibuat',
            'url' => $url
        ]);
    }
}

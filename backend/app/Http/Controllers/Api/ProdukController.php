<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Produk;
use Barryvdh\DomPDF\Facade\Pdf;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Log;

class ProdukController extends Controller
{
    public function index()
    {
        try {
            $produk = Produk::with('kategori')->latest()->get();

            return response()->json([
                'status' => true,
                'message' => 'Data produk berhasil diambil',
                'data' => $produk
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Terjadi kesalahan sistem',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        $produk = Produk::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'nama_produk' => "sometimes|required|string|max:255|unique:produk,nama_produk,{$produk->id}",
            'kategori_id' => 'sometimes|required|exists:kategori,id',
            'harga_jual' => 'sometimes|required|numeric|min:0',
            'diskon' => 'nullable|numeric|min:0',
            'gambar_produk' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        $validatedData = $validator->validated();

        if ($request->hasFile('gambar_produk')) {
            $newImagePath = $request->file('gambar_produk')->store('produk', 'public');
            Log::info('Attempting to store image. Resulting path:', ['path' => $newImagePath]);

            if (!$newImagePath) {
                Log::error('Failed to store image file.');
                return response()->json([
                    'status' => false,
                    'message' => 'Gagal menyimpan gambar produk.',
                ], 500);
            }

            if ($produk->gambar_produk && Storage::disk('public')->exists($produk->gambar_produk)) {
                Storage::disk('public')->delete($produk->gambar_produk);
            }
            $validatedData['gambar_produk'] = $newImagePath;

        } else {
            unset($validatedData['gambar_produk']);
        }

        $produk->update($validatedData);
        return response()->json([
            'status' => true,
            'message' => 'Data produk berhasil diperbarui',
            'data' => $produk->refresh()
        ]);
    }


    public function destroy($id)
    {
        $produk = Produk::findOrFail($id);

        if ($produk->stock > 0) {
            return response()->json([
                'status' => false,
                'message' => 'Produk tidak dapat dihapus karena stok masih tersedia.'
            ], 400);
        }

        $produk->delete();

        return response()->json([
            'status' => true,
            'message' => 'Data produk berhasil dihapus'
        ]);
    }

    public function restore($id)
    {
        $produk = Produk::onlyTrashed()->findOrFail($id);
        $produk->restore();

        return response()->json([
            'status' => true,
            'message' => 'Produk berhasil dikembalikan',
            'data' => $produk
        ]);
    }


    public function printPdf()
    {
        $produk = Produk::all();

        if ($produk->isEmpty()) {
            return response()->json([
                'status' => false,
                'message' => 'Tidak ada produk yang ditemukan.'
            ], 404);
        }

        $pdf = Pdf::loadView('produk.pdf', compact('produk'));

        if (request()->query('action') === 'download') {
            return $pdf->download("laporan_semua_produk.pdf");
        }

        return $pdf->stream("laporan_semua_produk.pdf");
    }
}

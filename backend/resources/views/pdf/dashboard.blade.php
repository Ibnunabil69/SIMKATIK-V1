<!DOCTYPE html>
<html>
<head>
    <title>Laporan Dashboard</title>
    <style>
        body { font-family: sans-serif; font-size: 14px; }
        h1, h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #000; padding: 8px; text-align: left; }
    </style>
</head>
<body>
    <h1>Laporan Dashboard</h1>
    <h2>Bulan {{ $bulan }} Tahun {{ $tahun }}</h2>

    <p><strong>Laba Bersih:</strong> Rp{{ number_format($data->laba_bersih) }}</p>
    <p><strong>Pemasukan:</strong> Rp{{ number_format($data->pemasukan) }}</p>
    <p><strong>Pengeluaran:</strong> Rp{{ number_format($data->pengeluaran) }}</p>
    <p><strong>Total Transaksi:</strong> {{ $data->total_transaksi }}</p>
    <p><strong>Total Produk Terjual:</strong> {{ $data->total_produk_terjual }}</p>
    <p><strong>Total Produk:</strong> {{ $data->total_produk }}</p>

    <h3>Produk Terlaris</h3>
    <table>
        <thead>
            <tr>
                <th>Nama Produk</th>
                <th>Total Terjual</th>
            </tr>
        </thead>
        <tbody>
            @foreach($data->produk_terlaris as $produk)
            <tr>
                <td>{{ $produk->nama_produk }}</td>
                <td>{{ $produk->total_terjual }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>

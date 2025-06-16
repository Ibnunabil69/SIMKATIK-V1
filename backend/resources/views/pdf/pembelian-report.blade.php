<!DOCTYPE html>
<html>

<head>
    <title>Laporan Transaksi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #379777;
            color: #ffff;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .footer {
            text-align: right;
            margin-top: 20px;
            font-size: 12px;
            border-top: 1px solid #ccc;

        }
    </style>
</head>

<body>
    <div class="header">
        <h1>Laporan Pembelian</h1>
        <p>Dibuat pada: {{ $date }}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Nama Produk</th>
                <th>Kuantitas</th>
                <th>Harga Beli</th>
                <th>Total Harga</th>
                <th>Tanggal Pembelian</th>
            </tr>
        </thead>
        <tbody>
            @foreach($purchases as $index => $purchase)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ $purchase['produk']['nama_produk'] }}</td>
                <td>{{ $purchase['jumlah'] . ' ' . $purchase['satuan'] . ' (' . $purchase['isi_perbox'] . ' pcs)' }}</td>
                <td>Rp {{ number_format($purchase['harga_beli'], 0, ',', '.') }}</td>
                <td>Rp {{ number_format($purchase['total_harga'], 0, ',', '.') }}</td>
                <td>{{ \Carbon\Carbon::parse($purchase['created_at'])->format('d/m/Y H:i') }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>

    @php
    $totalPengeluaran = array_reduce($purchases ?? [], function($carry, $item) {
    return $carry + ($item['total_harga'] ?? 0);
    }, 0);
    @endphp

    <div class="footer">
        <p>Total Pembelian: {{ count($purchases) }}</p>
        <p>Total Pengeluaran: Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</p>
    </div>

</body>

</html>
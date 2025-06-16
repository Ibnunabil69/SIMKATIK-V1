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
        <h1>Laporan Transaksi</h1>
        <p>Dibuat pada: {{ $date }}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Kasir</th>
                <th>Total Item</th>
                <th>Total Harga</th>
                <th>Metode Pembayaran</th>
            </tr>
        </thead>
        <tbody>
            @foreach($transactions as $index => $transaction)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ \Carbon\Carbon::parse($transaction['created_at'])->format('d/m/Y H:i') }}</td>
                <td>{{ $transaction['user']['username'] }}</td>
                <td>{{ array_reduce($transaction['items'], function($carry, $item) { return $carry + $item['jumlah']; }, 0) }}</td>
                <td>Rp {{ number_format($transaction['total_harga'], 0, ',', '.') }}</td>
                <td>{{ $transaction['metode_pembayaran']['nama'] }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>

    @php
    $totalPemasukan = array_reduce($transactions, function($carry, $transaction) {
    return $carry + $transaction['total_harga'];
    }, 0);
    @endphp

    <div class="footer">
        <p>Total Transaksi: {{ count($transactions) }}</p>
        <p>Total Pemasukan: Rp {{ number_format($totalPemasukan, 0, ',', '.') }}</p>
    </div>

</body>

</html>
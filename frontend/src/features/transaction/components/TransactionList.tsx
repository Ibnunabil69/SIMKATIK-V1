import dayjs from "dayjs";
import "dayjs/locale/id";
import {
  Filter,
  MoreHorizontal,
  Printer,
  View,
  PrinterCheck,
} from "lucide-react";
import * as React from "react";
import { useRef } from "react";
import { toast } from "sonner";
import { Button } from "~/components/ui/Button";
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "~/components/ui/Dialog";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "~/components/ui/DropdownMenu";
import { Label } from "~/components/ui/Label";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "~/components/ui/Popover";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "~/components/ui/Select";
import { formatCurrency } from "~/lib/utils";
import useTransaction from "../hooks/useTransaction";
import ApplicationLogo from "~/components/ui/ApplicationLogo";
import type { Transaction } from "../types";
import { forwardRef } from "react";
import { useReactToPrint } from "react-to-print";
import { Component } from "react";
import { useExportTransactionsPdf } from "../hooks/useExportTransactionsPdf";

interface TransactionItem {
  id: number;
  produk: {
    nama_produk: string;
    harga_jual: number;
  };
  jumlah: number;
  subtotal: number;
}

const ComponentToPrint = forwardRef<
  HTMLDivElement,
  { transaction: Transaction | null }
>(({ transaction }, ref) => {
  if (!transaction) return null;

  return (
    <div className="receipt hidden print:block" ref={ref}>
      <h2 className="text-center font-bold">SIMKATIK</h2>
      <p className="text-center">Jl. Contoh No. 123</p>
      <p className="text-center">Telp: (021) 12345678</p>

      <div className="divider"></div>

      <p>Kasir: {transaction.user.username}</p>
      <p>
        {dayjs(transaction.created_at).locale("id").format("dddd, DD-MM-YYYY")}
      </p>
      <p>{dayjs(transaction.created_at).locale("id").format("HH:mm:ss")}</p>

      <div className="divider"></div>

      <div className="items-list">
        {transaction.items.map((item) => (
          <div key={item.id} className="item">
            <p className="font-bold">{item.produk.nama_produk}</p>
            <div className="flex justify-between">
              <span>
                {item.jumlah} x {formatCurrency(item.produk.harga_jual)}
              </span>
              <span className="font-bold">{formatCurrency(item.subtotal)}</span>
            </div>
          </div>
        ))}
      </div>

      <div className="divider"></div>

      <div className="summary">
        <div className="flex justify-between">
          <span>Total Item:</span>
          <span>
            {new Intl.NumberFormat("id-ID").format(
              transaction.items.reduce((total, item) => total + item.jumlah, 0)
            )}
          </span>
        </div>
        <div className="flex justify-between">
          <span>Metode Bayar:</span>
          <span>{transaction.metode_pembayaran.nama}</span>
        </div>
        <div className="flex justify-between font-bold">
          <span>TOTAL:</span>
          <span>{formatCurrency(transaction.total_harga)}</span>
        </div>
      </div>

      <div className="divider"></div>

      <div className="footer">
        <p className="text-center">Barang yang sudah dibeli</p>
        <p className="text-center">tidak dapat ditukar/dikembalikan</p>
        <p className="text-center font-bold">TERIMA KASIH</p>
      </div>
    </div>
  );
});

const TransactionList = () => {
  const { transactions } = useTransaction();
  const [selectedTransaction, setSelectedTransaction] =
    React.useState<Transaction | null>(null);
  const { mutate: exportPdf, isPending: isExporting } =
    useExportTransactionsPdf();

  const handleExportPdf = () => {
    exportPdf({ transactions });
  };

  const contentRef = useRef<HTMLDivElement>(null);
  const handlePrint = useReactToPrint({ contentRef });

  return (
    <>
      <div className="flex items-center justify-end gap-2">
        <Button
          variant="secondary"
          onClick={handleExportPdf}
          disabled={isExporting || transactions.length === 0}
        >
          <Printer className="mr-2 h-4 w-4" />
          {isExporting ? "Sedang Mengekspor..." : "Export PDF"}
        </Button>
        <ComponentToPrint ref={contentRef} transaction={selectedTransaction} />
      </div>
      <ul className="space-y-4">
        {transactions.map((transaction) => (
          <li key={transaction.id}>
            <article className="flex items-center justify-between gap-4 rounded-md bg-white p-4 shadow">
              <div>
                <h3 className="font-semibold text-xl">
                  {dayjs(transaction.created_at)
                    .locale("id")
                    .format("dddd - DD-MM-YYYY - HH:mm:ss")}
                </h3>
                <p className="font-medium text-muted-foreground text-sm">
                  Transaksi oleh {transaction.user.username}
                </p>
              </div>
              <div className="flex items-center gap-2">
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button
                      size="icon"
                      variant="secondary"
                      className="md:hidden"
                    >
                      <MoreHorizontal />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent>
                    {/* <DropdownMenuItem>
                                            <Printer />
                                            Cetak Struk
                                        </DropdownMenuItem> */}
                    <DropdownMenuItem
                      onClick={() => setSelectedTransaction(transaction)}
                    >
                      <View />
                      Lihat Detail
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
                {/* <Button className="hidden md:inline-flex">
                                    <Printer />
                                    Cetak Struk
                                </Button> */}
                <Button
                  variant="secondary"
                  className="hidden md:inline-flex"
                  onClick={() => setSelectedTransaction(transaction)}
                >
                  <View />
                  Lihat Detail
                </Button>
              </div>
            </article>
          </li>
        ))}

        {transactions.length === 0 && (
          <li className="py-10 text-center text-muted-foreground">
            Tidak ada transaksi yang ditemukan.
          </li>
        )}
      </ul>

      <Dialog
        open={selectedTransaction !== null}
        onOpenChange={() => setSelectedTransaction(null)}
      >
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Detail Transaksi</DialogTitle>
          </DialogHeader>
          <div className="my-6 grid max-h-[70vh] grid-cols-2 overflow-y-auto font-medium text-muted-foreground">
            <p>Transaksi Oleh</p>
            <p className="text-right">{selectedTransaction?.user.username}</p>
            <p>
              {dayjs(selectedTransaction?.created_at)
                .locale("id")
                .format("dddd, DD-MM-YYYY")}
            </p>
            <p className="text-right">
              {dayjs(selectedTransaction?.created_at)
                .locale("id")
                .format("HH:mm:ss")}
            </p>
            <div className="col-span-2 my-4 space-y-2 border-y py-4">
              {selectedTransaction?.items.map((item) => (
                <div key={item.id} className="grid grid-cols-2">
                  <p className="col-span-2">{item.produk.nama_produk}</p>
                  <p className="text-sm">
                    {item.jumlah} x {formatCurrency(item.produk.harga_jual)}
                  </p>
                  <p className="text-right text-sm">
                    {formatCurrency(item.subtotal)}
                  </p>
                </div>
              ))}
            </div>
            <p className="col-span-2">
              Total Quantity:{" "}
              {new Intl.NumberFormat("id-ID").format(
                selectedTransaction?.items.reduce(
                  (total, item) => total + item.jumlah,
                  0
                ) || 0
              )}
            </p>
            <p>Metode Bayar</p>
            <p className="text-right">
              {selectedTransaction?.metode_pembayaran.nama}
            </p>
            <p>Total</p>
            <p className="text-right">
              {formatCurrency(selectedTransaction?.total_harga || 0)}
            </p>
          </div>
          <DialogFooter>
            <Button onClick={handlePrint}>
              <Printer />
              Cetak Struk
            </Button>
            <DialogClose asChild>
              <Button variant="secondary" className="flex-1">
                Oke
              </Button>
            </DialogClose>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
};

export default TransactionList;

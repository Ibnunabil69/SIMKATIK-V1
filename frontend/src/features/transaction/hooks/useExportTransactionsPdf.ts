// hooks/useExportTransactionsPdf.ts
import { useMutation } from "@tanstack/react-query";
import dayjs from "dayjs";
import apiClient from "~/lib/apiClient";
import { toast } from "sonner";

interface ExportPdfParams {
  transactions: any[];
}

const exportTransactionsToPdf = async ({ transactions }: ExportPdfParams) => {
  const exportData = {
    transactions: transactions.map((transaction) => ({
      ...transaction,
      created_at: dayjs(transaction.created_at).format(),
    })),
    date: dayjs().format("YYYY-MM-DD HH:mm:ss"),
  };

  const response = await apiClient.post("/export/transactions", exportData, {
    responseType: "blob",
  });

  return response.data;
};

export const useExportTransactionsPdf = () => {
  return useMutation({
    mutationFn: exportTransactionsToPdf,
    onSuccess: (pdfBlob) => {
      const pdfUrl = URL.createObjectURL(
        new Blob([pdfBlob], { type: "application/pdf" })
      );
      const link = document.createElement("a");
      link.href = pdfUrl;
      link.download = `laporan-transaksi-${dayjs().format("YYYY-MM-DD")}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      toast.success("PDF berhasil dihasilkan");
    },
    onError: (error: Error) => {
      toast.error(error.message || "Gagal mengekspor PDF");
    },
  });
};

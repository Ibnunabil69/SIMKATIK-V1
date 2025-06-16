// hooks/useExportTransactionsPdf.ts
import { useMutation } from "@tanstack/react-query";
import dayjs from "dayjs";
import apiClient from "~/lib/apiClient";
import { toast } from "sonner";

interface ExportPdfParams {
  purchases: any[];
}

const eportPurchasePdf = async ({ purchases }: ExportPdfParams) => {
  const exportData = {
    purchases: purchases.map((pembeli) => ({
      ...pembeli,
      created_at: dayjs(pembeli.created_at).format(),
    })),
    date: dayjs().format("YYYY-MM-DD HH:mm:ss"),
  };

  const response = await apiClient.post("/export/pembelian", exportData, {
    responseType: "blob",
  });

  return response.data;
};

export const useExportPurchasePdf = () => {
  return useMutation({
    mutationFn: eportPurchasePdf,
    onSuccess: (pdfBlob) => {
      const pdfUrl = URL.createObjectURL(
        new Blob([pdfBlob], { type: "application/pdf" })
      );
      const link = document.createElement("a");
      link.href = pdfUrl;
      link.download = `laporan-pembelian-${dayjs().format("YYYY-MM-DD")}.pdf`;
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

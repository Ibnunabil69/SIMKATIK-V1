import { Plus, Printer } from "lucide-react";
import * as React from "react";

import { toast } from "sonner";
import { Button } from "~/components/ui/Button";
import { DataTable, DataTableToolbar } from "~/components/ui/DataTable";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "~/components/ui/DropdownMenu";
import { useDataTable } from "~/hooks/useDataTable";
import type { DataTableFilterField } from "~/lib/types";
import usePurchase from "../hooks/usePurchase";
import type { Purchase } from "../types";
import PurchaseProductSheet from "./PurchaseProductSheet";
import PurchaseStockSheet from "./PurchaseStockSheet";
import { getColumns } from "./PurchaseTableColumn";
import { useExportPurchasePdf } from "../hooks/useExportPurchasePdf";

const PurchaseDataTable = () => {
  const { purchases } = usePurchase();
  const { mutate: exportPdf, isPending: isExporting } = useExportPurchasePdf();
  const [isCreateOpen, setIsCreateOpen] = React.useState<{
    type?: "product" | "stock";
  } | null>();

  const columns = React.useMemo(() => getColumns(), []);

  const handleExportPdf = () => {
    exportPdf({ purchases });
  };

  const filterFields: DataTableFilterField<Purchase>[] = [
    {
      id: "produk",
      label: "Produk",
      placeholder: "Cari produk...",
    },
  ];

  const { table } = useDataTable({
    data: purchases,
    columns,
    initialState: {
      sorting: [{ id: "created_at", desc: true }],
    },
  });

  return (
    <>
      <DataTable table={table}>
        <DataTableToolbar table={table} filterFields={filterFields}>
          <Button
            variant="secondary"
            onClick={handleExportPdf}
            disabled={isExporting || !purchases.length}
          >
            <Printer />
            {isExporting ? "Sedang Mengekspor..." : "Export PDF"}
          </Button>
          <DropdownMenu modal={false}>
            <DropdownMenuTrigger asChild>
              <Button>
                <Plus className="mr-2" />
                Tambah Pembelian
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent className="w-(--radix-dropdown-menu-trigger-width)">
              <DropdownMenuItem
                onSelect={() => setIsCreateOpen({ type: "product" })}
              >
                Produk Baru
              </DropdownMenuItem>
              <DropdownMenuItem
                onSelect={() => setIsCreateOpen({ type: "stock" })}
              >
                Stok Produk
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </DataTableToolbar>
      </DataTable>
      <PurchaseProductSheet
        open={isCreateOpen?.type === "product"}
        onOpenChange={() => setIsCreateOpen(null)}
      />
      <PurchaseStockSheet
        open={isCreateOpen?.type === "stock"}
        onOpenChange={() => setIsCreateOpen(null)}
      />
    </>
  );
};

export default PurchaseDataTable;

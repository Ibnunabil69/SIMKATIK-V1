import { useState } from "react";
import { Button } from "~/components/ui/Button";
import { Printer, ChevronDown } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
} from "~/components/ui/DropdownMenu";
import { toast } from "sonner";

const FilterCetakPDF = () => {
  const [tipe, setTipe] = useState("Hari");
  const [tahun, setTahun] = useState(new Date().getFullYear().toString());
  const [isOpen, setIsOpen] = useState(false);

  const currentYear = new Date().getFullYear();
  const years = Array.from({ length: 6 }, (_, i) =>
    (currentYear + i).toString()
  );

  const handleDownloadPdf = async () => {
    try {
      const response = await fetch(
        `http://localhost:8000/api/export-pdf?tipe=${tipe}&tahun=${tahun}`,
        {
          method: "GET",
          headers: {
            Accept: "application/pdf",
          },
        }
      );

      if (!response.ok) throw new Error("Gagal mendownload PDF");

      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url;
      link.setAttribute("download", `laporan-${tahun}.pdf`);
      document.body.appendChild(link);
      link.click();
      link.parentNode.removeChild(link);

      toast.success(`Berhasil mendownload PDF tahun ${tahun}!`);
    } catch (error) {
      toast.error("Gagal mendownload PDF!");
      console.error(error);
    }
  };

  return (
    <div className="flex items-center gap-2">
      <Button variant="secondary" onClick={handleDownloadPdf}>
        <Printer className="mr-2 h-4 w-4" />
        Print PDF
      </Button>

      <Button variant="outline">
        {tipe}
        <ChevronDown className="ml-2 h-4 w-4" />
      </Button>

      <DropdownMenu open={isOpen} onOpenChange={setIsOpen}>
        <DropdownMenuTrigger asChild>
          <Button variant="outline" className="flex items-center gap-2">
            {tahun}
            <ChevronDown className="h-4 w-4 opacity-50" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent className="w-32 max-h-60 overflow-y-auto">
          {years.map((year) => (
            <DropdownMenuItem
              key={year}
              onClick={() => setTahun(year)}
              className="text-center"
            >
              {year}
            </DropdownMenuItem>
          ))}
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  );
};

export default FilterCetakPDF;

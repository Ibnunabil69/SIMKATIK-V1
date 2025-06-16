import {
    BaggageClaim,
    Boxes,
    ChartNoAxesCombined,
    Receipt,
    TrendingDown,
    TrendingUp,
    Printer,
} from "lucide-react";
import { useEffect, useState } from "react";
import axios from "axios";
import { Button } from "~/components/ui/Button";
import BestProductDataTable from "~/features/analytics/components/BestProductDataTable";
import RevenueChart from "~/features/analytics/components/RevenueChart";
import StatCard from "~/features/analytics/components/StatCard";
import useAuth from "~/features/auth/hooks/useAuth";

const DashboardPage = () => {
    const { user } = useAuth();
    const [bulan, setBulan] = useState(new Date().getMonth() + 1);
    const [tahun, setTahun] = useState(new Date().getFullYear());
    const [analytics, setAnalytics] = useState<any>(null);
    const isAdmin = user?.role === "Admin";

    const fetchAnalytics = async () => {
        try {
            const response = await fetch(
                `http://backend-simkatik.trihech.my.id/api/dashboard/analytics?bulan=${bulan}&tahun=${tahun}`,
                {
                    headers: {
                        Accept: "application/json",
                    },
                }
            );

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const json = await response.json();
            setAnalytics(json.data);
        } catch (error) {
            console.error("Gagal memuat data analytics:", error);
        }
    };

    useEffect(() => {
        fetchAnalytics();
    }, [bulan, tahun]);

    const handlePrintPDF = async () => {
        try {
            const response = await axios.get(
                `http://backend-simkatik.trihech.my.id/api/dashboard/pdf?bulan=${bulan}&tahun=${tahun}`,
                {
                    responseType: "blob",
                    headers: {
                        Accept: "application/json",
                    },
                }
            );

            const url = window.URL.createObjectURL(new Blob([response.data]));
            const link = document.createElement("a");
            link.href = url;
            link.setAttribute("download", "dashboard-report.pdf");
            document.body.appendChild(link);
            link.click();
        } catch (error) {
            console.error("Gagal download PDF:", error);
        }
    };

    return (
        <>
            <div className="flex items-center justify-between mb-4">
                <h2 className="font-bold text-3xl">Dashboard</h2>
                <div className="flex items-center gap-2">
                    <select
                        value={bulan}
                        onChange={(e) => setBulan(Number(e.target.value))}
                        className="border rounded px-2 py-1"
                    >
                        {Array.from({ length: 12 }, (_, i) => (
                            <option key={i + 1} value={i + 1}>
                                {new Date(0, i).toLocaleString("id-ID", {
                                    month: "long",
                                })}
                            </option>
                        ))}
                    </select>
                    <select
                        value={tahun}
                        onChange={(e) => setTahun(Number(e.target.value))}
                        className="border rounded px-2 py-1"
                    >
                        {[2023, 2024, 2025].map((y) => (
                            <option key={y} value={y}>
                                {y}
                            </option>
                        ))}
                    </select>
                    <Button onClick={handlePrintPDF} variant="secondary" className="ml-2">
                        <Printer className="w-4 h-4 mr-2" />
                        Download PDF
                    </Button>
                </div>
            </div>

            {!analytics ? (
                <p>Memuat data...</p>
            ) : (
                <>
                    <div className="grid auto-rows-min gap-4 md:grid-cols-3">
                        {isAdmin && (
                            <StatCard
                                title="Laba Bersih"
                                icon={ChartNoAxesCombined}
                                value={analytics.laba_bersih}
                            />
                        )}
                        <StatCard
                            title="Pemasukan"
                            icon={TrendingUp}
                            value={analytics.pemasukan}
                            className="text-primary"
                        />
                        {isAdmin && (
                            <StatCard
                                title="Pengeluaran"
                                icon={TrendingDown}
                                value={analytics.pengeluaran}
                                className="text-destructive"
                            />
                        )}
                        <StatCard
                            title="Total Transaksi"
                            icon={Receipt}
                            value={analytics.total_transaksi}
                            isCurrency={false}
                            className="text-orange-600"
                        />
                        <StatCard
                            title="Total Produk Terjual"
                            icon={BaggageClaim}
                            value={analytics.total_produk_terjual}
                            isCurrency={false}
                            className="text-purple-600"
                        />
                        {isAdmin && (
                            <StatCard
                                title="Total Produk"
                                icon={Boxes}
                                value={analytics.total_produk}
                                isCurrency={false}
                                className="text-yellow-600"
                            />
                        )}
                    </div>

                    {isAdmin && (
                        <>
                            <div className="min-h-[500px] w-full rounded-xl bg-background p-4 shadow mt-6">
                                <RevenueChart chartData={analytics.grafik_pendapatan} />
                            </div>
                            <div className="mt-6 w-full space-y-4">
                                <h3 className="font-bold text-2xl">Produk Terlaris</h3>
                                <BestProductDataTable data={analytics.produk_terlaris} />
                            </div>
                        </>
                    )}
                </>
            )}
        </>
    );
};

export default DashboardPage;

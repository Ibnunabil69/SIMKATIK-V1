import { HandCoins, HistoryIcon, House } from "lucide-react";
import { NavLink } from "react-router";
import ApplicationLogo from "~/components/ui/ApplicationLogo";
import axios from "axios";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "~/components/ui/Sidebar";
import NavDataManagement from "./NavDataManagement";
import NavTransaction from "./NavTransaction";
import NavUser from "./NavUser";

import useAuth from "~/features/auth/hooks/useAuth";
import { useSidebarStore } from "~/stores/use-sidebar-store";

const DashboardSidebar = ({
  ...props
}: React.ComponentProps<typeof Sidebar>) => {
  const { user } = useAuth();
  const { open: isOpen } = useSidebarStore();
  const handlePrintPDF = async () => {
    try {
      const response = await axios.get(
  "http://backend-simkatik.trihech.my.id/api/dashboard/pdf",
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
      link.setAttribute("download", `dashboard-report.pdf`);
      document.body.appendChild(link);
      link.click();
    } catch (error) {
      console.error("Gagal download PDF:", error);
    }
  };

  return (
    <Sidebar
      collapsible="icon"
      className="border-0! shadow-black/50 drop-shadow-md"
      {...props}
    >
      <SidebarHeader className="flex items-center group-data-[state=expanded]:p-4 ">
        {isOpen ? (
          <ApplicationLogo variant="horizontal-text" />
        ) : (
          <ApplicationLogo variant="icon-only" className="max-w-[54px]" />
        )}
      </SidebarHeader>
      <SidebarContent>
        <SidebarGroup className="group-data-[state=expanded]:mt-8">
          <SidebarMenu>
            <SidebarMenuItem>
              <SidebarMenuButton asChild>
                <NavLink to="/">
                  <House />
                  <span>Dashboard</span>
                </NavLink>
              </SidebarMenuButton>
            </SidebarMenuItem>
          </SidebarMenu>
        </SidebarGroup>

        {user?.role === "Admin" ? (
          <>
            <NavTransaction />
            <NavDataManagement />
          </>
        ) : (
          <>
            <SidebarGroup>
              <SidebarGroupLabel>Transaksi</SidebarGroupLabel>
              <SidebarMenu>
                <SidebarMenuItem>
                  <SidebarMenuButton asChild>
                    <NavLink to="/cashier">
                      <HandCoins />
                      <span>Penjualan</span>
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              </SidebarMenu>
              <SidebarMenu>
                <SidebarMenuItem>
                  <SidebarMenuButton asChild>
                    <NavLink to="/history">
                      <HistoryIcon />
                      <span>History</span>
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              </SidebarMenu>
            </SidebarGroup>
          </>
        )}
      </SidebarContent>
      <SidebarFooter>
        <NavUser />
      </SidebarFooter>
    </Sidebar>
  );
};

export default DashboardSidebar;

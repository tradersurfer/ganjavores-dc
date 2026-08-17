"use client";

import { usePathname } from "next/navigation";
import { SiteHeader } from "@/components/site-header";
import { SiteFooter } from "@/components/site-footer";

/**
 * The root layout wraps every route, but /admin/* is its own panel with
 * its own nav (see app/admin/(protected)/layout.tsx) — showing the
 * customer-facing Shop/Deals header and delivery-hours footer around
 * the admin login screen and dashboard was never intentional, just a
 * side effect of one root layout covering the whole app.
 */
export function SiteChrome({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const isAdmin = pathname?.startsWith("/admin");

  if (isAdmin) return <>{children}</>;

  return (
    <>
      <SiteHeader />
      <main className="min-h-screen">{children}</main>
      <SiteFooter />
    </>
  );
}

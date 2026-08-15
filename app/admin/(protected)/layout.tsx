import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { AdminSignOutButton } from "@/components/admin/sign-out-button";

const NAV = [
  { href: "/admin", label: "Dashboard" },
  { href: "/admin/products", label: "Products" },
  { href: "/admin/orders", label: "Orders" },
  { href: "/admin/brands", label: "Brands" },
  { href: "/admin/categories", label: "Categories" },
  { href: "/admin/announcements", label: "Announcements & Deals" },
  { href: "/admin/reviews", label: "Reviews" },
  { href: "/admin/messages", label: "Messages" },
];

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // middleware already redirects unauthenticated requests, but the
  // login page itself renders through this layout's sibling route
  // group, so this guard only fires for /admin/* pages proper
  if (!user) redirect("/admin/login");

  return (
    <div className="min-h-screen bg-midnight flex">
      <aside className="w-56 shrink-0 border-r border-border p-6 hidden md:block">
        <Link href="/admin" className="font-display text-xl text-emerald block mb-8">
          Ganjavores Admin
        </Link>
        <nav className="space-y-1">
          {NAV.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="block text-soft hover:text-emerald text-sm py-2"
            >
              {item.label}
            </Link>
          ))}
        </nav>
        <div className="mt-8 pt-8 border-t border-border">
          <p className="text-xs text-soft/60 mb-2 truncate">{user.email}</p>
          <AdminSignOutButton />
        </div>
      </aside>

      <main className="flex-1 p-6 md:p-10 overflow-x-auto">{children}</main>
    </div>
  );
}

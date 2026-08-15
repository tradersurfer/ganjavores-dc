import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";

export default async function AdminDashboardPage() {
  const supabase = await createClient();

  const [{ data: recentOrders }, { count: activeProductCount }, { data: lowStock }, { count: pendingReviewCount }] =
    await Promise.all([
      supabase
        .from("orders")
        .select("id, order_number, customer_name, status, subtotal, fulfillment_type, created_at")
        .order("created_at", { ascending: false })
        .limit(8),
      supabase.from("products").select("id", { count: "exact", head: true }).eq("is_active", true),
      supabase
        .from("product_variants")
        .select("id, label, inventory_count, product:products(name, slug)")
        .lte("inventory_count", 5)
        .order("inventory_count")
        .limit(8),
      supabase.from("reviews").select("id", { count: "exact", head: true }).eq("is_approved", false),
    ]);

  return (
    <div>
      <h1 className="gv-section-heading mb-8">Dashboard</h1>

      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
        <StatCard label="Active Products" value={activeProductCount ?? 0} />
        <StatCard label="Orders (recent)" value={recentOrders?.length ?? 0} />
        <StatCard label="Low Stock Variants" value={lowStock?.length ?? 0} warn={(lowStock?.length ?? 0) > 0} />
        <StatCard
          label="Reviews Awaiting Approval"
          value={pendingReviewCount ?? 0}
          warn={(pendingReviewCount ?? 0) > 0}
        />
      </div>

      <div className="grid lg:grid-cols-2 gap-8">
        <div>
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-white font-display text-xl">Recent Orders</h2>
            <Link href="/admin/orders" className="text-emerald text-sm hover:text-neon">
              View all &rarr;
            </Link>
          </div>
          <div className="gv-card divide-y divide-border">
            {(recentOrders ?? []).length === 0 && (
              <p className="text-soft text-sm py-4">No orders yet.</p>
            )}
            {(recentOrders ?? []).map((order) => (
              <div key={order.id} className="py-3 flex items-center justify-between text-sm">
                <div>
                  <p className="text-white">{order.order_number}</p>
                  <p className="text-soft text-xs">
                    {order.customer_name} · {order.fulfillment_type}
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-emerald">${order.subtotal.toFixed(2)}</p>
                  <StatusPill status={order.status} />
                </div>
              </div>
            ))}
          </div>
        </div>

        <div>
          <h2 className="text-white font-display text-xl mb-4">Low Stock</h2>
          <div className="gv-card divide-y divide-border">
            {(lowStock ?? []).length === 0 && (
              <p className="text-soft text-sm py-4">Nothing running low right now.</p>
            )}
            {(lowStock ?? []).map((v: any) => (
              <div key={v.id} className="py-3 flex items-center justify-between text-sm">
                <div>
                  <p className="text-white">{v.product?.name}</p>
                  <p className="text-soft text-xs">{v.label}</p>
                </div>
                <span className={v.inventory_count === 0 ? "text-red-400" : "text-highlight"}>
                  {v.inventory_count} left
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

function StatCard({ label, value, warn }: { label: string; value: number; warn?: boolean }) {
  return (
    <div className="gv-card">
      <p className="text-soft text-xs uppercase tracking-wide mb-1">{label}</p>
      <p className={`text-2xl font-display ${warn ? "text-highlight" : "text-white"}`}>{value}</p>
    </div>
  );
}

function StatusPill({ status }: { status: string }) {
  const colors: Record<string, string> = {
    received: "text-soft",
    confirmed: "text-emerald",
    out_for_delivery: "text-highlight",
    ready_for_pickup: "text-highlight",
    completed: "text-emerald",
    cancelled: "text-red-400",
  };
  return (
    <span className={`text-xs capitalize ${colors[status] ?? "text-soft"}`}>
      {status.replace(/_/g, " ")}
    </span>
  );
}

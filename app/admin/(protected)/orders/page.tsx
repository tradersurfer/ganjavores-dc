import { createClient } from "@/lib/supabase/server";
import { OrderStatusSelect } from "@/components/admin/order-status-select";

export const dynamic = "force-dynamic";

const STATUS_FILTERS = [
  "all",
  "received",
  "confirmed",
  "out_for_delivery",
  "ready_for_pickup",
  "completed",
  "cancelled",
];

export default async function AdminOrdersPage({
  searchParams,
}: {
  searchParams: Promise<{ status?: string }>;
}) {
  const { status } = await searchParams;
  const supabase = await createClient();

  let query = supabase
    .from("orders")
    .select(
      `id, order_number, customer_name, customer_phone, fulfillment_type,
       delivery_address, preferred_window, status, subtotal, created_at,
       order_items(product_name_snapshot, variant_label_snapshot, quantity, unit_price)`
    )
    .order("created_at", { ascending: false });

  if (status && status !== "all") query = query.eq("status", status);

  const { data: orders } = await query;

  return (
    <div>
      <h1 className="gv-section-heading mb-6">Orders</h1>

      <div className="flex gap-2 mb-6 flex-wrap">
        {STATUS_FILTERS.map((s) => (
          <a
            key={s}
            href={s === "all" ? "/admin/orders" : `/admin/orders?status=${s}`}
            className={`text-xs px-3 py-1.5 rounded-full border capitalize ${
              (status ?? "all") === s
                ? "border-emerald text-emerald"
                : "border-border text-soft hover:border-emerald"
            }`}
          >
            {s.replace(/_/g, " ")}
          </a>
        ))}
      </div>

      <div className="space-y-4">
        {(orders ?? []).map((order: any) => (
          <div key={order.id} className="gv-card">
            <div className="flex flex-wrap items-start justify-between gap-4">
              <div>
                <p className="text-white font-semibold">{order.order_number}</p>
                <p className="text-soft text-sm">
                  {order.customer_name} · {order.customer_phone}
                </p>
                <p className="text-soft text-sm capitalize">
                  {order.fulfillment_type}
                  {order.delivery_address ? ` — ${order.delivery_address}` : ""}
                  {order.preferred_window ? ` (${order.preferred_window})` : ""}
                </p>
                <p className="text-soft text-xs mt-1">
                  {new Date(order.created_at).toLocaleString("en-US")}
                </p>
              </div>
              <div className="text-right">
                <p className="text-emerald font-semibold mb-2">
                  ${order.subtotal.toFixed(2)}
                </p>
                <OrderStatusSelect orderId={order.id} currentStatus={order.status} />
              </div>
            </div>

            <div className="mt-3 pt-3 border-t border-border/50 space-y-1">
              {(order.order_items ?? []).map((item: any, i: number) => (
                <p key={i} className="text-soft text-sm">
                  {item.quantity}× {item.product_name_snapshot} ({item.variant_label_snapshot}) — $
                  {(item.unit_price * item.quantity).toFixed(2)}
                </p>
              ))}
            </div>
          </div>
        ))}

        {(orders ?? []).length === 0 && (
          <p className="text-soft text-sm py-8 text-center">No orders in this view.</p>
        )}
      </div>
    </div>
  );
}

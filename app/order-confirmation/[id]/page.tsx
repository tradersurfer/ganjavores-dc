import Link from "next/link";
import { createServiceClient } from "@/lib/supabase/service";
import { BUSINESS } from "@/lib/business-info";

export const dynamic = "force-dynamic";

export default async function OrderConfirmationPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  // Service-role client, server-only — see lib/supabase/service.ts for
  // why this page can't just use the public anon client + a permissive
  // RLS policy (that would leak every order to anyone with the anon key).
  const supabase = createServiceClient();
  const { data: order } = await supabase
    .from("orders")
    .select("id, order_number, customer_name, fulfillment_type, preferred_window, subtotal, status")
    .eq("id", id)
    .maybeSingle();

  if (!order) {
    return (
      <div className="max-w-xl mx-auto px-4 md:px-6 py-16 text-center">
        <h1 className="gv-section-heading mb-4">Order Received</h1>
        <p className="text-soft">
          Thanks — we've got your order. We'll reach out shortly to confirm details.
          Questions in the meantime? Call{" "}
          <a href={`tel:${BUSINESS.phone}`} className="text-emerald">
            {BUSINESS.phone}
          </a>
          .
        </p>
        <Link href="/shop" className="gv-btn-outline inline-block mt-8">
          Continue Shopping
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-xl mx-auto px-4 md:px-6 py-16 text-center">
      <div className="text-5xl mb-4">✓</div>
      <h1 className="gv-section-heading mb-2">Order Confirmed</h1>
      <p className="text-soft mb-6">
        Order <span className="text-emerald">{order.order_number}</span> — thanks,{" "}
        {order.customer_name}.
      </p>

      <div className="gv-card text-left space-y-2 mb-8">
        <div className="flex justify-between">
          <span className="text-soft">Fulfillment</span>
          <span className="text-white capitalize">{order.fulfillment_type}</span>
        </div>
        {order.preferred_window && (
          <div className="flex justify-between">
            <span className="text-soft">Preferred Window</span>
            <span className="text-white">{order.preferred_window}</span>
          </div>
        )}
        <div className="flex justify-between">
          <span className="text-soft">Subtotal</span>
          <span className="text-emerald font-semibold">${order.subtotal.toFixed(2)}</span>
        </div>
        <p className="text-soft text-sm pt-2 border-t border-border">
          Pay cash or card when your order arrives or at pickup — no payment was
          collected online.
        </p>
      </div>

      <p className="text-soft text-sm mb-8">
        We'll text or call {order.customer_name ? "you" : ""} at the number provided to
        confirm timing. Questions? Call{" "}
        <a href={`tel:${BUSINESS.phone}`} className="text-emerald">
          {BUSINESS.phone}
        </a>
        .
      </p>

      <Link href="/shop" className="gv-btn-primary inline-block">
        Continue Shopping
      </Link>
    </div>
  );
}

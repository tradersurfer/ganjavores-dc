"use server";

import { createClient } from "@/lib/supabase/server";
import { checkoutSchema } from "@/lib/checkout-schema";
import { sendOrderNotification } from "@/lib/notify";
import type { CartLine } from "@/lib/types";

function generateOrderNumber() {
  const date = new Date();
  const datePart = `${date.getFullYear()}${String(date.getMonth() + 1).padStart(2, "0")}${String(
    date.getDate()
  ).padStart(2, "0")}`;
  const randomPart = Math.floor(1000 + Math.random() * 9000);
  return `GV-${datePart}-${randomPart}`;
}

export async function placeOrder(
  values: unknown,
  lines: CartLine[]
): Promise<{ success: true; orderId: string } | { success: false; error: string }> {
  const parsed = checkoutSchema.safeParse(values);
  if (!parsed.success) {
    return { success: false, error: parsed.error.issues[0]?.message ?? "Invalid form" };
  }
  if (lines.length === 0) {
    return { success: false, error: "Your bag is empty" };
  }

  const supabase = await createClient();
  const data = parsed.data;
  const subtotal = lines.reduce((sum, l) => sum + l.unit_price * l.quantity, 0);
  const orderNumber = generateOrderNumber();

  const { data: order, error: orderError } = await supabase
    .from("orders")
    .insert({
      order_number: orderNumber,
      customer_name: data.customer_name,
      customer_phone: data.customer_phone,
      customer_email: data.customer_email || null,
      fulfillment_type: data.fulfillment_type,
      delivery_address: data.delivery_address || null,
      delivery_city: data.delivery_city || null,
      delivery_zip: data.delivery_zip || null,
      preferred_window: data.preferred_window || null,
      order_notes: data.order_notes || null,
      status: "received",
      subtotal,
    })
    .select("id")
    .single();

  if (orderError || !order) {
    return { success: false, error: "Couldn't place your order — try again." };
  }

  const orderItems = lines.map((line) => ({
    order_id: order.id,
    product_id: line.product_id,
    variant_id: line.variant_id,
    product_name_snapshot: line.product_name,
    variant_label_snapshot: line.variant_label,
    unit_price: line.unit_price,
    quantity: line.quantity,
    line_total: line.unit_price * line.quantity,
  }));

  const { error: itemsError } = await supabase.from("order_items").insert(orderItems);
  if (itemsError) {
    return { success: false, error: "Order created but items failed to save — call us." };
  }

  // No-ops until RESEND_API_KEY is set — see lib/notify.ts for setup steps.
  await sendOrderNotification({
    order_number: orderNumber,
    customer_name: data.customer_name,
    customer_phone: data.customer_phone,
    fulfillment_type: data.fulfillment_type,
    subtotal,
  });

  return { success: true, orderId: order.id };
}

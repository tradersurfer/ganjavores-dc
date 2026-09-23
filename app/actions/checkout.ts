"use server";

import { createClient } from "@/lib/supabase/server";
import { checkoutSchema } from "@/lib/checkout-schema";
import { validateTrustedCart, type TrustedCatalogVariant } from "@/lib/secure-checkout";
import { sendOrderNotification } from "@/lib/notify";

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
  lines: unknown
): Promise<{ success: true; orderId: string } | { success: false; error: string }> {
  const parsed = checkoutSchema.safeParse(values);
  if (!parsed.success) {
    return { success: false, error: parsed.error.issues[0]?.message ?? "Invalid form" };
  }
  if (!Array.isArray(lines) || lines.length === 0 || lines.length > 30) {
    return { success: false, error: "Invalid cart" };
  }

  const clientVariantIds = lines.map((line) => {
    if (!line || typeof line !== "object") return null;
    const variantId = (line as Record<string, unknown>).variant_id;
    return typeof variantId === "string" && variantId.length > 0 ? variantId : null;
  });
  if (clientVariantIds.some((variantId): variantId is null => variantId === null)) {
    return { success: false, error: "Invalid cart" };
  }

  const supabase = await createClient();
  const { data: variants, error: variantsError } = await supabase
    .from("product_variants")
    .select("id, product_id, label, price, inventory_count, products!inner(name, is_active)")
    .in("id", clientVariantIds);

  if (variantsError) {
    return { success: false, error: "Couldn't verify your cart — try again." };
  }

  const trustedCart = validateTrustedCart(
    lines,
    (variants ?? []) as TrustedCatalogVariant[]
  );
  if (!trustedCart.success) return trustedCart;

  const { items: orderItems, subtotal } = trustedCart;
  const data = parsed.data;
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

  const orderItemsWithOrderId = orderItems.map((item) => ({ ...item, order_id: order.id }));
  const { error: itemsError } = await supabase.from("order_items").insert(orderItemsWithOrderId);
  if (itemsError) {
    return { success: false, error: "Order created but items failed to save — call us." };
  }

  await sendOrderNotification({
    order_number: orderNumber,
    customer_name: data.customer_name,
    customer_phone: data.customer_phone,
    fulfillment_type: data.fulfillment_type,
    subtotal,
  });

  return { success: true, orderId: order.id };
}

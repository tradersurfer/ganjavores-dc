import { BUSINESS } from "@/lib/business-info";

/**
 * Sends a "new order" email to the business inbox via Resend
 * (resend.com — free tier covers low volume, verify current pricing
 * yourself before relying on it long-term).
 *
 * Uses Resend's plain HTTP API via `fetch` rather than their npm SDK —
 * no extra dependency to install, nothing to add to package.json.
 *
 * Setup:
 * 1. Log into resend.com with the account tied to your API key
 * 2. Verify a sending domain (e.g. ganjavores.com) under Domains — until
 *    a domain is verified, the "from" address below will be rejected
 * 3. Add RESEND_API_KEY to your Vercel project's environment variables
 *    (Project → Settings → Environment Variables) — never put the raw
 *    key value in any file in this repo
 *
 * Compliance note: if the key is unset or the API call fails, the
 * failure is logged via console.error (captured in Vercel's structured
 * logs with order ID + customer email) and returned as a typed result.
 * The caller is responsible for surfacing EMAIL_DISPATCH_FAILED to the
 * frontend so the confirmation page can display the order number as a
 * fallback — this order confirmation is legally required disclosure in
 * many jurisdictions, so it must never be silently swallowed.
 */
export type NotifyResult =
  | { sent: true }
  | { sent: false; reason: "EMAIL_DISPATCH_FAILED" };

export async function sendOrderNotification(order: {
  order_number: string;
  orderId: string;
  customer_name: string;
  customer_phone: string;
  customer_email?: string;
  fulfillment_type: string;
  subtotal: number;
}): Promise<NotifyResult> {
  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) {
    console.error(
      JSON.stringify({
        level: "error",
        code: "EMAIL_NOT_CONFIGURED",
        order_id: order.orderId,
        order_number: order.order_number,
        customer_email: order.customer_email ?? null,
        message: "RESEND_API_KEY is not set; customer confirmation email was not dispatched.",
      })
    );
    return { sent: false, reason: "EMAIL_DISPATCH_FAILED" };
  }

  try {
    const response = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${apiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        from: "orders@ganjavores.com", // must be on a domain verified in Resend
        to: BUSINESS.email,
        subject: `New Order — ${order.order_number}`,
        html: `
          <p><strong>${order.customer_name}</strong> just placed an order.</p>
          <p>Phone: ${order.customer_phone}</p>
          <p>Fulfillment: ${order.fulfillment_type}</p>
          <p>Subtotal: $${order.subtotal.toFixed(2)}</p>
          <p>View it in the admin panel: /admin/orders</p>
        `,
      }),
    });

    if (!response.ok) {
      const errText = await response.text();
      console.error(
        JSON.stringify({
          level: "error",
          code: "EMAIL_DELIVERY_ERROR",
          order_id: order.orderId,
          order_number: order.order_number,
          customer_email: order.customer_email ?? null,
          status: response.status,
          message: errText,
        })
      );
      return { sent: false, reason: "EMAIL_DISPATCH_FAILED" };
    }

    return { sent: true };
  } catch (err) {
    console.error(
      JSON.stringify({
        level: "error",
        code: "EMAIL_DELIVERY_ERROR",
        order_id: order.orderId,
        order_number: order.order_number,
        customer_email: order.customer_email ?? null,
        message: err instanceof Error ? err.message : String(err),
      })
    );
    return { sent: false, reason: "EMAIL_DISPATCH_FAILED" };
  }
}

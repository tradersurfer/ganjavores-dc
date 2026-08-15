import { BUSINESS } from "@/lib/business-info";

/**
 * Sends a "new order" email to the business inbox via Resend
 * (resend.com — free tier covers low volume, verify current pricing
 * yourself before relying on it long-term).
 *
 * Deliberately no-ops instead of throwing when RESEND_API_KEY isn't
 * set, so checkout never breaks because a notification integration
 * isn't configured yet — orders still save fine either way. Once you
 * add the env var, this starts firing automatically, nothing else to
 * change.
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
 */
export async function sendOrderNotification(order: {
  order_number: string;
  customer_name: string;
  customer_phone: string;
  fulfillment_type: string;
  subtotal: number;
}) {
  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) return; // not configured yet — see setup steps above

  try {
    await fetch("https://api.resend.com/emails", {
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
  } catch {
    // Notification failure should never fail the order itself — the
    // order is already saved in the database by the time this runs.
  }
}

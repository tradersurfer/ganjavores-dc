"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import Link from "next/link";
import { useCart } from "@/lib/cart-context";
import { checkoutSchema, type CheckoutFormValues } from "@/lib/checkout-schema";
import { placeOrder } from "@/app/actions/checkout";

export default function CheckoutPage() {
  const { lines, subtotal, clear } = useCart();
  const router = useRouter();
  const [submitting, setSubmitting] = useState(false);
  const [serverError, setServerError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm<CheckoutFormValues>({
    resolver: zodResolver(checkoutSchema),
    defaultValues: { fulfillment_type: "delivery" },
  });

  const fulfillmentType = watch("fulfillment_type");

  async function onSubmit(values: CheckoutFormValues) {
    setSubmitting(true);
    setServerError(null);
    const result = await placeOrder(
      values,
      lines.map(({ variant_id, quantity }) => ({ variant_id, quantity }))
    );
    setSubmitting(false);

    if (result.success) {
      clear();
      router.push(`/order-confirmation/${result.orderId}`);
    } else if (result.error === "EMAIL_DISPATCH_FAILED" && result.orderId) {
      // Order was saved but the confirmation email failed to dispatch.
      // Navigate to the confirmation page with a flag so it can render
      // the order number + a "save this page" compliance fallback.
      clear();
      router.push(`/order-confirmation/${result.orderId}?email=failed`);
    } else {
      setServerError(result.error);
    }
  }

  if (lines.length === 0) {
    return (
      <div className="max-w-3xl mx-auto px-4 md:px-6 py-16 text-center">
        {/* BreadcrumbList JSON-LD */}
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify({
              "@context": "https://schema.org",
              "@type": "BreadcrumbList",
              itemListElement: [
                { "@type": "ListItem", position: 1, name: "Home", item: "https://ganjavores.shop/" },
                { "@type": "ListItem", position: 2, name: "Cart", item: "https://ganjavores.shop/cart" },
                { "@type": "ListItem", position: 3, name: "Checkout", item: "https://ganjavores.shop/checkout" },
              ],
            }),
          }}
        />
        <p className="text-white text-lg mb-4">Your bag is empty.</p>
        <Link href="/shop" className="gv-btn-primary inline-block">
          Start Shopping
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-3xl mx-auto px-4 md:px-6 py-10">
      <h1 className="gv-section-heading mb-2">Checkout</h1>
      <p className="text-soft mb-8">
        No payment is collected here — pay cash or card when your order arrives or at
        pickup.
      </p>

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-8">
        <fieldset className="gv-card space-y-4">
          <legend className="text-white font-display text-xl mb-2">Contact Info</legend>

          <div>
            <input
              {...register("customer_name")}
              placeholder="Full name"
              className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
            />
            {errors.customer_name && (
              <p className="text-red-400 text-sm mt-1">{errors.customer_name.message}</p>
            )}
          </div>

          <div>
            <input
              {...register("customer_phone")}
              placeholder="Phone number"
              className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
            />
            {errors.customer_phone && (
              <p className="text-red-400 text-sm mt-1">{errors.customer_phone.message}</p>
            )}
          </div>

          <input
            {...register("customer_email")}
            placeholder="Email (optional)"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </fieldset>

        <fieldset className="gv-card space-y-4">
          <legend className="text-white font-display text-xl mb-2">
            Delivery or Pickup
          </legend>

          <div className="flex gap-3">
            <label
              className={`flex-1 border rounded-lg px-4 py-3 text-center cursor-pointer ${
                fulfillmentType === "delivery" ? "border-emerald text-emerald" : "border-border text-soft"
              }`}
            >
              <input type="radio" value="delivery" {...register("fulfillment_type")} className="sr-only" />
              Delivery
            </label>
            <label
              className={`flex-1 border rounded-lg px-4 py-3 text-center cursor-pointer ${
                fulfillmentType === "pickup" ? "border-emerald text-emerald" : "border-border text-soft"
              }`}
            >
              <input type="radio" value="pickup" {...register("fulfillment_type")} className="sr-only" />
              Curbside Pickup
            </label>
          </div>

          {fulfillmentType === "delivery" && (
            <>
              <div>
                <input
                  {...register("delivery_address")}
                  placeholder="Delivery address"
                  className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
                />
                {errors.delivery_address && (
                  <p className="text-red-400 text-sm mt-1">
                    {errors.delivery_address.message}
                  </p>
                )}
              </div>
              <div className="flex gap-3">
                <input
                  {...register("delivery_city")}
                  placeholder="City"
                  className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
                />
                <input
                  {...register("delivery_zip")}
                  placeholder="ZIP"
                  className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
                />
              </div>
            </>
          )}

          <input
            {...register("preferred_window")}
            placeholder="Preferred time window (e.g. 5-7 PM, ASAP)"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />

          <textarea
            {...register("order_notes")}
            placeholder="Order notes (optional)"
            rows={3}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </fieldset>

        <div className="gv-card">
          <h2 className="text-white font-display text-xl mb-4">Order Summary</h2>
          {lines.map((line) => (
            <div key={line.variant_id} className="flex justify-between text-sm py-1.5 text-soft">
              <span>
                {line.quantity}× {line.product_name} ({line.variant_label})
              </span>
              <span>${(line.unit_price * line.quantity).toFixed(2)}</span>
            </div>
          ))}
          <div className="flex justify-between text-lg mt-3 pt-3 border-t border-border">
            <span className="text-white">Subtotal</span>
            <span className="text-emerald font-semibold">${subtotal.toFixed(2)}</span>
          </div>
        </div>

        {serverError && <p className="text-red-400 text-sm">{serverError}</p>}

        <button type="submit" disabled={submitting} className="gv-btn-primary w-full disabled:opacity-50">
          {submitting ? "Placing Order..." : "Place Order — Pay on Arrival"}
        </button>
      </form>
    </div>
  );
}

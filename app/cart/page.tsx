"use client";

import Link from "next/link";
import { useCart } from "@/lib/cart-context";
import { CartLineItem } from "@/components/cart/cart-line-item";

export default function CartPage() {
  const { lines, subtotal } = useCart();

  return (
    <div className="max-w-3xl mx-auto px-4 md:px-6 py-10">
      {/* BreadcrumbList JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: [
              { "@type": "ListItem", position: 1, name: "Home", item: "https://ganjavores.shop/" },
              { "@type": "ListItem", position: 2, name: "Your Bag", item: "https://ganjavores.shop/cart" },
            ],
          }),
        }}
      />

      <h1 className="gv-section-heading mb-8">Your Bag</h1>

      {lines.length === 0 ? (
        <div className="gv-card text-center py-16">
          <p className="text-white text-lg mb-4">Your bag is empty.</p>
          <Link href="/shop" className="gv-btn-primary inline-block">
            Start Shopping
          </Link>
        </div>
      ) : (
        <>
          <div>
            {lines.map((line) => (
              <CartLineItem key={line.variant_id} line={line} />
            ))}
          </div>

          <div className="flex items-center justify-between mt-6 text-lg">
            <span className="text-white">Subtotal</span>
            <span className="text-emerald font-semibold">${subtotal.toFixed(2)}</span>
          </div>
          <p className="text-soft text-sm mt-1">
            No payment collected online — pay cash or card on delivery or at pickup.
          </p>

          <Link href="/checkout" className="gv-btn-primary w-full block text-center mt-6">
            Checkout
          </Link>
        </>
      )}
    </div>
  );
}

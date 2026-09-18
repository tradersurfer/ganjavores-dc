import type { Metadata } from "next";
import { BUSINESS } from "@/lib/business-info";

export const metadata: Metadata = {
  title: "Pricing — Pay On Arrival, No Online Payments",
  description:
    "Ganjavores DC prices are straightforward. We never collect payments online — you pay the driver or front desk when you receive your order. View our pricing structure, delivery zones, and payment methods.",
  openGraph: {
    title: "Pricing — Ganjavores DC",
    description:
      "No hidden fees. Pay on arrival for delivery or curbside pickup. See our pricing tiers and payment methods.",
    url: "https://ganjavores.shop/pricing",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
    images: [
      {
        url: "/brand/og-image.png",
        width: 1200,
        height: 630,
        alt: "Ganjavores DC — Premium Medical Cannabis Delivery",
      },
    ],
  },
};

const PRICING_TIERS = [
  {
    name: "House Flower (Ganjavores Exclusive)",
    tiers: [
      { weight: "3.5g (1/8 oz)", price: "$45" },
      { weight: "7g (1/4 oz)", price: "$80" },
      { weight: "14g (1/2 oz)", price: "$140" },
      { weight: "28g (1 oz)", price: "$190" },
    ],
  },
];

const PAYMENT_METHODS = [
  { name: "Cash", note: "Exact change preferred." },
  { name: "Card on Arrival", note: "Chip or contactless — no cash-only." },
  { name: "Card at Pickup", note: "At curbside pickup window." },
];

const DELIVERY_INFO = [
  { label: "Service area", value: BUSINESS.serviceArea },
  { label: "Hours", value: BUSINESS.hours.display },
  { label: "Phone", value: `${BUSINESS.phone}` },
  { label: "Store address", value: `${BUSINESS.address.street}, ${BUSINESS.address.city}, ${BUSINESS.address.state} ${BUSINESS.address.zip}` },
  { label: "Payment", value: "Cash or card — paid on arrival" },
];

export default function PricingPage() {
  return (
    <div className="max-w-4xl mx-auto px-4 md:px-6 py-16">
      {/* FAQPage JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "FAQPage",
            mainEntity: [
              {
                "@type": "Question",
                name: "Do you charge extra for delivery?",
                acceptedAnswer: {
                  "@type": "Answer",
                  text: "Delivery is free on orders over $100. Small orders under $100 may incur a nominal delivery fee, confirmed at checkout.",
                },
              },
              {
                "@type": "Question",
                name: "How is pricing structured on the website?",
                acceptedAnswer: {
                  "@type": "Answer",
                  text: "All product prices are listed on our menu at ganjavores.shop/shop. Each product shows its weight-based variants (e.g. 3.5g, 7g, 14g, 28g) and corresponding prices. You see the exact total at checkout before placing your order.",
                },
              },
              {
                "@type": "Question",
                name: "Can I change or cancel my order after placing it?",
                acceptedAnswer: {
                  "@type": "Answer",
                  text: "Orders can be changed or canceled before a driver is dispatched. Once your delivery agent calls to confirm, we prepare your order fresh and cannot accept changes. Call 202-709-8944 as soon as possible if you need to modify your order.",
                },
              },
            ],
          }),
        }}
      />

      <h1 className="gv-section-heading mb-4">Pricing &amp; Payment Info</h1>
      <p className="text-soft mb-8 max-w-2xl">
        Every product price is listed on our menu — no hidden fees. We do not collect
        payments online. You pay cash or card when you receive your order, either at
        your door (delivery) or at our curbside pickup window.
      </p>

      <div className="grid md:grid-cols-3 gap-8 mt-12">
        {/* Pricing Tiers */}
        <div className="gv-card">
          <h2 className="text-white font-display text-xl mb-4">House Flower Tiers</h2>
          {PRICING_TIERS.map((tier) => (
            <div key={tier.name} className="mb-4">
              <h3 className="text-emerald text-sm font-semibold mb-2">{tier.name}</h3>
              <div className="space-y-1">
                {tier.tiers.map((t) => (
                  <div
                    key={t.weight}
                    className="flex justify-between text-sm"
                  >
                    <span className="text-soft">{t.weight}</span>
                    <span className="text-white">{t.price}</span>
                  </div>
                ))}
              </div>
            </div>
          ))}
          <p className="text-xs text-soft/70 mt-4">
            Third-party brand pricing is listed per-product on our{" "}
            <a
              href="/shop"
              className="text-emerald hover:text-neon"
            >
              Shop
            </a>{" "}
            page.
          </p>
        </div>

        {/* Payment Methods */}
        <div className="gv-card">
          <h2 className="text-white font-display text-xl mb-4">Payment Methods</h2>
          <div className="space-y-3">
            {PAYMENT_METHODS.map((pm) => (
              <div key={pm.name}>
                <span className="text-white font-semibold text-sm">{pm.name}</span>
                <p className="text-soft text-xs">{pm.note}</p>
              </div>
            ))}
          </div>
          <p className="text-xs text-soft/70 mt-4">
            No credit card information is stored or processed on our site.
          </p>
        </div>

        {/* Delivery Info */}
        <div className="gv-card">
          <h2 className="text-white font-display text-xl mb-4">Delivery Details</h2>
          <div className="space-y-2 text-sm">
            {DELIVERY_INFO.map((item) => (
              <div
                key={item.label}
                className="flex justify-between"
              >
                <span className="text-soft">{item.label}:</span>
                <span className="text-white text-right max-w-[180px]">{item.value}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="mt-12 border-t border-border pt-8">
        <h2 className="gv-section-heading mb-4">Questions?</h2>
        <p className="text-soft mb-4">
          Have a specific question about pricing or delivery? Call or text us at{" "}
          <a
            href={`tel:${BUSINESS.phone}`}
            className="text-emerald hover:text-neon"
          >
            {BUSINESS.phone}
          </a>
          , or visit our{" "}
          <a href="/contact" className="text-emerald hover:text-neon">
            contact page
          </a>
          .
        </p>
      </div>
    </div>
  );
}

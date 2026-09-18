import type { Metadata } from "next";
import { FAQSection, GANJAVORES_FAQ, generateFAQJsonLd } from "@/components/home/faq-section";

export const metadata: Metadata = {
  title: "FAQ — Ganjavores DC Medical Cannabis Questions",
  description:
    "Answers to common questions about ordering, delivery, ID requirements, payment methods, and our DC medical cannabis program.",
  openGraph: {
    title: "FAQ — Ganjavores DC",
    description: "Common questions about delivery, ordering, ID, and payment.",
    url: "https://ganjavores.shop/faq",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
    images: [{ url: "/api/og?title=FAQ%20%E2%80%94%20Ganjavores%20DC&subtitle=Common%20Questions" }],
  },
};

export default function FAQPage() {
  return (
    <div className="max-w-4xl mx-auto px-4 md:px-6 py-16">
      {/* FAQPage JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify(generateFAQJsonLd()),
        }}
      />

      <h1 className="gv-section-heading mb-4">Frequently Asked Questions</h1>
      <p className="text-soft mb-8 max-w-2xl">
        Answers to common questions about ordering, delivery, ID requirements,
        payment methods, and our licensed medical cannabis program in
        Washington, DC and the DMV.
      </p>

      <FAQSection items={GANJAVORES_FAQ} />

      <div className="mt-12 border-t border-border pt-8 text-center">
        <p className="text-soft">
          Still have a question? Call or text{" "}
          <a
            href="tel:2027098944"
            className="text-emerald hover:text-neon"
          >
            202-709-8944
          </a>{" "}
          or visit our{" "}
          <a href="/contact" className="text-emerald hover:text-neon">
            contact page
          </a>
          .
        </p>
      </div>
    </div>
  );
}

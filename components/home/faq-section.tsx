import { BUSINESS } from "@/lib/business-info";

export interface FAQItem {
  question: string;
  answer: string;
}

export const GANJAVORES_FAQ: FAQItem[] = [
  {
    question: "How do I place an order with Ganjavores DC?",
    answer:
      "Browse our full menu at ganjavores.shop/shop, add items to your cart, and check out. You are NOT charged online — payment is collected only when you receive your order. You can also call or text us at 202-709-8944 to place an order directly.",
  },
  {
    question: "What areas do you deliver to?",
    answer:
      `We deliver across ${BUSINESS.serviceArea}. Curbside pickup is also available at our location at ${BUSINESS.address.street}, ${BUSINESS.address.city}, ${BUSINESS.address.state} ${BUSINESS.address.zip}.`,
  },
  {
    question: "What do I need to receive a delivery?",
    answer:
      "You must be 21 years of age or older, or a valid DC medical cannabis patient. When your order arrives, present a valid government-issued Photo ID for age verification. You may also send a clear photo of your ID in advance if preferred.",
  },
  {
    question: "Do you accept credit cards or online payments?",
    answer:
      "No. We do not collect any payments online. All orders are paid in full when you receive your delivery or at curbside pickup — cash, card (on arrival), or other in-person methods.",
  },
  {
    question: "How long does delivery take?",
    answer:
      "Delivery times vary based on your location and current order volume. Most orders in Washington, DC are delivered the same day. Once you place your order, a delivery agent will contact you by SMS or phone to confirm timing.",
  },
  {
    question: "Is Ganjavores DC medical cannabis only?",
    answer:
      "Yes — Ganjavores DC is a licensed Medical Cannabis Internet Retailer under DC ABCA. We serve both registered DC medical cannabis patients and adult-use customers who are 21+, as permitted under DC law.",
  },
  {
    question: "What products do you carry?",
    answer:
      "We carry premium flower, vapes (cartridges and disposables), edibles, pre-rolls, and concentrates from top brands like Rise, Cookies, Royal Smoke, District Cannabis, The DC Dispensary, and Grow West — plus our own house line, Ganjavores Exclusive, which offers top quality at lower prices.",
  },
  {
    question: "Are your products lab tested?",
    answer:
      "Yes. Every product on our menu is sourced from licensed, state-regulated suppliers and comes with verified lab-test data for potency (THC/CBD) and terpene profiles. You can view full cannabinoid and terpene panels on each product page.",
  },
  {
    question: "Can I pick up my order in person?",
    answer:
      `Yes — curbside pickup is available at our location: ${BUSINESS.address.street}, ${BUSINESS.address.city}, ${BUSINESS.address.state} ${BUSINESS.address.zip}. Simply select "curbside pickup" at checkout and enter our store address as your pickup location.`,
  },
  {
    question: "Do you offer discounts or loyalty rewards?",
    answer:
      "Yes — check our Deals page for current specials and limited-time offers. We also offer a first-time customer discount; text or call 202-709-8944 to ask about promotions.",
  },
];

interface FAQSectionProps {
  items?: FAQItem[];
  title?: string;
  description?: string;
}

export function FAQSection({ items = GANJAVORES_FAQ, title, description }: FAQSectionProps) {
  const faqTitle = title ?? "Frequently Asked Questions";
  const faqDesc =
    description ??
    "Answers to common questions about ordering, delivery, ID requirements, and our medical cannabis program.";

  return (
    <section className="max-w-4xl mx-auto px-4 md:px-6 py-16 border-t border-border">
      <h2 className="gv-section-heading mb-2 text-center">{faqTitle}</h2>
      {faqDesc && <p className="text-soft text-center max-w-2xl mx-auto mb-10">{faqDesc}</p>}
      <div className="space-y-4">
        {items.map((faq, i) => (
          <details
            key={i}
            className="gv-card group"
          >
            <summary className="cursor-pointer list-none flex items-center justify-between">
              <h3 className="text-white font-semibold pr-4">{faq.question}</h3>
              <span className="text-emerald group-open:rotate-180 transition-transform duration-200">
                ▼
              </span>
            </summary>
            <p className="text-soft text-sm mt-3 leading-relaxed">{faq.answer}</p>
          </details>
        ))}
      </div>
    </section>
  );
}

/**
 * Returns FAQPage JSON-LD for the standard FAQ set.
 * Pass a custom `items` array to override (e.g. page-specific questions).
 */
export function generateFAQJsonLd(items: FAQItem[] = GANJAVORES_FAQ) {
  return {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: items.map((faq) => ({
      "@type": "Question",
      name: faq.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: faq.answer,
      },
    })),
  };
}

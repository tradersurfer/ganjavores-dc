import { BUSINESS } from "@/lib/business-info";

const STEPS = [
  {
    number: "01",
    title: "Place Your Order",
    body: [
      "Online Orders — Browse our full menu, add items to your cart, and check out. You are not charged online — payment is collected only when you receive your order. Enter your delivery address in the shipping section. For curbside pickup, enter our store address: 531 8th St SE, Washington, DC 20003.",
      "Call or Text Orders — Prefer to order by phone? Call or text us at 202-709-8944. We'll take your order and confirm the details with you.",
    ],
  },
  {
    number: "02",
    title: "We Contact You",
    body: [
      "Once your order is placed, one of our delivery agents will reach out by SMS or phone call to confirm everything.",
    ],
    list: [
      "A correct delivery address",
      "A working phone number",
      "That you have a valid Photo ID ready",
    ],
    footer: "Delivery times vary based on your location and current order volume.",
  },
  {
    number: "03",
    title: "Age Verification",
    body: [
      "After your order is confirmed, we dispatch a driver (for delivery orders). When the driver arrives, you must present a valid Photo ID for age verification. You may also send a clear photo of your ID in advance if preferred.",
      "You must be 21 years of age or older, or a valid DC medical cannabis patient, to receive an order.",
    ],
  },
  {
    number: "04",
    title: "Get Your Delivery",
    body: [
      "Your order arrives discreetly at your door — or is ready for curbside pickup. Pay the driver or team member when you receive your products.",
    ],
    footer: "That's it. Fast, simple, and fully compliant.",
  },
];

export function DeliveryProcess() {
  return (
    <section className="max-w-5xl mx-auto px-4 md:px-6 py-16 border-t border-border">
      <div className="text-center mb-12">
        <h2 className="gv-section-heading">
          How Does the Online DC Weed Delivery Process Work?
        </h2>
        <p className="text-soft mt-3 max-w-2xl mx-auto">
          Ordering from Ganjavores DC is simple, discreet, and designed around your
          convenience. Here&rsquo;s exactly how it works:
        </p>
      </div>

      <div className="grid md:grid-cols-2 gap-8">
        {STEPS.map((step) => (
          <div key={step.number} className="gv-card">
            <div className="flex items-baseline gap-3 mb-3">
              <span className="font-display text-3xl text-emerald">{step.number}</span>
              <h3 className="font-display text-xl text-white">{step.title}</h3>
            </div>
            {step.body.map((p, i) => (
              <p key={i} className="text-soft text-sm leading-relaxed mb-3">
                {p}
              </p>
            ))}
            {step.list && (
              <ul className="text-soft text-sm space-y-1 mb-3 list-disc list-inside">
                {step.list.map((item) => (
                  <li key={item}>{item}</li>
                ))}
              </ul>
            )}
            {step.footer && (
              <p className="text-white text-sm font-medium">{step.footer}</p>
            )}
          </div>
        ))}
      </div>

      <p className="text-center text-soft text-sm mt-10">
      Questions? Call or text{" "}
      <a href={`tel:${BUSINESS.phone}`} className="text-emerald hover:text-neon">
        {BUSINESS.phone}
      </a>{" "}
      .
      </p>
    </section>
  );
}

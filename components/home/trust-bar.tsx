import { Package, ShieldCheck, Leaf } from "lucide-react";

const FEATURES = [
  { icon: Package, title: "Fast Delivery", desc: "Across DC & the DMV, most orders same day." },
  { icon: ShieldCheck, title: "Lab Tested", desc: "Every product comes from licensed, tested suppliers." },
  { icon: Leaf, title: "Ganjavores Exclusive", desc: "Our house line — top quality, priced lower." },
  { icon: Package, title: "Discreet Service", desc: "Plain packaging, no payment collected online." },
];

export function TrustBar() {
  return (
    <section className="max-w-6xl mx-auto px-4 md:px-6 py-12">
      <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
        {FEATURES.map((f) => (
          <div key={f.title} className="text-center">
            <div className="text-emerald mb-2 flex justify-center">
              <f.icon size={28} />
            </div>
            <h3 className="text-white font-semibold text-sm">{f.title}</h3>
            <p className="text-soft text-xs mt-1">{f.desc}</p>
          </div>
        ))}
      </div>
    </section>
  );
}

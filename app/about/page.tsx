import type { Metadata } from "next";
import { BUSINESS } from "@/lib/business-info";
import { GoogleMapEmbed } from "@/components/google-map-embed";

export const metadata: Metadata = {
  title: "About Us",
  description:
    "Ganjavores DC is a licensed medical cannabis Internet Retailer under DC ABCA, serving Washington DC and the DMV with discreet delivery and curbside pickup.",
};

export default function AboutPage() {
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-6 py-16">
      <h1 className="gv-section-heading mb-6">About Ganjavores DC</h1>

      <div className="space-y-6 text-soft leading-relaxed">
        <p>
          Ganjavores DC is a licensed medical cannabis Internet Retailer under the DC
          ABCA. We specialize in premium flower, vapes, edibles, pre-rolls, and
          concentrates — plus our own house line, <span className="text-emerald">Ganjavores Exclusive</span>,
          a lower-priced alternative to the most popular brands without cutting quality.
        </p>

        <p>
          We deliver discreetly across Washington DC and the DMV, with curbside pickup
          available at our location. No online payments are ever collected — you place
          your order, and pay when it arrives or at pickup.
        </p>

        <p>
          Every product on our menu is sourced from licensed, lab-tested suppliers. We
          carry a rotating lineup from names the DMV already trusts, and we're always
          adding more.
        </p>

        <blockquote className="border-l-2 border-emerald pl-4 text-white italic">
          {BUSINESS.slogans.primary}
        </blockquote>

        <div className="gv-card mt-10">
          <h2 className="text-white font-display text-xl mb-4">Visit or Contact Us</h2>
          <p>
            {BUSINESS.address.street}, {BUSINESS.address.city}, {BUSINESS.address.state}{" "}
            {BUSINESS.address.zip}
          </p>
          <p className="mt-2">
            <a href={`tel:${BUSINESS.phone}`} className="text-emerald hover:text-neon">
              {BUSINESS.phone}
            </a>
          </p>
          <p>
            <a href={`mailto:${BUSINESS.email}`} className="text-emerald hover:text-neon">
              {BUSINESS.email}
            </a>
          </p>
          <p className="mt-2">{BUSINESS.hours.display}</p>
        </div>

        <GoogleMapEmbed className="mt-6" />

        <p className="text-xs text-soft/70 pt-6 border-t border-border">
          {BUSINESS.license}. For use only by persons 21 years of age or older, or valid
          DC medical cannabis patients. All cannabis products are final sale.
        </p>
      </div>
    </div>
  );
}

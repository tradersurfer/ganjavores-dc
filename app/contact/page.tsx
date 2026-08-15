import type { Metadata } from "next";
import { BUSINESS } from "@/lib/business-info";
import { ContactForm } from "@/components/contact-form";
import { GoogleMapEmbed } from "@/components/google-map-embed";

export const metadata: Metadata = {
  title: "Contact",
  description: "Get in touch with Ganjavores DC — call, text, or send a message.",
};

export default function ContactPage() {
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-6 py-16">
      <h1 className="gv-section-heading mb-2">Contact Us</h1>
      <p className="text-soft mb-8">
        Fastest way to reach us is by phone or text — email and this form work too, just
        expect a slightly longer response time.
      </p>

      <div className="grid md:grid-cols-2 gap-8">
        <div className="space-y-6">
          <div>
            <h2 className="text-white font-semibold mb-1">Call or Text</h2>
            <a href={`tel:${BUSINESS.phone}`} className="text-emerald hover:text-neon">
              {BUSINESS.phone}
            </a>
          </div>
          <div>
            <h2 className="text-white font-semibold mb-1">Email</h2>
            <a href={`mailto:${BUSINESS.email}`} className="text-emerald hover:text-neon">
              {BUSINESS.email}
            </a>
          </div>
          <div>
            <h2 className="text-white font-semibold mb-1">Location</h2>
            <p className="text-soft">
              {BUSINESS.address.street}
              <br />
              {BUSINESS.address.city}, {BUSINESS.address.state} {BUSINESS.address.zip}
            </p>
          </div>
          <div>
            <h2 className="text-white font-semibold mb-1">Hours</h2>
            <p className="text-soft">{BUSINESS.hours.display}</p>
            <p className="text-soft text-sm mt-1">Delivery &amp; Curbside Pickup Only</p>
          </div>
          <GoogleMapEmbed />
        </div>

        <ContactForm />
      </div>
    </div>
  );
}

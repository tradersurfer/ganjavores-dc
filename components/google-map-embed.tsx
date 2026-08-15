import { BUSINESS } from "@/lib/business-info";

/**
 * Uses the no-API-key "maps.google.com/maps?q=...&output=embed" iframe
 * format rather than the official Maps Embed API, since that requires a
 * billing-enabled Google Cloud API key you haven't set up yet. This
 * works fine for a basic pinned-address embed. If you want the official
 * embed later (nicer styling controls, guaranteed long-term support),
 * get a Maps Embed API key from console.cloud.google.com and swap the
 * src below for https://www.google.com/maps/embed/v1/place?key=YOUR_KEY&q=...
 */
export function GoogleMapEmbed({ className = "" }: { className?: string }) {
  const query = encodeURIComponent(
    `${BUSINESS.address.street}, ${BUSINESS.address.city}, ${BUSINESS.address.state} ${BUSINESS.address.zip}`
  );

  return (
    <div className={`rounded-card overflow-hidden border border-border ${className}`}>
      <iframe
        title="Ganjavores DC Location"
        src={`https://maps.google.com/maps?q=${query}&output=embed`}
        width="100%"
        height="320"
        style={{ border: 0 }}
        loading="lazy"
        referrerPolicy="no-referrer-when-downgrade"
      />
    </div>
  );
}

/**
 * Single source of truth for business info that shows up in the header,
 * footer, structured data, and legal copy. Edit here, not scattered
 * across components.
 *
 * Phone number roles (confirmed by Adrian, Round 6):
 *   - 202-709-8944 — CORPORATE / DISPATCH. Routes to all partner
 *     dispensaries Ganjavores delivers for. This is the number the
 *     site shows and the number checkout confirmations reference.
 *   - 202-735-3958 — old delivery number tied to the now-shut-down
 *     Shopify store. Not used anywhere in this build.
 *   - 202-455-0175 — the number printed on the physical window sign.
 *     Vendor-facing only, not promoted publicly, not routed to
 *     customer calls. Not used anywhere in this build.
 *   - 202-300-7559 — a co-owner's PERSONAL number that ended up on
 *     third-party directories by accident (marketing is working on
 *     getting it removed). Never put this one anywhere in the codebase.
 *
 * ganjavores.com's old Shopify store is confirmed dead (redirects to a
 * generic "this website is not available" Shopify landing page) — see
 * DEPLOYMENT.md, this clears the way to point the domain straight at
 * this new build without worrying about taking down a live store.
 */
export const BUSINESS = {
  name: "Ganjavores DC",
  legalName: "Ganjavores DC LLC",
  phone: "202-709-8944",
  email: "info@ganjavores.com",
  address: {
    street: "531 8th St SE",
    city: "Washington",
    state: "DC",
    zip: "20003",
  },
  hours: {
    // adjustable in /admin later — this is the fallback default
    display: "12PM – 10PM Daily",
  },
  serviceArea: "Washington, DC & the DMV",
  slogans: {
    primary: "We Don't Compete — We Consume the Competition.",
    delivery: "Fast Delivery. Top Quality.",
    local: "Serving DC & the DMV",
  },
  social: {
    x: "https://x.com/ganjavores",
    instagram: "",
    tiktok: "",
  },
  // Google Business Profile + Apple Maps share.google links you sent still
  // can't be auto-resolved (both block automated access) — paste the
  // resolved long-form URLs here once you have them. Not blocking launch;
  // the site works fine without these, they're just nice-to-have footer links.
  googleBusinessProfileUrl: "",
  appleMapsUrl: "",
  license: "Licensed Medical Cannabis Internet Retailer under DC ABCA",
} as const;

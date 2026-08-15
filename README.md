# Ganjavores DC — Build Notes

## What's scaffolded so far
- `supabase/schema.sql` — full DB schema, RLS policies, seed data for categories + brands
- Tailwind config with your locked brand colors (`emerald`, `midnight`, `neon`, `soft`, `border`, `highlight`)
- Supabase server + browser client helpers
- Root layout, age gate, header (custom nav — not District's label set), footer
- Shared TS types matching the schema 1:1

## Schema decisions made (flag if wrong)
1. **Multi-vendor catalog.** Added a `brands` table with `is_house_brand` flag.
   Ganjavores by Lee Farms is `is_house_brand = true`; Rise, Cookies, Royal
   Smoke, District Cannabis, The DC Dispensary, and Grow West are seeded as
   regular brands. `is_ganjavores_exclusive` on `products` is a separate
   boolean — that's your badge/positioning flag, not the same thing as
   which brand made it (a product can be from the house brand without
   being flagged "Exclusive," in case you ever want that distinction).
2. **Variants table**, not a flat price field — handles "1/8oz $35" style
   weight/price selectors, matches what you screenshotted.
3. **Terpene + cannabinoid panels** as their own tables (not JSON blobs) so
   the admin can edit them as structured rows, same depth as the District
   PDPs you want to match.
4. **Reviews start unapproved** — customer submits, you approve in admin
   before it's public. No open review spam risk.
5. **Orders have zero payment fields on purpose** — no Stripe, no card
   fields, nothing. Just fulfillment + contact info, per your "pay on
   delivery/pickup" rule.

## Asset placement plan (pending your confirm)
| Asset | Where I'm putting it |
|---|---|
| Storefront photo (image2) | Homepage hero — primary banner, as you said |
| Delivery van (image1) | Secondary homepage banner, below hero |
| Illustrated skyline/leaf graphic (image3) | Mobile-only hero variant (`mobile_image_url` on the hero announcement row) — shows on small screens instead of the storefront photo, since it's clearly composed for a narrow mobile crop |
| "Grand Opening"-style promo banners (image4, image5) | `/deals` page promo grid, same slot as District's specials cards |
| Product photos (flower, grinder, pre-rolls, RAW cones, Lookah batteries, Jeeter Juice ×6, RAW×Lyrical Lemonade wrap) | Queued for product entry once you confirm price/weight/THC% per item — see below |

## Still needed from you
- **Image 20 (flower bag)** didn't come through — only 19 files attached this round, last one was the RAW × Lyrical Lemonade tube.
- **Logo file usage** — right now the header just renders text ("Ganjavores" in emerald). Once your actual logo PNG is placed in `/public/brand/`, I'll swap it in — say the word or I'll do it automatically once I see a dedicated logo upload.
- Per-product pricing/weights/THC% for the batch of product images sent — I can draft placeholder copy in your voice for all of them now if you want to review/edit rather than wait, or hold until you send exact figures. Your call.

## Schema: mine vs. Grok's — judgment call made
You sent Grok's version this round. I kept mine as the source of truth and did **not** merge Grok's in. Reasoning:
- Grok's `products` table is flat (single `price`, single `image_url`, `brand` as a plain text field). That can't support what you actually need: multiple weights per product ("1/8oz $35 / 1oz $120"), multiple product photos, or a real brand entity with its own page (you explicitly said you carry Rise, Cookies, Royal Smoke, District Cannabis, The DC Dispensary, Grow West — those need to be rows, not strings).
- Grok's terpene/cannabinoid data doesn't exist at all — you asked for District-level PDP depth, which needs those as structured tables to be admin-editable.
- The one thing worth pulling from Grok's version: the `handle_updated_at()` trigger pattern for auto-updating `updated_at` — cleaner than doing it in application code. I've added that to the schema.
- Everything else (order structure, RLS approach, announcements) is equivalent between the two, so no loss in dropping Grok's.

If you specifically want the simpler flat schema instead (less admin-panel work to build, less depth on PDPs), say so and I'll swap — but it conflicts with your PDP depth request, so I made the call to keep mine.

## Old Shopify theme — what I did and didn't carry over
Pulled the visual/interaction ideas that are still useful: the "Local Trust" split section pattern, tabbed collections, deals countdown banner, and the font pairing approach (a condensed display face + clean sans + mono for labels — I'll pick actual fonts once we're styling, not literally Bebas/DM Sans/Space Mono unless you want those specifically).

**Did NOT carry over:** that theme was built for **Ganjavores Winston-Salem** as a **THCA/hemp Farm Bill-compliant** shop — different product category and different legal framework than DC medical cannabis. Its education section, "Farm Bill Compliant" badges, and THCA-non-intoxicating-until-heated copy are all wrong for Ganjavores DC and I left them out entirely. Also flagging: the "Compound Banner Website.png" promo graphic has Visa/Mastercard/PayPal icons on it — that directly contradicts the no-online-payment rule, so I filed it under banners but it needs a redesign before it goes live anywhere on the DC site.

## Assets now in the scaffold (`/public`)
- `brand/logo.png`, `brand/banner-primary.png` — your logo + storefront hero photo
- `products/flower/` — the 7 house-brand mylar bag mockups (black bag, green cursive logo, STRAIN/INDICA-SATIVA-HYBRID/weight label format — this is now the reference template for how every flower product card should look)
- `products/edibles/` — 31 cartridge/disposable/edible photos, filenames slugified (e.g. `jeeter-cart-gelato.png`, `muha-meds-disposable-vape-skywalker-og.png`)
- `banners/` — Grand Opening Sale, Disposable Sale 2024, and two promo banners (one needs the payment-icon fix noted above before use)

## Not started yet (needs more assets or your go-ahead)
- Judge.me/Loox review widget swap-in — native reviews are already built and working; only relevant if you specifically want one of these providers instead.
- Real Google Business Profile / Apple Maps URLs — the share.google links you sent can't be auto-resolved (see DEPLOYMENT.md), so these fields are empty until you paste the resolved links in.

## Round 6 additions (confirmed business info, Resend wired live, Klaviyo signup)

**Business info resolved.** Phone number conflict is settled — 202-709-8944 is the
real corporate/dispatch number and is what the site already used, so no code change
needed there beyond documenting *why* the other three numbers exist (dispatch vs. old
Shopify number vs. vendor-only window sign vs. a co-owner's personal number that
shouldn't be public — all explained in `lib/business-info.ts` so nobody re-litigates
this later). Real X link added: `x.com/ganjavores`. Confirmed the old Shopify store is
dead, which simplifies `DEPLOYMENT.md`'s domain section — Option A (point
`ganjavores.com` straight at this build) is now the clear recommendation instead of a
hedge between two options.

**Resend API key handling.** You shared a live key in chat — per your instruction and
as standard practice for any secret, I didn't repeat it, and it's not written into any
file in this project (confirmed by grepping the whole repo for fragments of it before
packaging — clean). The code in `lib/notify.ts` already reads `RESEND_API_KEY` from
`process.env`, so there's nothing to change there; the key itself goes directly into
Vercel's environment variable dashboard at deploy time, per the updated Step 6 in
`DEPLOYMENT.md`. That's the correct home for it regardless of who's holding the key —
never in a committed file, never in a zip that gets passed around.

**Klaviyo email/SMS capture** (`components/klaviyo-signup.tsx`) — added to the
homepage, right before the delivery-process section. Posts directly to Klaviyo's
subscribe API using your public API key + list ID rather than requiring you to build a
form in Klaviyo's UI first (that path needs a form ID that doesn't exist until you've
already built something there). No-ops safely if
`NEXT_PUBLIC_KLAVIYO_PUBLIC_KEY`/`NEXT_PUBLIC_KLAVIYO_LIST_ID` aren't set — setup steps
are in the component's comments.

## Round 5 additions (Google Maps embed, social links, contact inbox, deployment guide)

**Researched your three links** — couldn't actually verify any of them directly;
`share.google` redirect links block automated fetching (Google Maps, Apple Maps, and
X all returned the same robots-disallowed error). Web search around them surfaced a
few things worth flagging rather than silently working around:

- **Four different phone numbers** have shown up across this project: 202-709-8944
  (what's built into the site), 202-735-3958 (live right now on ganjavores.com's
  existing Shopify store), 202-455-0175 (printed on your window sign banner image),
  and 202-300-7559 (third-party directories). Documented the conflict directly in
  `lib/business-info.ts` rather than picking one silently — confirm before launch.
- **`ganjavores.com` is a live, active Shopify store right now** — real products,
  real vendors ("Just Flower", "Alien Labs" alongside your own). Worth deciding how
  this new build relates to it before going live; covered in `DEPLOYMENT.md`.
- Couldn't resolve an actual X/Twitter handle — added a `social.x` field to
  `business-info.ts` that's empty until you paste the real URL in (the footer only
  renders social links that are actually set, so this doesn't show a broken link
  in the meantime).

**Google Maps embed** — added without requiring a paid API key (uses the
no-key `maps.google.com/maps?q=...&output=embed` iframe format), on both `/about`
and `/contact`. Noted in the component where to upgrade to the official Maps Embed
API later if you want it.

**Contact messages admin inbox** (`/admin/messages`) — the contact form from last
round wrote to a table with no way to read it except the Supabase table editor;
now there's an actual inbox page with a mark-read toggle.

**Order notifications** — replaced the `TODO` comment with a working
`sendOrderNotification()` call via Resend. It no-ops safely if
`RESEND_API_KEY` isn't set (orders still save fine either way), starts firing the
moment you add the key. **Caught and fixed a bug here before it shipped**: the
notification function needed the order number, but the insert query only selected
`id` back — `order.order_number` would have been `undefined` in every email. Fixed
by keeping the generated order number in a local variable instead of only reading
it back from the database response.

**`DEPLOYMENT.md`** — full step-by-step: Supabase project creation, running the
migrations in order, creating your first admin login (including the
`admin_profiles` insert step that's easy to miss and causes every admin page to
silently fail permission checks), collecting API keys, pushing to GitHub, deploying
on Vercel, and pointing your domain at it — with explicit A/B guidance on the
"replace ganjavores.com outright" vs. "stand up on a subdomain first" decision,
given that domain currently has a live store on it.

## Round 4 additions (admin brand/category CRUD, real image upload, /about, /contact)

**Admin → Brands and Admin → Categories** — full CRUD, inline-editable rows (click
pencil, edit in place, save/cancel), matching the pattern the rest of admin already
uses. Deleting a brand or category doesn't delete its products — `ON DELETE SET NULL`
in the schema just un-links them, so nothing gets orphaned or lost by accident.

**Real image upload** — replaced the "paste a URL" placeholder with an actual upload
button wired to Supabase Storage. Added `supabase/storage-setup.sql` (run once, creates
a public `product-images` bucket with admin-only write policies) and
`components/admin/image-upload-button.tsx`, a reusable widget now used on product
images, the new-product form, and brand logos. The paste-a-URL option is still there
side-by-side for anyone who already has an image hosted elsewhere — upload isn't
required, just faster.

**`/about` and `/contact`** — about page uses your existing business copy/slogan.
Contact page has a real form (name/email/phone/subject/message) that writes to a new
`contact_messages` table — added as `supabase/migration-contact-messages.sql` since it's
additive to what you may have already run. No admin viewer for these yet; they're
readable straight from the Supabase table editor in the meantime.

## Migration files to run, in order, if starting fresh
1. `supabase/schema.sql`
2. `supabase/storage-setup.sql`
3. `supabase/migration-contact-messages.sql`
4. `supabase/seed-products.sql` (optional — placeholder catalog data)

If you already ran `schema.sql` in an earlier round, you only need 2–4 now.

## Round 3 additions (shop grid → PDP → cart/checkout → admin, in that order)

**Shop grid (`/shop`)** — URL-driven filters (category, brand, strain type, price range,
minimum THC%, exclusive-only), debounced search, 5 sort modes, pagination. Filtering
against variant price and brand happens in application code rather than a single
Supabase query, since a product's "price" is really "cheapest active variant" and
Supabase can't cleanly filter a parent row by an aggregate over a joined table in one
call — fine at this catalog size (dozens to low hundreds of products); if the catalog
grows into the thousands, this should move to a Postgres view or function instead.

**PDP (`/product/[slug]`)** — full gallery, variant/quantity picker, description
show-more/less, collapsible terpene/cannabinoid/reviews/brand panels (District-depth,
built for real data now), review submission (queues unapproved), related products
(manually curated via `related_products`, falls back to same-category), and
Product JSON-LD for SEO.

**Cart & checkout** — cart is a localStorage-backed React context (`lib/cart-context.tsx`),
no accounts needed. Checkout is React Hook Form + Zod, zero payment fields anywhere,
writes straight to `orders`/`order_items` via a server action, lands on a confirmation
page. **One real bug I caught and fixed while building this**: the confirmation page
needs to read back the order it just created, and the obvious move — a public RLS
`SELECT` policy on `orders` — would have let anyone holding the public anon key (which
ships in every page's client JS) list every customer's name, phone, and address via the
Supabase REST API directly, not just look up the one they placed. Fixed by adding
`lib/supabase/service.ts`, a service-role client used only in this one trusted
server-rendered page (and reusable later for admin reads). **You'll need to add
`SUPABASE_SERVICE_ROLE_KEY` to your environment variables** (Supabase Dashboard →
Settings → API → service_role key) — keep it server-side only, never `NEXT_PUBLIC_*`.

**Admin panel (`/admin`)** — Supabase Auth email/password login, middleware-protected.
**Second bug caught and fixed**: I initially put the auth-guard layout directly at
`app/admin/layout.tsx`, which would have wrapped `/admin/login` too and infinite-redirect
looped for anyone not logged in. Fixed by moving the guard into a
`app/admin/(protected)/` route group so login sits outside it — same URLs, correct
behavior. Covers: dashboard (recent orders, low stock, pending reviews), full product
CRUD (fields, variants with inline inventory edit, images, terpene/cannabinoid rows),
order list with status changes, announcements CRUD (feeds the homepage hero/secondary
banner and the deals page), and a reviews moderation queue.

**Homepage** — hero (swaps in the storefront photo on desktop / the illustrated skyline
graphic on mobile, both editable via an `announcements` row if you want to override
them), secondary banner using the delivery van photo, trust bar, featured products pulled
from `is_featured`, category grid, and the delivery-process section you sent this round.

**One content edit I made in that section, flagging it directly**: your copy said "You
must be 21 years of age or older for adult-use recreational cannabis." Every other
document you've given me describes Ganjavores DC as a licensed **medical** cannabis
Internet Retailer under DC ABCA — not adult-use recreational retail. I changed that one
line to "21 years of age or older, or a valid DC medical cannabis patient" to stay
consistent with the rest of the site's compliance language, rather than silently leaving
a claim that contradicts your own documentation. If DC recreational sales licensing is
actually a status change I don't know about, tell me and I'll revert it and adjust the
compliance copy sitewide instead.

Also copied over three image files that got *referenced* in the Round 2 README table
but never actually copied to `/public` — the delivery van photo, the illustrated mobile
hero graphic, and the storefront window sign. They're in `/public/brand/` now and wired
into the homepage hero/secondary banner as the defaults.

## Environment variables you'll need
```
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=   # server-only, never expose to the browser
```

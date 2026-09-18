# Ganjavores DC

Licensed medical cannabis **Internet Retailer** (DC ABCA) for delivery and curbside pickup. Pay on arrival. 21+ (or a valid DC medical patient).

- **Site:** https://ganjavores.shop
- **Repo:** https://github.com/tradersurfer/ganjavores-dc (`main`)
- **Local checkout (Adrian):** `C:\Users\jorda\Desktop\Projects\websites\ganjavores-full`
- **Address:** 531 8th St SE, Washington, DC 20003
- **Phone:** 202-709-8944 (corporate / dispatch — the only public number)
- **Email:** info@ganjavores.shop
- **Hours (fallback copy):** 10AM – 10PM daily
- **Slogan:** We Don't Compete — We Consume the Competition.

This is the live Next.js build that replaces the dead Shopify store on `ganjavores.com`. It is **not** the Dreamz DC Compound static site (`tradersurfer/dreamz-dc`). Do not copy `app/`, `lib/`, or `supabase/` into Dreamz.

---

## What this repo is now

A working storefront + admin, not a scaffold.

Customers can browse the catalog, filter the shop, open a District-depth product page, add variants to a localStorage cart, and place an order with **no online payment fields**. Staff can log into `/admin` and manage products, brands, categories, inventory, images, terpenes/cannabinoids, orders, announcements, reviews, and contact-form messages.

The old README was a round-by-round build log. That history is retired. What follows matches the code as of the current `main` tree.

---

## Stack

| Layer | What we use |
|---|---|
| App | Next.js 15 App Router, React 19, TypeScript |
| Style | Tailwind CSS 3 — brand tokens `emerald` `#00D66B`, `midnight` `#0B0E0B`, `neon` `#00FF75`, `soft` `#BBFFDD`, `border` `#00331A`, `highlight` `#39FF14` |
| Data | Supabase (Postgres + Auth + Storage) |
| Cart | `lib/cart-context.tsx` — localStorage, no customer accounts |
| Forms | React Hook Form + Zod (`lib/checkout-schema.ts`) |
| Mail | Resend HTTP API in `lib/notify.ts` (no Resend npm SDK) |
| Email list | Klaviyo public subscribe API in `components/klaviyo-signup.tsx` |
| Hosting | Vercel (see `DEPLOYMENT.md`) |

Scripts: `npm run dev` · `npm run build` · `npm start` · `npm run lint` · `npm run typecheck`

---

## Local run

```bash
npm install
cp .env.example .env.local
# fill the values below
npm run dev
```

Open http://localhost:3000. Admin is http://localhost:3000/admin/login.

You need a Supabase project with the SQL files applied (order is in **Database** below) or every catalog page will render empty.

---

## Environment variables

`.env.example` lists the required three plus Resend. Klaviyo is used in code but not listed there yet.

```
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=          # server only — order confirmation + admin reads
RESEND_API_KEY=                     # optional; checkout still works without it
NEXT_PUBLIC_KLAVIYO_PUBLIC_KEY=     # optional; signup form no-ops until set
NEXT_PUBLIC_KLAVIYO_LIST_ID=        # optional
```

Never commit secrets. Never prefix the service-role key with `NEXT_PUBLIC_`. Step-by-step deploy is in [`DEPLOYMENT.md`](./DEPLOYMENT.md).

---

## Public routes

| Path | What it does |
|---|---|
| `/` | Hero + trust bar + secondary banner + featured products + category grid + Klaviyo + how-to-order + FAQ |
| `/shop` | URL filters: category, brand, strain, price, min THC, exclusive, search, sort, pagination |
| `/product/[slug]` | Gallery, variant/qty picker, description toggle, terpene / cannabinoid / reviews / brand panels, related products, Product JSON-LD |
| `/cart` | Cart lines from localStorage |
| `/checkout` | Contact + fulfillment only. Copy: “Place Order — Pay on Arrival.” Writes `orders` / `order_items`. |
| `/order-confirmation/[id]` | Server-rendered via the service-role client so we do **not** expose a public SELECT on customer PII |
| `/brands` · `/brands/[slug]` | Brand index and brand page |
| `/deals` | Promo / announcements placement |
| `/about` · `/contact` | Business copy + Google Maps embed (no Maps API key). Contact form writes `contact_messages`. |
| `/faq` | Same FAQ set as the homepage, with FAQPage JSON-LD |
| `/pricing` | House-flower weight tiers + payment methods (cash / card on arrival) |
| `/api/og` | Dynamic Open Graph image |
| `/sitemap.xml` · `/robots.txt` | Generated sitemap (`app/sitemap.ts`) plus static files in `public/` |

Age gate (`components/age-gate.tsx`) wraps every public page. Key: `localStorage.gv_age_confirmed`. Admin routes skip it. “Leave” sends the visitor to `dc.gov`.

Header / footer come from `components/site-header.tsx` and `components/site-footer.tsx` via `components/site-chrome.tsx` on the root layout. Search icon in the header is **not wired** (button has no handler). Logo file exists at `public/brand/logo.png`; the header still renders the word “Ganjavores” in emerald — the swap is still a TODO in that file.

---

## Admin

Middleware (`middleware.ts`) sends unauthenticated `/admin/*` traffic to `/admin/login`, except the matcher does not special-case `/admin/request-access`.

| Path | What it does |
|---|---|
| `/admin/login` | Supabase email/password |
| `/admin/request-access` | Magic-link request form |
| `/admin` | Dashboard: recent orders, low stock, pending reviews |
| `/admin/products` · `/new` · `/[id]` | Product CRUD, variants + inventory, images (Supabase Storage upload **or** paste a URL), terpenes, cannabinoids |
| `/admin/brands` · `/admin/categories` | Inline-editable rows. Delete unlinks products (`ON DELETE SET NULL`), it does not cascade-delete them. |
| `/admin/orders` | Status changes |
| `/admin/announcements` | Feeds homepage hero, secondary banner, and `/deals` |
| `/admin/reviews` | Moderation queue — customer reviews start unapproved |
| `/admin/messages` | Contact inbox + mark-read |

First admin user: create the Auth user in Supabase, then insert that UID into `admin_profiles`. Skipping the insert lets you log in and then see empty / permission-denied pages. Details in `DEPLOYMENT.md`.

---

## Folder map

```
app/                  routes, server actions, OG API, sitemap
app/actions/          checkout, contact, reviews, admin mutations
components/           storefront + admin UI
components/home/      hero, trust bar, banners, categories, delivery steps, FAQ
components/shop/      filters, search, pagination
components/product/   gallery, add-to-cart, reviews, collapsibles
components/admin/     row editors, image upload, variant + potency managers
lib/business-info.ts  phone, address, hours, socials, license — edit here
lib/cart-context.tsx
lib/checkout-schema.ts
lib/notify.ts         Resend “new order” email
lib/types.ts          TS types aligned to the schema
lib/supabase/         browser client, server client, service-role client, queries
supabase/             schema, storage, seeds, cleanup
public/brand/         logo, storefront, mobile hero, window sign
public/products/      accessories / edibles / flower / pre-rolls / vapes
public/banners/       promo art
public/misc-lifestyle/            not attached to SKUs
public/misc-review-screenshots/   not wired into the reviews table
scripts/              image upload helpers
```

---

## Database

### Tables (from `supabase/schema.sql`)

`brands` · `categories` · `products` · `product_variants` · `product_images` · `product_terpenes` · `product_cannabinoids` · `reviews` · `related_products` · `announcements` · `orders` · `order_items` · `admin_profiles`

`contact_messages` is **not** in `schema.sql`. It lives in `supabase/migration-contact-messages.sql` — run that file or the contact form and `/admin/messages` have no table.

### Decisions that are still in force

1. **Brands are rows**, not a text field. `brands.is_house_brand` marks the Ganjavores / Lee Farms line. `products.is_ganjavores_exclusive` is a separate badge flag.
2. **Prices live on `product_variants`**, so an eighth / quarter / half / ounce can each have its own price and inventory.
3. **Terpenes and cannabinoids are tables**, so admin can edit District-style PDP panels as rows.
4. **Reviews default to unapproved.**
5. **Orders have no payment columns.** No Stripe, no card fields, no online capture. Pay cash or card on delivery / pickup.
6. `updated_at` is maintained by a `handle_updated_at()` trigger.

### SQL to run, in order, on a fresh project

1. `supabase/schema.sql` — tables, RLS, category + brand seeds
2. `supabase/storage-setup.sql` — public `product-images` bucket, admin-only writes
3. `supabase/migration-contact-messages.sql`
4. `supabase/seed-products.sql` — optional placeholder catalog
5. `supabase/seed-products-batch2.sql` — optional; real lab data, many prices still marked `EDIT ME`
6. `supabase/seed-products-batch3.sql` — optional; spreadsheet import. Run **after** batch 2 (it UPDATEs rows batch 2 created).
7. `supabase/cleanup-duplicates.sql` — only if an older batch-3 file was already applied; otherwise a no-op
8. `supabase/seed-images-batch1.sql` — optional; attaches images that already live under `public/products/`
9. `supabase/seed-catalog-update.sql` — optional; Sept 2026 CSV pass. Updates ~30 existing products (pricing / THC / genetics / copy) and inserts Cereal Milk, GMO Cookies, Skittlez Edibles, Gorilla Glue GG4, Chemdawg Live Resin.

Search `EDIT ME` in the seed files for rows whose price was inferred, not taken from a sheet.

---

## Business facts (from `lib/business-info.ts`)

Use these and only these in UI copy:

| Role | Number | In this build? |
|---|---|---|
| Corporate / dispatch | **202-709-8944** | Yes — header, footer, checkout, JSON-LD |
| Old Shopify delivery | 202-735-3958 | No |
| Window-sign / vendor | 202-455-0175 | No |
| Co-owner personal (leaked to directories) | 202-300-7559 | **Never** |

Socials wired: X `x.com/ganjavores`, Instagram `instagram.com/ganjavores`. TikTok and Google Business Profile URL are empty. Apple Maps URL is set. License line: “Licensed Medical Cannabis Internet Retailer under DC ABCA.”

Canonical site in metadata is `https://ganjavores.shop`.

---

## Assets on disk

Already in `public/`:

- `brand/logo.png`, `banner-primary.png`, `banner-secondary.jpg`, `hero-mobile.jpg`, `storefront-illustrated.png`, `window-sign.jpg`
- `products/` — 109 files (flower 34, vapes 48, edibles 17, accessories 7, pre-rolls 3)
- `banners/` — grand opening, disposable sale, Khalifa Kush compound, plus older promo art
- `misc-lifestyle/` (7) and `misc-review-screenshots/` (5) — **not** attached to product rows

House-brand jar mockups for Green Crack / Sour Diesel still show **NC** compliance text on the label. Confirm before treating those as live DC packaging photos.

Some promo banners still include Visa / Mastercard / PayPal marks. That contradicts pay-on-arrival. Do not put those on the homepage or deals grid until the payment icons are removed.

---

## SEO / AEO already in the layout

Root layout emits JSON-LD for Organization, LocalBusiness (with geo 38.881836, −76.995344), SoftwareApplication, and FAQPage. Product pages add Product JSON-LD. `next.config.ts` sets HSTS, CSP, X-Frame-Options, Referrer-Policy, Permissions-Policy (`payment=()`), and long-cache headers for `/brand`, `/products`, `/banners`.

---

## Built vs still open

### Done

- Storefront: home, shop, PDP, cart, checkout, confirmation, brands, deals, about, contact, FAQ, pricing
- 21+ age gate that does not auto-dismiss
- Admin CRUD for catalog, orders, announcements, reviews, messages
- Image upload to Supabase Storage
- Resend order ping (needs `RESEND_API_KEY` + a verified sending domain)
- Klaviyo capture UI (needs the two public env vars)
- Maps embed on about + contact
- No-online-payment checkout, end to end

### Not built / still wrong in code

| Item | Status |
|---|---|
| Header logo image | File is in `public/brand/logo.png`; header still uses text |
| Header search | Icon only, no search UI |
| `/shop/ganjavores-exclusive` | Nav points here. **No such route.** Exclusive filter is `/shop?exclusive=true` |
| Admin-editable hours | Comment in `business-info.ts`; hours are still a hardcoded string |
| Google Business Profile footer link | `googleBusinessProfileUrl` is empty |
| Klaviyo keys in `.env.example` | Used in code, missing from the example file |
| Judge.me / Loox | Intentionally skipped — native reviews exist |
| Site-wide testimonials | Review screenshots are on disk; `reviews.product_id` is required, so they are not wired |
| Customer accounts | None. Cart is device-local. |
| Online payments | None, by design |
| Font files | Tailwind `display` / `sans` still point at unset CSS variables |

Winston-Salem / Farm Bill / THCA “non-intoxicating until heated” copy from the old Shopify theme was not carried over. This site is DC medical cannabis, not NC hemp.

---

## Related repo

Dreamz DC Compound is a separate static HTML + Express site: https://github.com/tradersurfer/dreamz-dc. Different address (611 Pennsylvania Ave SE), different age-gate key (`dreamz_age_ok_2026`), no Supabase. Keep the two codebases apart.

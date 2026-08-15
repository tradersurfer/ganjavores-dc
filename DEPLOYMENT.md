# Deploying Ganjavores DC — Step by Step

This assumes you're starting from zero on both Supabase and Vercel. If you already
have accounts, skip to the relevant step. Total time: roughly 45–60 minutes the first
time through.

---

## Before you start — decisions to make

1. **Domain.** `ganjavores.com`'s old Shopify store is confirmed dead — it now
   redirects to a generic Shopify "this website is not available" page. That clears
   the way to point the domain straight at this new build (Step 7, Option A) without
   worrying about taking down anything live.

2. **Google/Apple Maps links.** The share.google links you sent still block automated
   access, so I couldn't resolve them into direct URLs. Two options: open each link on
   your phone and use Share → Copy Link *from within Maps itself* (not the
   share.google redirector) to get the real URL, or just paste the share.google links
   directly into `lib/business-info.ts` — they'll still work as click-through links
   for a human visitor, they just can't be auto-verified by a script. Not blocking
   launch either way.

---

## Step 1 — Create the Supabase project

1. Go to [supabase.com](https://supabase.com) → sign up / log in.
2. **New Project** → name it `ganjavores-dc` → pick a region close to DC
   (`us-east-1` is the closest AWS region Supabase offers) → set a strong database
   password and save it somewhere safe (a password manager, not a text file).
3. Wait ~2 minutes for provisioning.

## Step 2 — Run the database migrations

In the Supabase dashboard: **SQL Editor → New Query**. Run these files from the
`supabase/` folder **in this exact order**, one at a time, waiting for each to finish:

1. `schema.sql` — creates every table, RLS policy, and seeds categories + brands
2. `storage-setup.sql` — creates the `product-images` upload bucket
3. `migration-contact-messages.sql` — creates the contact form table
4. `seed-products.sql` — **optional**, loads the 45 placeholder products with
   draft pricing. Skip this if you'd rather start with an empty catalog and add
   real products through the admin panel from scratch.

Paste each file's full contents into the SQL Editor and click **Run**. If something
errors partway through, re-check you ran them in order — later files reference tables
the earlier ones create.

## Step 3 — Create your admin login

The schema has an `admin_profiles` table that RLS policies check against, but nobody's
in it yet. Two steps:

1. **Authentication → Users → Add User** in the Supabase dashboard. Enter your email
   and a password (or use "Send invite email" if you'd rather set your own password).
   Copy the generated **User UID**.
2. Back in **SQL Editor**, run:
   ```sql
   insert into admin_profiles (id, full_name, role)
   values ('paste-the-user-uid-here', 'Your Name', 'owner');
   ```

Without this second step, you'll be able to log into `/admin/login` but every admin
page will look empty or throw permission errors, since the RLS policies check for a
matching `admin_profiles` row.

## Step 4 — Collect your API keys

**Settings → API** in the Supabase dashboard. You need three values:

| Value | Where to find it | Used for |
|---|---|---|
| Project URL | Top of the API settings page | `NEXT_PUBLIC_SUPABASE_URL` |
| `anon` `public` key | Under "Project API keys" | `NEXT_PUBLIC_SUPABASE_ANON_KEY` |
| `service_role` key | Same section, click "Reveal" | `SUPABASE_SERVICE_ROLE_KEY` |

**The service_role key bypasses every security rule in the database.** Never put it
in a `NEXT_PUBLIC_*` variable, never commit it to git, never share it outside your
hosting provider's environment variable settings.

## Step 5 — Push the code to GitHub

Vercel deploys from a git repo, not a zip file, so:

1. Create a new **private** repo on GitHub (e.g. `ganjavores-dc`).
2. Unzip the project scaffold locally, then from that folder:
   ```bash
   git init
   git add .
   git commit -m "Initial Ganjavores DC build"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/ganjavores-dc.git
   git push -u origin main
   ```
   (The `.gitignore` already excludes `node_modules`, `.env`, and build output.)
3. Install dependencies locally to confirm it builds before deploying:
   ```bash
   npm install
   npm run build
   ```
   Fix any errors here first — it's much faster to debug locally than through
   Vercel's deploy logs.

## Step 6 — Deploy on Vercel

1. Go to [vercel.com](https://vercel.com) → sign up / log in with your GitHub account.
2. **Add New → Project** → import the `ganjavores-dc` repo.
3. Framework preset should auto-detect as **Next.js** — leave build settings default.
4. Before clicking Deploy, expand **Environment Variables** and add:
   ```
   NEXT_PUBLIC_SUPABASE_URL=<from Step 4>
   NEXT_PUBLIC_SUPABASE_ANON_KEY=<from Step 4>
   SUPABASE_SERVICE_ROLE_KEY=<from Step 4>
   RESEND_API_KEY=<your Resend key>
   ```
   Paste the actual Resend key value directly into Vercel's dashboard here — not
   into any file in the repo. Order-notification emails start working the moment
   this is set; leave it out and checkout still works fine, you just won't get
   emailed.
5. Click **Deploy**. First build takes 2–3 minutes.

You'll get a `ganjavores-dc-xyz.vercel.app` URL — click through the whole site on
that URL before touching DNS. Specifically check:
- Homepage loads with images
- `/shop` filters work and products show up (if you ran the seed data)
- A product page loads with variants/images
- Add to cart → checkout → order confirmation completes end to end
- `/admin/login` logs you in and the dashboard shows data

## Step 7 — Point your domain at it

Since the old Shopify store is confirmed dead, **Option A is safe to go straight to** —
but Option B is still there if you'd rather smoke-test on a subdomain first regardless.

**Option A — Point ganjavores.com straight at this build (recommended):**
1. In Vercel: **Project → Settings → Domains** → add `ganjavores.com` and `www.ganjavores.com`
2. Vercel gives you DNS records to add (usually an `A` record for the root domain and
   a `CNAME` for `www`)
3. Go to wherever `ganjavores.com`'s DNS is currently managed (check your domain
   registrar — since Shopify's store is dead, DNS may still be pointed at Shopify's
   servers and needs updating regardless of which option you pick) and add those records
4. DNS changes take anywhere from a few minutes to 48 hours to propagate
5. Since the old store is already down, there's no live traffic to worry about
   disrupting — this is just replacing a dead page with a working one

**Option B — Stand up on a subdomain first:**
1. Same Vercel steps, but add e.g. `new.ganjavores.com` instead
2. Add just a `CNAME` record for that subdomain pointing to Vercel — this doesn't
   touch your existing Shopify store's DNS at all, so both run simultaneously
3. Test thoroughly, then do Option A's steps later when you're ready to cut over

## Step 8 — Post-launch checklist

- [ ] Add real product data through `/admin/products` (or edit the seeded
      placeholders) — every seeded product has an `EDIT ME` comment in
      `seed-products.sql` marking guessed pricing/THC%
- [ ] Add your Google Business Profile and Apple Maps URLs to
      `lib/business-info.ts` once you have the resolved (non-share.google) links
- [ ] Confirm `RESEND_API_KEY` is set in Vercel and send yourself a test order to
      verify the notification email arrives
- [ ] Test the age gate, checkout flow, and admin panel one more time on the real
      domain once DNS has propagated

## If something breaks

- **Blank white screen / 500 error on Vercel**: almost always a missing or
  misspelled environment variable. Double-check all three Supabase values in
  Vercel's project settings.
- **"permission denied" errors in admin pages**: you skipped Step 3 (the
  `admin_profiles` insert), or the UUID you inserted doesn't match your actual
  logged-in user.
- **Images not loading**: if they're hosted on Supabase Storage, check
  `next.config.ts` — the `remotePatterns` hostname needs to match your actual
  project's Supabase URL (currently set to `*.supabase.co`, which should already
  cover this, but double check if you're on a custom Supabase domain).
- **Build fails on Vercel but works locally**: usually a case-sensitivity issue
  (Vercel builds on Linux, your machine might not enforce exact filename casing) —
  check that every import matches the actual file name exactly.

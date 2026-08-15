import { createClient as createSupabaseClient } from "@supabase/supabase-js";

/**
 * Service-role client — bypasses RLS entirely. This must NEVER be
 * imported into a Client Component or anything that ships to the
 * browser; it only belongs in Server Components, Route Handlers, and
 * Server Actions.
 *
 * Why this exists instead of just relaxing RLS on `orders`:
 * customers have no accounts, so there's no `auth.uid()` to scope a
 * SELECT policy to. A public `using (true)` SELECT policy on orders
 * would let anyone with the anon key (which ships in client JS) list
 * every order via the REST API directly — not just fetch the one they
 * just placed. Using the service role key ONLY in trusted server code
 * (order confirmation lookup, admin dashboard) avoids that leak while
 * still letting those specific server-rendered pages read order data.
 *
 * Requires SUPABASE_SERVICE_ROLE_KEY in your env — get it from
 * Supabase Dashboard → Settings → API → service_role key. Set it only
 * in your hosting provider's server environment variables, never in
 * NEXT_PUBLIC_*, never committed to the repo.
 */
export function createServiceClient() {
  return createSupabaseClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false } }
  );
}

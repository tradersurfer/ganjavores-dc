import { createBrowserClient } from "@supabase/ssr";

/**
 * Client-side Supabase client — for use in Client Components
 * (cart interactions, admin forms, image upload widgets, etc).
 */
export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );
}

import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

export const metadata: Metadata = {
  title: "Deals",
  description: "Current deals and drops at Ganjavores DC.",
};

export const dynamic = "force-dynamic";

export default async function DealsPage() {
  const supabase = await createClient();
  const { data: deals } = await supabase
    .from("announcements")
    .select("*")
    .eq("placement", "specials_page")
    .eq("is_active", true)
    .order("display_order");

  return (
    <div className="max-w-4xl mx-auto px-4 md:px-6 py-10">
      <h1 className="gv-section-heading mb-2">Current Deals &amp; Drops</h1>
      <p className="text-soft mb-8">
        Deals rotate regularly — check back often, or ask about text/email alerts next
        time you order.
      </p>

      <div className="space-y-4">
        {(deals ?? []).map((deal) => (
          <Link
            key={deal.id}
            href={deal.link_url ?? "/shop"}
            className="relative block h-40 rounded-card overflow-hidden group"
          >
            {deal.image_url && (
              <Image
                src={deal.image_url}
                alt={deal.title}
                fill
                className="object-cover transition-transform duration-500 group-hover:scale-105"
              />
            )}
            <div className="absolute inset-0 bg-gradient-to-r from-midnight/90 to-transparent" />
            <div className="relative h-full flex flex-col justify-center px-6">
              <h2 className="font-display text-xl text-white">{deal.title}</h2>
              {deal.subtitle && <p className="text-soft text-sm mt-1">{deal.subtitle}</p>}
            </div>
          </Link>
        ))}

        {(deals ?? []).length === 0 && (
          <p className="text-soft text-sm">Nothing live right now — check back soon.</p>
        )}
      </div>
    </div>
  );
}

import type { Metadata } from "next";
import { createClient } from "@/lib/supabase/server";
import { getAllCategories } from "@/lib/supabase/queries";
import { Hero } from "@/components/home/hero";
import { SecondaryBanner } from "@/components/home/secondary-banner";
import { TrustBar } from "@/components/home/trust-bar";
import { CategoryGrid } from "@/components/home/category-grid";
import { DeliveryProcess } from "@/components/home/delivery-process";
import { ProductCard } from "@/components/product-card";
import { KlaviyoSignup } from "@/components/klaviyo-signup";
import { FAQSection, generateFAQJsonLd } from "@/components/home/faq-section";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Ganjavores DC | Premium Medical Cannabis Delivery in Washington, DC",
  description:
    "Licensed medical cannabis delivery in Washington DC. Premium flower, vapes, edibles & Ganjavores Exclusive. Fast, discreet delivery or curbside pickup. Pay on arrival. 202-709-8944.",
  openGraph: {
    title: "Ganjavores DC | Premium Medical Cannabis Delivery in Washington, DC",
    description:
      "Licensed medical cannabis delivery in Washington DC. Premium flower, vapes, edibles & Ganjavores Exclusive. Fast, discreet delivery or curbside pickup. Pay on arrival. 202-709-8944.",
    url: "https://ganjavores.shop",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
    images: [
      {
        url: "https://ganjavores.shop/api/og",
        width: 1200,
        height: 630,
        alt: "Ganjavores DC — Premium Medical Cannabis Delivery",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Ganjavores DC | Premium Medical Cannabis Delivery in Washington, DC",
    images: ["/api/og"],
  },
};

export const dynamic = "force-dynamic";

export default async function HomePage() {
  const supabase = await createClient();

  const [{ data: heroAnnouncement }, { data: secondaryAnnouncement }, { data: featured }, categories] =
    await Promise.all([
      supabase
        .from("announcements")
        .select("title, subtitle, image_url, mobile_image_url, link_url")
        .eq("placement", "homepage_hero")
        .eq("is_active", true)
        .order("display_order")
        .limit(1)
        .maybeSingle(),
      supabase
        .from("announcements")
        .select("title, subtitle, image_url, link_url")
        .eq("placement", "homepage_secondary")
        .eq("is_active", true)
        .order("display_order")
        .limit(1)
        .maybeSingle(),
      supabase
        .from("products")
        .select(
          `id, slug, name, strain_type, thc_percent, is_ganjavores_exclusive,
           brand:brands(name), images:product_images(id, url, alt_text, display_order),
           variants:product_variants(id, label, price, compare_at_price, is_default, inventory_count, display_order)`
        )
        .eq("is_active", true)
        .eq("is_featured", true)
        .limit(8),
      getAllCategories(),
    ]);

  return (
    <>
      <Hero announcement={heroAnnouncement} />
      <TrustBar />
      <SecondaryBanner announcement={secondaryAnnouncement} />

      <section className="max-w-6xl mx-auto px-4 md:px-6 py-12">
        <div className="flex items-center justify-between mb-6">
          <h2 className="gv-section-heading">Featured Products</h2>
          <Link href="/shop" className="text-emerald text-sm hover:text-neon">
            Shop All &rarr;
          </Link>
        </div>
        {featured && featured.length > 0 ? (
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {featured.map((p: any) => (
              <ProductCard
                key={p.id}
                product={{
                  ...p,
                  images: [...(p.images ?? [])].sort(
                    (a: any, b: any) => a.display_order - b.display_order
                  ),
                  variants: [...(p.variants ?? [])].sort(
                    (a: any, b: any) => a.display_order - b.display_order
                  ),
                }}
              />
            ))}
          </div>
        ) : (
          <p className="text-soft text-sm">
            No featured products marked yet — flag them in the admin panel to have them
            show up here.
          </p>
        )}
      </section>

      <CategoryGrid categories={categories} />

      <section className="max-w-2xl mx-auto px-4 md:px-6 py-12 text-center">
        <h2 className="gv-section-heading mb-2">Never Miss a Drop</h2>
        <p className="text-soft mb-6">
          First to know about new deals, restocks, and Ganjavores Exclusive releases.
        </p>
        <div className="flex justify-center">
          <KlaviyoSignup className="max-w-sm w-full" />
        </div>
      </section>

      <DeliveryProcess />

      {/* FAQ section — adds substantive FAQ content for AI crawlers (text-to-HTML ratio fix) */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify(generateFAQJsonLd()),
        }}
      />

      <FAQSection />
    </>
  );
}

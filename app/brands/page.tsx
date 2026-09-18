import type { Metadata } from "next";
import Link from "next/link";
import { getAllBrands } from "@/lib/supabase/queries";

export const metadata: Metadata = {
  title: "Brands We Carry",
  description:
    "Every brand available at Ganjavores DC — including our own house line, Ganjavores by Lee Farms.",
  openGraph: {
    title: "Brands We Carry — Ganjavores DC",
    description:
      "View every brand available at Ganjavores DC, including our house line Ganjavores Exclusive.",
    url: "https://ganjavores.shop/brands",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
    images: [
      {
        url: "https://ganjavores.shop/api/og?title=Brands%20We%20Carry",
        width: 1200,
        height: 630,
        alt: "Ganjavores DC — Brands We Carry",
      },
    ],
  },
};

export const dynamic = "force-dynamic";

export default async function BrandsPage() {
  const brands = await getAllBrands();

  return (
    <div className="max-w-4xl mx-auto px-4 md:px-6 py-10">
      <h1 className="gv-section-heading mb-2">Brands We Carry</h1>
      <p className="text-soft mb-8">
        From our own house line to the DMV&rsquo;s best-known names — here&rsquo;s
        everything on the shelf.
      </p>

      <div className="grid md:grid-cols-2 gap-4">
        {brands.map((brand) => (
          <Link
            key={brand.id}
            href={`/shop?brand=${brand.slug}`}
            className="gv-card flex items-center justify-between hover:border-emerald transition-colors"
          >
            <span className="text-white font-medium">{brand.name}</span>
            {brand.is_house_brand && <span className="gv-badge-exclusive">House Brand</span>}
          </Link>
        ))}
      </div>

      {/* BreadcrumbList JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: [
              { "@type": "ListItem", position: 1, name: "Home", item: "https://ganjavores.shop/" },
              { "@type": "ListItem", position: 2, name: "Brands We Carry", item: "https://ganjavores.shop/brands" },
            ],
          }),
        }}
      />
    </div>
  );
}

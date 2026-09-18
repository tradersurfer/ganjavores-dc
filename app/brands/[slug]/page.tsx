import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getShopProducts, getAllBrands } from "@/lib/supabase/queries";
import { ProductCard } from "@/components/product-card";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const supabase = await createClient();
  const { data: brand } = await supabase
    .from("brands")
    .select("name, description, slug")
    .eq("slug", slug)
    .single();

  if (!brand) return {};

  return {
    title: `${brand.name} | Ganjavores DC`,
    description:
      brand.description ??
      `Shop ${brand.name} products at Ganjavores DC — licensed medical cannabis delivery in Washington, DC.`,
    openGraph: {
      title: `${brand.name} | Ganjavores DC`,
      description:
        brand.description ??
        `Shop ${brand.name} products at Ganjavores DC.`,
      url: `https://ganjavores.shop/brands/${brand.slug}`,
      siteName: "Ganjavores DC",
      locale: "en_US",
      type: "website",
      images: [
        {
          url: `https://ganjavores.shop/api/og?title=${encodeURIComponent(brand.name)}`,
          width: 1200,
          height: 630,
          alt: `${brand.name} at Ganjavores DC`,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: `${brand.name} | Ganjavores DC`,
      images: [`https://ganjavores.shop/api/og?title=${encodeURIComponent(brand.name)}`],
    },
  };
}

export default async function BrandPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();
  const { data: brand } = await supabase
    .from("brands")
    .select("*")
    .eq("slug", slug)
    .single();

  if (!brand) notFound();

  const { products } = await getShopProducts({ brand: slug, perPage: 48 });

  return (
    <div className="max-w-6xl mx-auto px-4 md:px-6 py-10">
      <div className="flex items-center gap-3 mb-2">
        <h1 className="gv-section-heading">{brand.name}</h1>
        {brand.is_house_brand && <span className="gv-badge-exclusive">House Brand</span>}
      </div>
      {brand.description && <p className="text-soft mb-8 max-w-2xl">{brand.description}</p>}

      {products.length === 0 ? (
        <p className="text-soft text-sm">No active products from this brand right now.</p>
      ) : (
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {products.map((p) => (
            <ProductCard key={p.id} product={p} />
          ))}
        </div>
      )}

      {/* BreadcrumbList JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: [
              { "@type": "ListItem", position: 1, name: "Home", item: "https://ganjavores.shop/" },
              { "@type": "ListItem", position: 2, name: "Brands", item: "https://ganjavores.shop/brands" },
              { "@type": "ListItem", position: 3, name: brand.name, item: `https://ganjavores.shop/brands/${brand.slug}` },
            ],
          }),
        }}
      />

      {/* Brand JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "Brand",
            name: brand.name,
            url: `https://ganjavores.shop/brands/${brand.slug}`,
            description: brand.description,
          }),
        }}
      />
    </div>
  );
}

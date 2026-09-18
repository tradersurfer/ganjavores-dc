import type { Metadata } from "next";
import { notFound } from "next/navigation";
import Link from "next/link";
import { getProductBySlug } from "@/lib/supabase/queries";
import { ProductGallery } from "@/components/product/product-gallery";
import { AddToCartPanel } from "@/components/product/add-to-cart-panel";
import { DescriptionToggle } from "@/components/product/description-toggle";
import { CollapsibleSection } from "@/components/product/collapsible-section";
import { ReviewsPanel } from "@/components/product/reviews-panel";
import { ProductCard } from "@/components/product-card";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const product = await getProductBySlug(slug);
  if (!product) return {};

  return {
    title: product.meta_title ?? product.name,
    description: product.meta_description ?? product.short_description ?? undefined,
    openGraph: {
      title: product.name,
      description: product.short_description ?? undefined,
      images: product.images[0]
        ? [product.images[0].url]
        : [
            {
              url: "/api/og?title=" + encodeURIComponent(product.name),
              width: 1200,
              height: 630,
              alt: product.name,
            },
          ],
    },
    twitter: {
      card: "summary_large_image",
      title: product.name,
      images: product.images[0]
        ? [product.images[0].url]
        : ["/api/og?title=" + encodeURIComponent(product.name)],
    },
  };
}

export default async function ProductPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const product = await getProductBySlug(slug);

  if (!product) notFound();

  // JSON-LD structured data for SEO — Product schema per the build spec
  // Enhanced with sku, category, url, and per-offer details
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.name,
    description: product.short_description ?? product.description,
    image: product.images.map((i) => i.url),
    brand: product.brand ? { "@type": "Brand", name: product.brand.name } : undefined,
    category: product.category?.name,
    sku: product.id,
    url: `https://ganjavores.shop/product/${product.slug}`,
    offers: product.variants.map((v) => ({
      "@type": "Offer",
      name: v.label,
      price: v.price,
      priceCurrency: "USD",
      availability:
        v.inventory_count > 0
          ? "https://schema.org/InStock"
          : "https://schema.org/OutOfStock",
      url: `https://ganjavores.shop/product/${product.slug}#variant-${v.id}`,
      priceValidUntil: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
        .toISOString()
        .split("T")[0],
    })),
  };

  const breadcrumbJsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      {
        "@type": "ListItem",
        position: 1,
        name: "Home",
        item: "https://ganjavores.shop/",
      },
      {
        "@type": "ListItem",
        position: 2,
        name: "Shop",
        item: "https://ganjavores.shop/shop",
      },
      ...(product.category
        ? [
            {
              "@type": "ListItem",
              position: 3,
              name: product.category.name,
              item: `https://ganjavores.shop/shop?category=${product.category.slug}`,
            },
          ]
        : []),
      {
        "@type": "ListItem",
        position: product.category ? 4 : 3,
        name: product.name,
        item: `https://ganjavores.shop/product/${product.slug}`,
      },
    ],
  };

  return (
    <div className="max-w-6xl mx-auto px-4 md:px-6 py-10">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify(breadcrumbJsonLd),
        }}
      />

      <nav className="text-sm text-soft mb-6 flex gap-2">
        <Link href="/shop" className="hover:text-emerald">Shop</Link>
        <span>/</span>
        {product.category && (
          <>
            <Link href={`/shop?category=${product.category.slug}`} className="hover:text-emerald">
              {product.category.name}
            </Link>
            <span>/</span>
          </>
        )}
        <span className="text-white">{product.name}</span>
      </nav>

      <div className="grid md:grid-cols-2 gap-10">
        <ProductGallery images={product.images} productName={product.name} />

        <div>
          {product.brand && (
            <Link
              href={`/brands/${product.brand.slug}`}
              className="text-emerald text-sm uppercase tracking-wide hover:text-neon"
            >
              {product.brand.name}
            </Link>
          )}
          <h1 className="font-display text-3xl md:text-4xl text-white mt-1">
            {product.name}
          </h1>

          <div className="flex items-center gap-3 mt-2 flex-wrap">
            {product.strain_type && (
              <span className="text-soft text-sm border border-border rounded-full px-3 py-1">
                {product.strain_type}
              </span>
            )}
            {product.is_ganjavores_exclusive && (
              <span className="gv-badge-exclusive">Ganjavores Exclusive</span>
            )}
            {product.is_lab_tested && (
              <span className="text-soft text-sm border border-border rounded-full px-3 py-1">
                Lab Tested
              </span>
            )}
          </div>

          <div className="mt-6">
            <AddToCartPanel product={product} />
          </div>

          <div className="mt-8">
            <DescriptionToggle description={product.description} />
          </div>

          {(product.cross_genetics || product.palate) && (
            <div className="mt-4 space-y-2 text-sm">
              {product.cross_genetics && (
                <div className="flex gap-2">
                  <span className="text-white font-semibold uppercase">Cross:</span>
                  <span className="text-soft">{product.cross_genetics}</span>
                </div>
              )}
              {product.palate && (
                <div className="flex gap-2">
                  <span className="text-white font-semibold uppercase">Palate:</span>
                  <span className="text-soft">{product.palate}</span>
                </div>
              )}
            </div>
          )}

          {/* Collapsible District-depth panels */}
          {product.terpenes.length > 0 && (
            <CollapsibleSection title="Terpenes">
              <p className="text-soft text-sm mb-4">
                Terpenes are aromatic compounds in cannabis responsible for its unique
                flavors and scents, while also influencing its effects.
              </p>
              <div className="grid grid-cols-2 gap-4">
                {product.terpenes.map((t) => (
                  <div key={t.id} className="flex justify-between border-b border-border/50 pb-2">
                    <span className="text-white text-sm">{t.name}</span>
                    <span className="text-soft text-sm">{t.percent}%</span>
                  </div>
                ))}
              </div>
            </CollapsibleSection>
          )}

          {product.cannabinoids.length > 0 && (
            <CollapsibleSection title="Cannabinoids">
              <p className="text-soft text-sm mb-4">
                Cannabinoids are natural compounds in cannabis that engage with the
                body&rsquo;s endocannabinoid system to produce a range of effects.
              </p>
              <div className="grid grid-cols-2 gap-4">
                {product.cannabinoids.map((c) => (
                  <div key={c.id} className="flex justify-between border-b border-border/50 pb-2">
                    <span className="text-white text-sm">{c.name}</span>
                    <span className="text-soft text-sm">{c.percent}%</span>
                  </div>
                ))}
              </div>
            </CollapsibleSection>
          )}

          <CollapsibleSection title="Reviews" defaultOpen={product.reviews.length > 0}>
            <ReviewsPanel productId={product.id} reviews={product.reviews} />
          </CollapsibleSection>

          {product.brand && product.brand.description && (
            <CollapsibleSection title="About the Brand">
              <p className="text-white font-semibold mb-1">{product.brand.name}</p>
              <p className="text-soft text-sm">{product.brand.description}</p>
            </CollapsibleSection>
          )}
        </div>
      </div>

      {product.related_products && product.related_products.length > 0 && (
        <div className="mt-16">
          <h2 className="gv-section-heading mb-6">Related Products</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {product.related_products.slice(0, 4).map((related) => (
              <ProductCard key={related.id} product={related} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

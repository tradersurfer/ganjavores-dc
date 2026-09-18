import type { Metadata } from "next";
import { getShopProducts, getAllBrands, getAllCategories, getPriceBounds } from "@/lib/supabase/queries";
import { ShopFilters } from "@/components/shop/shop-filters";
import { ProductCard } from "@/components/product-card";
import { ShopSearchBar } from "@/components/shop/shop-search-bar";
import { ShopPagination } from "@/components/shop/shop-pagination";

export const metadata: Metadata = {
  title: "Shop All Products",
  description:
    "Browse Ganjavores DC's full catalog — premium flower, vapes, edibles, pre-rolls, concentrates, and our house line Ganjavores Exclusive. Filter by category, brand, strain, price, and THC%.",
  openGraph: {
    title: "Shop All Products — Ganjavores DC",
    description:
      "Full menu of premium flower, vapes, edibles, pre-rolls, and concentrates.",
    url: "https://ganjavores.shop/shop",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
    images: [
      {
        url: "https://ganjavores.shop/api/og?title=Shop%20All%20Products",
        width: 1200,
        height: 630,
        alt: "Ganjavores DC — Shop All Products",
      },
    ],
  },
};

// Re-fetch on every request rather than caching a stale catalog —
// inventory/pricing changes from the admin panel should show immediately.
export const dynamic = "force-dynamic";

type SearchParams = {
  category?: string;
  brand?: string;
  strain?: string;
  exclusive?: string;
  minPrice?: string;
  maxPrice?: string;
  minThc?: string;
  q?: string;
  sort?: string;
  page?: string;
};

export default async function ShopPage({
  searchParams,
}: {
  searchParams: Promise<SearchParams>;
}) {
  const params = await searchParams;

  const [{ products, total, page, perPage }, categories, brands, priceBounds] =
    await Promise.all([
      getShopProducts({
        category: params.category,
        brand: params.brand,
        strainType: params.strain,
        exclusiveOnly: params.exclusive === "true",
        minPrice: params.minPrice ? Number(params.minPrice) : undefined,
        maxPrice: params.maxPrice ? Number(params.maxPrice) : undefined,
        minThc: params.minThc ? Number(params.minThc) : undefined,
        search: params.q,
        sort: (params.sort as any) ?? "featured",
        page: params.page ? Number(params.page) : 1,
      }),
      getAllCategories(),
      getAllBrands(),
      getPriceBounds(),
    ]);

  const activeCategory = categories.find((c) => c.slug === params.category);
  const totalPages = Math.max(1, Math.ceil(total / perPage));

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-6 py-10">
      <div className="mb-8">
        <h1 className="gv-section-heading">
          {activeCategory ? activeCategory.name : "Shop All"}
        </h1>
        <p className="text-soft mt-2 max-w-2xl">
          {activeCategory?.description ??
            "Every product we carry, all in one place — house-grown Ganjavores Exclusive flower alongside the DMV's best brands. Filter it down to exactly what you're after."}
        </p>
      </div>

      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: [
              { "@type": "ListItem", position: 1, name: "Home", item: "https://ganjavores.shop/" },
              { "@type": "ListItem", position: 2, name: "Shop All Products", item: "https://ganjavores.shop/shop" },
            ],
          }),
        }}
      />

      <ShopSearchBar />

      <div className="flex flex-col lg:flex-row gap-8 mt-6">
        <ShopFilters categories={categories} brands={brands} priceBounds={priceBounds} />

        <div className="flex-1">
          <div className="flex items-center justify-between mb-4">
            <p className="text-soft text-sm">{total} products</p>
          </div>

          {products.length === 0 ? (
            <div className="gv-card text-center py-16">
              <p className="text-white text-lg mb-2">Nothing matches those filters.</p>
              <p className="text-soft text-sm">
                Try widening your price range or clearing a filter or two.
              </p>
            </div>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-4">
              {products.map((product) => (
                <ProductCard key={product.id} product={product} />
              ))}
            </div>
          )}

          <ShopPagination currentPage={page} totalPages={totalPages} />
        </div>
      </div>
    </div>
  );
}

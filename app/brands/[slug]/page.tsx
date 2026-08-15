import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { getShopProducts } from "@/lib/supabase/queries";
import { ProductCard } from "@/components/product-card";

export const dynamic = "force-dynamic";

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
    </div>
  );
}

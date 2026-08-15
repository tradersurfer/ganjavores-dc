import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { ProductFormFields } from "@/components/admin/product-form-fields";
import { ProductEditForm } from "@/components/admin/product-edit-form";
import { VariantManager } from "@/components/admin/variant-manager";
import { ImageManager } from "@/components/admin/image-manager";
import { PotencyManager } from "@/components/admin/potency-manager";

export const dynamic = "force-dynamic";

export default async function EditProductPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createClient();

  const [{ data: product }, { data: brands }, { data: categories }] = await Promise.all([
    supabase
      .from("products")
      .select(
        `*, variants:product_variants(*), images:product_images(*),
         terpenes:product_terpenes(*), cannabinoids:product_cannabinoids(*)`
      )
      .eq("id", id)
      .single(),
    supabase.from("brands").select("*").order("name"),
    supabase.from("categories").select("*").order("display_order"),
  ]);

  if (!product) notFound();

  const sortedVariants = [...(product.variants ?? [])].sort(
    (a, b) => a.display_order - b.display_order
  );
  const sortedImages = [...(product.images ?? [])].sort(
    (a, b) => a.display_order - b.display_order
  );

  return (
    <div className="max-w-2xl space-y-10">
      <h1 className="gv-section-heading">{product.name}</h1>

      <ProductEditForm productId={product.id}>
        <ProductFormFields brands={brands ?? []} categories={categories ?? []} defaults={product} />
      </ProductEditForm>

      <section>
        <h2 className="text-white font-display text-xl mb-4">Variants &amp; Pricing</h2>
        <VariantManager productId={product.id} variants={sortedVariants} />
      </section>

      <section>
        <h2 className="text-white font-display text-xl mb-4">Images</h2>
        <ImageManager productId={product.id} images={sortedImages} />
      </section>

      <section>
        <h2 className="text-white font-display text-xl mb-4">Terpenes</h2>
        <PotencyManager productId={product.id} kind="terpene" rows={product.terpenes ?? []} />
      </section>

      <section>
        <h2 className="text-white font-display text-xl mb-4">Cannabinoids</h2>
        <PotencyManager productId={product.id} kind="cannabinoid" rows={product.cannabinoids ?? []} />
      </section>
    </div>
  );
}

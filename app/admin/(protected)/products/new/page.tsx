import { createClient } from "@/lib/supabase/server";
import { NewProductForm } from "@/components/admin/new-product-form";

export default async function NewProductPage() {
  const supabase = await createClient();
  const [{ data: brands }, { data: categories }] = await Promise.all([
    supabase.from("brands").select("*").order("name"),
    supabase.from("categories").select("*").order("display_order"),
  ]);

  return (
    <div className="max-w-2xl">
      <h1 className="gv-section-heading mb-8">New Product</h1>
      <NewProductForm brands={brands ?? []} categories={categories ?? []} />
    </div>
  );
}

import { createClient } from "@/lib/supabase/server";
import { BrandRow, NewBrandForm } from "@/components/admin/brand-row";

export const dynamic = "force-dynamic";

export default async function AdminBrandsPage() {
  const supabase = await createClient();
  const { data: brands } = await supabase.from("brands").select("*").order("name");

  return (
    <div className="max-w-2xl">
      <h1 className="gv-section-heading mb-2">Brands</h1>
      <p className="text-soft mb-8">
        Every brand a product can be assigned to — your house line plus every
        manufacturer or supplier on the shelf. This is what shows in each product's
        "About the Brand" section and on the public{" "}
        <a href="/brands" className="text-emerald hover:text-neon">
          /brands
        </a>{" "}
        directory.
      </p>

      <div className="space-y-3 mb-10">
        {(brands ?? []).map((b) => (
          <BrandRow key={b.id} brand={b} />
        ))}
      </div>

      <div className="gv-card">
        <h2 className="text-white font-display text-lg mb-4">New Brand</h2>
        <NewBrandForm />
      </div>
    </div>
  );
}

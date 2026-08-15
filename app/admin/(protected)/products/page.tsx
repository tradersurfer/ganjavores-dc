import Link from "next/link";
import Image from "next/image";
import { createClient } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";

export default async function AdminProductsPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const supabase = await createClient();

  let query = supabase
    .from("products")
    .select(
      `id, name, slug, is_active, is_featured, is_ganjavores_exclusive, thc_percent,
       brand:brands(name), category:categories(name),
       images:product_images(url, display_order),
       variants:product_variants(price, inventory_count)`
    )
    .order("name");

  if (q) query = query.ilike("name", `%${q}%`);

  const { data: products } = await query;

  return (
    <div>
      <div className="flex items-center justify-between mb-8">
        <h1 className="gv-section-heading">Products</h1>
        <Link href="/admin/products/new" className="gv-btn-primary">
          + New Product
        </Link>
      </div>

      <form className="mb-6 max-w-md">
        <input
          type="text"
          name="q"
          defaultValue={q}
          placeholder="Search products..."
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
      </form>

      <div className="gv-card overflow-x-auto">
        <table className="w-full text-sm">
          <thead>
            <tr className="text-soft text-left border-b border-border">
              <th className="pb-3 pr-4">Product</th>
              <th className="pb-3 pr-4">Brand</th>
              <th className="pb-3 pr-4">Category</th>
              <th className="pb-3 pr-4">Price</th>
              <th className="pb-3 pr-4">Stock</th>
              <th className="pb-3 pr-4">Status</th>
              <th className="pb-3"></th>
            </tr>
          </thead>
          <tbody>
            {(products ?? []).map((p: any) => {
              const img = [...(p.images ?? [])].sort((a: any, b: any) => a.display_order - b.display_order)[0];
              const minPrice = p.variants?.length
                ? Math.min(...p.variants.map((v: any) => v.price))
                : null;
              const totalStock = (p.variants ?? []).reduce(
                (sum: number, v: any) => sum + v.inventory_count,
                0
              );
              return (
                <tr key={p.id} className="border-b border-border/50 last:border-0">
                  <td className="py-3 pr-4">
                    <div className="flex items-center gap-3">
                      <div className="relative w-10 h-10 rounded bg-[#0d110d] overflow-hidden shrink-0">
                        {img && <Image src={img.url} alt={p.name} fill className="object-cover" />}
                      </div>
                      <div>
                        <Link href={`/admin/products/${p.id}`} className="text-white hover:text-emerald">
                          {p.name}
                        </Link>
                        {p.is_ganjavores_exclusive && (
                          <span className="ml-2 gv-badge-exclusive text-[10px]">GV</span>
                        )}
                      </div>
                    </div>
                  </td>
                  <td className="py-3 pr-4 text-soft">{p.brand?.name ?? "—"}</td>
                  <td className="py-3 pr-4 text-soft">{p.category?.name ?? "—"}</td>
                  <td className="py-3 pr-4 text-emerald">
                    {minPrice !== null ? `$${minPrice.toFixed(2)}` : "—"}
                  </td>
                  <td className="py-3 pr-4">
                    <span className={totalStock <= 5 ? "text-highlight" : "text-soft"}>
                      {totalStock}
                    </span>
                  </td>
                  <td className="py-3 pr-4">
                    <span className={p.is_active ? "text-emerald" : "text-soft/50"}>
                      {p.is_active ? "Active" : "Hidden"}
                    </span>
                  </td>
                  <td className="py-3 text-right">
                    <Link href={`/admin/products/${p.id}`} className="text-emerald text-sm hover:text-neon">
                      Edit
                    </Link>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
        {(products ?? []).length === 0 && (
          <p className="text-soft text-sm py-8 text-center">No products found.</p>
        )}
      </div>
    </div>
  );
}

import { createClient } from "@/lib/supabase/server";
import { createCategory } from "@/app/actions/admin-categories";
import { CategoryRow } from "@/components/admin/category-row";

export const dynamic = "force-dynamic";

export default async function AdminCategoriesPage() {
  const supabase = await createClient();
  const { data: categories } = await supabase
    .from("categories")
    .select("*")
    .order("display_order");

  return (
    <div className="max-w-2xl">
      <h1 className="gv-section-heading mb-2">Categories</h1>
      <p className="text-soft mb-8">
        These drive the shop filter sidebar and the homepage category grid. Sort order
        controls the order they appear everywhere on the site.
      </p>

      <div className="space-y-3 mb-10">
        {(categories ?? []).map((c) => (
          <CategoryRow key={c.id} category={c} />
        ))}
      </div>

      <div className="gv-card">
        <h2 className="text-white font-display text-lg mb-4">New Category</h2>
        <form action={createCategory} className="space-y-3">
          <input
            name="name"
            required
            placeholder="Category name"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <textarea
            name="description"
            placeholder="Intro copy for the shop page (optional)"
            rows={2}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <button type="submit" className="gv-btn-primary">
            Add Category
          </button>
        </form>
      </div>
    </div>
  );
}

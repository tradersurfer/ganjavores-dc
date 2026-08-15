import type { Brand, Category } from "@/lib/types";

export function ProductFormFields({
  brands,
  categories,
  defaults,
}: {
  brands: Brand[];
  categories: Category[];
  defaults?: any;
}) {
  return (
    <div className="space-y-4">
      <div>
        <label className="text-soft text-sm block mb-1">Product Name</label>
        <input
          name="name"
          required
          defaultValue={defaults?.name}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
        />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="text-soft text-sm block mb-1">Brand</label>
          <select
            name="brand_id"
            defaultValue={defaults?.brand_id ?? ""}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          >
            <option value="">— none —</option>
            {brands.map((b) => (
              <option key={b.id} value={b.id}>
                {b.name}
                {b.is_house_brand ? " (house)" : ""}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label className="text-soft text-sm block mb-1">Category</label>
          <select
            name="category_id"
            defaultValue={defaults?.category_id ?? ""}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          >
            <option value="">— none —</option>
            {categories.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </div>
      </div>

      <div className="grid grid-cols-3 gap-4">
        <div>
          <label className="text-soft text-sm block mb-1">Strain Type</label>
          <select
            name="strain_type"
            defaultValue={defaults?.strain_type ?? ""}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          >
            <option value="">— n/a —</option>
            {["Indica", "Sativa", "Hybrid", "Indica Hybrid", "Sativa Hybrid"].map((s) => (
              <option key={s} value={s}>{s}</option>
            ))}
          </select>
        </div>
        <div>
          <label className="text-soft text-sm block mb-1">THC %</label>
          <input
            name="thc_percent"
            type="number"
            step="0.01"
            defaultValue={defaults?.thc_percent ?? ""}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </div>
        <div>
          <label className="text-soft text-sm block mb-1">CBD %</label>
          <input
            name="cbd_percent"
            type="number"
            step="0.01"
            defaultValue={defaults?.cbd_percent ?? ""}
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="text-soft text-sm block mb-1">Cross / Genetics</label>
          <input
            name="cross_genetics"
            defaultValue={defaults?.cross_genetics ?? ""}
            placeholder="e.g. Wedding Cake x Gelato 33"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </div>
        <div>
          <label className="text-soft text-sm block mb-1">Palate</label>
          <input
            name="palate"
            defaultValue={defaults?.palate ?? ""}
            placeholder="e.g. grapes, sweet kerosene, cognac"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </div>
      </div>

      <div>
        <label className="text-soft text-sm block mb-1">Short Description (card + SEO)</label>
        <input
          name="short_description"
          defaultValue={defaults?.short_description ?? ""}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
        />
      </div>

      <div>
        <label className="text-soft text-sm block mb-1">Full Description</label>
        <textarea
          name="description"
          required
          rows={5}
          defaultValue={defaults?.description ?? ""}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
        />
      </div>

      <div className="flex gap-6">
        <label className="flex items-center gap-2 text-white text-sm cursor-pointer">
          <input
            type="checkbox"
            name="is_ganjavores_exclusive"
            defaultChecked={defaults?.is_ganjavores_exclusive}
            className="accent-highlight"
          />
          Ganjavores Exclusive
        </label>
        <label className="flex items-center gap-2 text-white text-sm cursor-pointer">
          <input
            type="checkbox"
            name="is_featured"
            defaultChecked={defaults?.is_featured}
            className="accent-emerald"
          />
          Featured
        </label>
        <label className="flex items-center gap-2 text-white text-sm cursor-pointer">
          <input
            type="checkbox"
            name="is_active"
            defaultChecked={defaults?.is_active ?? true}
            className="accent-emerald"
          />
          Active (visible on site)
        </label>
      </div>
    </div>
  );
}

"use client";

import { useRouter, useSearchParams, usePathname } from "next/navigation";
import { useState, useCallback } from "react";
import { X } from "lucide-react";
import type { Brand, Category } from "@/lib/types";

const STRAIN_TYPES = ["Indica", "Sativa", "Hybrid", "Indica Hybrid", "Sativa Hybrid"];

const SORT_OPTIONS = [
  { value: "featured", label: "Featured" },
  { value: "price-asc", label: "Price: Low to High" },
  { value: "price-desc", label: "Price: High to Low" },
  { value: "thc-desc", label: "THC: High to Low" },
  { value: "newest", label: "Newest" },
];

export function ShopFilters({
  categories,
  brands,
  priceBounds,
}: {
  categories: Category[];
  brands: Brand[];
  priceBounds: { min: number; max: number };
}) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [mobileOpen, setMobileOpen] = useState(false);

  const set = useCallback(
    (key: string, value: string | null) => {
      const params = new URLSearchParams(searchParams.toString());
      if (value === null || value === "") {
        params.delete(key);
      } else {
        params.set(key, value);
      }
      params.delete("page"); // reset pagination whenever a filter changes
      router.push(`${pathname}?${params.toString()}`);
    },
    [pathname, router, searchParams]
  );

  const toggle = (key: string, value: string) => {
    set(key, searchParams.get(key) === value ? null : value);
  };

  const activeCount = ["category", "brand", "strain", "exclusive", "minPrice", "maxPrice", "minThc"]
    .filter((k) => searchParams.get(k))
    .length;

  const content = (
    <div className="space-y-8">
      <div>
        <h3 className="text-white font-semibold mb-3">Sort By</h3>
        <select
          value={searchParams.get("sort") ?? "featured"}
          onChange={(e) => set("sort", e.target.value)}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        >
          {SORT_OPTIONS.map((opt) => (
            <option key={opt.value} value={opt.value}>
              {opt.label}
            </option>
          ))}
        </select>
      </div>

      <div>
        <h3 className="text-white font-semibold mb-3">Category</h3>
        <div className="space-y-2">
          {categories.map((cat) => (
            <label key={cat.id} className="flex items-center gap-2 text-sm text-soft cursor-pointer">
              <input
                type="checkbox"
                checked={searchParams.get("category") === cat.slug}
                onChange={() => toggle("category", cat.slug)}
                className="accent-emerald"
              />
              {cat.name}
            </label>
          ))}
        </div>
      </div>

      <div>
        <h3 className="text-white font-semibold mb-3">Strain Type</h3>
        <div className="space-y-2">
          {STRAIN_TYPES.map((type) => (
            <label key={type} className="flex items-center gap-2 text-sm text-soft cursor-pointer">
              <input
                type="checkbox"
                checked={searchParams.get("strain") === type}
                onChange={() => toggle("strain", type)}
                className="accent-emerald"
              />
              {type}
            </label>
          ))}
        </div>
      </div>

      <div>
        <h3 className="text-white font-semibold mb-3">Brand</h3>
        <div className="space-y-2 max-h-48 overflow-y-auto pr-2">
          {brands.map((brand) => (
            <label key={brand.id} className="flex items-center gap-2 text-sm text-soft cursor-pointer">
              <input
                type="checkbox"
                checked={searchParams.get("brand") === brand.slug}
                onChange={() => toggle("brand", brand.slug)}
                className="accent-emerald"
              />
              {brand.name}
              {brand.is_house_brand && (
                <span className="text-highlight text-xs">★</span>
              )}
            </label>
          ))}
        </div>
      </div>

      <div>
        <h3 className="text-white font-semibold mb-3">Price</h3>
        <div className="flex items-center gap-2 text-sm">
          <input
            type="number"
            placeholder={`$${priceBounds.min}`}
            defaultValue={searchParams.get("minPrice") ?? ""}
            onBlur={(e) => set("minPrice", e.target.value)}
            className="w-full bg-[#101410] border border-border rounded-lg px-2 py-1.5 text-white"
          />
          <span className="text-soft">–</span>
          <input
            type="number"
            placeholder={`$${priceBounds.max}`}
            defaultValue={searchParams.get("maxPrice") ?? ""}
            onBlur={(e) => set("maxPrice", e.target.value)}
            className="w-full bg-[#101410] border border-border rounded-lg px-2 py-1.5 text-white"
          />
        </div>
      </div>

      <div>
        <h3 className="text-white font-semibold mb-3">Minimum THC%</h3>
        <input
          type="number"
          placeholder="e.g. 20"
          defaultValue={searchParams.get("minThc") ?? ""}
          onBlur={(e) => set("minThc", e.target.value)}
          className="w-full bg-[#101410] border border-border rounded-lg px-2 py-1.5 text-white text-sm"
        />
      </div>

      <label className="flex items-center gap-2 text-sm text-white cursor-pointer">
        <input
          type="checkbox"
          checked={searchParams.get("exclusive") === "true"}
          onChange={(e) => set("exclusive", e.target.checked ? "true" : null)}
          className="accent-highlight"
        />
        Ganjavores Exclusive only
      </label>

      {activeCount > 0 && (
        <button
          onClick={() => router.push(pathname)}
          className="text-sm text-emerald hover:text-neon underline"
        >
          Clear all filters ({activeCount})
        </button>
      )}
    </div>
  );

  return (
    <>
      {/* Mobile trigger */}
      <button
        onClick={() => setMobileOpen(true)}
        className="lg:hidden gv-btn-outline w-full mb-4"
      >
        Filters {activeCount > 0 && `(${activeCount})`}
      </button>

      {/* Desktop sidebar */}
      <aside className="hidden lg:block w-64 shrink-0">{content}</aside>

      {/* Mobile drawer */}
      {mobileOpen && (
        <div className="fixed inset-0 z-50 bg-midnight overflow-y-auto px-6 py-8 lg:hidden">
          <button
            onClick={() => setMobileOpen(false)}
            className="absolute top-6 right-6 text-white"
            aria-label="Close filters"
          >
            <X size={24} />
          </button>
          <h2 className="font-display text-2xl text-white mb-6">Filters</h2>
          {content}
          <button
            onClick={() => setMobileOpen(false)}
            className="gv-btn-primary w-full mt-8"
          >
            Show Results
          </button>
        </div>
      )}
    </>
  );
}

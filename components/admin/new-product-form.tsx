"use client";

import { useState, useTransition } from "react";
import { createProduct } from "@/app/actions/admin-products";
import { ProductFormFields } from "@/components/admin/product-form-fields";
import { NewProductImageField } from "@/components/admin/new-product-image-field";
import type { Brand, Category } from "@/lib/types";

export function NewProductForm({
  brands,
  categories,
}: {
  brands: Brand[];
  categories: Category[];
}) {
  const [isPending, startTransition] = useTransition();
  const [error, setError] = useState<string | null>(null);

  function handleSubmit(formData: FormData) {
    setError(null);
    startTransition(async () => {
      const result = await createProduct(formData);
      // createProduct redirects on success (which throws internally and
      // never resolves here), so reaching this line at all means it failed.
      if (result?.error) setError(result.error);
    });
  }

  return (
    <form action={handleSubmit} className="space-y-8">
      <ProductFormFields brands={brands} categories={categories} />

      <fieldset className="gv-card space-y-4">
        <legend className="text-white font-display text-lg mb-2">
          First Variant (add more after saving)
        </legend>
        <div className="grid grid-cols-3 gap-4">
          <input
            name="variant_label"
            placeholder="Label (e.g. 3.5g)"
            className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <input
            name="variant_price"
            type="number"
            step="0.01"
            placeholder="Price"
            className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <input
            name="variant_inventory"
            type="number"
            placeholder="Inventory"
            className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
        </div>
      </fieldset>

      <fieldset className="gv-card">
        <legend className="text-white font-display text-lg mb-2">
          First Image (add more after saving)
        </legend>
        <NewProductImageField />
      </fieldset>

      {error && <p className="text-red-400 text-sm">{error}</p>}

      <button type="submit" disabled={isPending} className="gv-btn-primary disabled:opacity-50">
        {isPending ? "Creating..." : "Create Product"}
      </button>
    </form>
  );
}

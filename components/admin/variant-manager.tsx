"use client";

import { useState, useTransition } from "react";
import { Trash2 } from "lucide-react";
import { updateVariantInventory, deleteVariant, addVariant } from "@/app/actions/admin-products";
import type { ProductVariant } from "@/lib/types";

export function VariantManager({
  productId,
  variants,
}: {
  productId: string;
  variants: ProductVariant[];
}) {
  const [isPending, startTransition] = useTransition();
  const [showAdd, setShowAdd] = useState(false);

  return (
    <div className="space-y-3">
      {variants.map((v) => (
        <div key={v.id} className="flex items-center gap-3 gv-card !p-3">
          <span className="text-white text-sm flex-1">{v.label}</span>
          <span className="text-emerald text-sm w-20">${v.price.toFixed(2)}</span>
          <input
            type="number"
            defaultValue={v.inventory_count}
            onBlur={(e) =>
              startTransition(() =>
                updateVariantInventory(v.id, productId, Number(e.target.value))
              )
            }
            className="w-20 bg-[#0d110d] border border-border rounded px-2 py-1 text-white text-sm"
          />
          <button
            onClick={() => startTransition(() => deleteVariant(v.id, productId))}
            className="text-soft hover:text-red-400"
            aria-label="Delete variant"
          >
            <Trash2 size={16} />
          </button>
        </div>
      ))}

      {showAdd ? (
        <form
          action={(fd) => {
            startTransition(() => addVariant(productId, fd));
            setShowAdd(false);
          }}
          className="flex items-center gap-2 gv-card !p-3"
        >
          <input
            name="label"
            placeholder="Label"
            required
            className="flex-1 bg-[#0d110d] border border-border rounded px-2 py-1 text-white text-sm"
          />
          <input
            name="price"
            type="number"
            step="0.01"
            placeholder="Price"
            required
            className="w-24 bg-[#0d110d] border border-border rounded px-2 py-1 text-white text-sm"
          />
          <input
            name="inventory_count"
            type="number"
            placeholder="Stock"
            className="w-20 bg-[#0d110d] border border-border rounded px-2 py-1 text-white text-sm"
          />
          <button type="submit" className="text-emerald text-sm">Add</button>
        </form>
      ) : (
        <button onClick={() => setShowAdd(true)} className="text-emerald text-sm hover:text-neon">
          + Add Variant
        </button>
      )}
    </div>
  );
}

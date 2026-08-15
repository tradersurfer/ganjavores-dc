"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useCart } from "@/lib/cart-context";
import type { Product, ProductVariant } from "@/lib/types";

export function AddToCartPanel({ product }: { product: Product }) {
  const { addLine } = useCart();
  const router = useRouter();
  const [selectedVariant, setSelectedVariant] = useState<ProductVariant>(
    product.variants.find((v) => v.is_default) ?? product.variants[0]
  );
  const [quantity, setQuantity] = useState(1);
  const [justAdded, setJustAdded] = useState(false);

  const outOfStock = selectedVariant && selectedVariant.inventory_count <= 0;

  function handleAdd() {
    if (!selectedVariant || outOfStock) return;
    addLine({
      product_id: product.id,
      variant_id: selectedVariant.id,
      product_name: product.name,
      variant_label: selectedVariant.label,
      unit_price: selectedVariant.price,
      quantity,
      image_url: product.images[0]?.url ?? null,
    });
    setJustAdded(true);
    setTimeout(() => setJustAdded(false), 2000);
  }

  if (!selectedVariant) {
    return <p className="text-soft">This product has no purchasable options yet.</p>;
  }

  return (
    <div className="space-y-4">
      {product.variants.length > 1 && (
        <div>
          <p className="text-sm text-soft mb-2">Options</p>
          <div className="flex flex-wrap gap-2">
            {product.variants.map((variant) => (
              <button
                key={variant.id}
                onClick={() => setSelectedVariant(variant)}
                className={`border rounded-full px-4 py-2 text-sm transition-colors ${
                  selectedVariant.id === variant.id
                    ? "border-emerald bg-emerald text-midnight font-semibold"
                    : "border-border text-white hover:border-emerald"
                }`}
              >
                {variant.label}
              </button>
            ))}
          </div>
        </div>
      )}

      <div className="flex items-baseline gap-3">
        <span className="text-3xl font-display text-emerald">
          ${selectedVariant.price.toFixed(2)}
        </span>
        {selectedVariant.compare_at_price &&
          selectedVariant.compare_at_price > selectedVariant.price && (
            <span className="text-soft/60 line-through text-lg">
              ${selectedVariant.compare_at_price.toFixed(2)}
            </span>
          )}
      </div>

      <div className="flex items-center gap-4">
        <div className="flex items-center border border-border rounded-full">
          <button
            onClick={() => setQuantity((q) => Math.max(1, q - 1))}
            className="w-9 h-9 flex items-center justify-center text-white"
            aria-label="Decrease quantity"
          >
            −
          </button>
          <span className="w-8 text-center text-white">{quantity}</span>
          <button
            onClick={() => setQuantity((q) => q + 1)}
            className="w-9 h-9 flex items-center justify-center text-white"
            aria-label="Increase quantity"
          >
            +
          </button>
        </div>

        <button
          onClick={handleAdd}
          disabled={outOfStock}
          className="gv-btn-primary flex-1 disabled:opacity-40 disabled:cursor-not-allowed disabled:hover:shadow-none"
        >
          {outOfStock ? "Out of Stock" : justAdded ? "Added ✓" : "Add to Bag"}
        </button>
      </div>

      {justAdded && (
        <button
          onClick={() => router.push("/cart")}
          className="text-emerald text-sm underline hover:text-neon"
        >
          View bag &rarr;
        </button>
      )}
    </div>
  );
}

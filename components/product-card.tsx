import Link from "next/link";
import Image from "next/image";
import type { Product } from "@/lib/types";

export function ProductCard({ product }: { product: Product }) {
  const primaryImage = product.images[0];
  const defaultVariant =
    product.variants.find((v) => v.is_default) ?? product.variants[0];
  const cheapest = product.variants.reduce(
    (min, v) => (v.price < min ? v.price : min),
    product.variants[0]?.price ?? 0
  );
  const isOnSale = product.variants.some(
    (v) => v.compare_at_price && v.compare_at_price > v.price
  );

  return (
    <Link href={`/product/${product.slug}`} className="gv-card group block">
      <div className="relative aspect-square mb-3 overflow-hidden rounded-lg bg-[#0d110d]">
        {primaryImage ? (
          <Image
            src={primaryImage.url}
            alt={primaryImage.alt_text ?? product.name}
            fill
            className="object-cover transition-transform duration-300 group-hover:scale-105"
            sizes="(max-width: 768px) 50vw, 25vw"
          />
        ) : (
          <div className="w-full h-full flex items-center justify-center text-soft/40 text-sm">
            No image yet
          </div>
        )}

        <div className="absolute top-2 left-2 flex flex-col gap-1">
          {product.is_ganjavores_exclusive && (
            <span className="gv-badge-exclusive">Exclusive</span>
          )}
          {isOnSale && <span className="gv-badge-sale">Sale</span>}
        </div>
      </div>

      {product.brand && (
        <p className="text-xs text-soft uppercase tracking-wide mb-1">
          {product.brand.name}
        </p>
      )}
      <h3 className="text-white font-medium leading-snug group-hover:text-emerald transition-colors">
        {product.name}
      </h3>

      <div className="flex items-center justify-between mt-2 text-sm">
        <span className="text-soft">
          {product.strain_type ?? ""}
          {product.thc_percent ? ` · THC ${product.thc_percent}%` : ""}
        </span>
      </div>

      <div className="flex items-center justify-between mt-2">
        <span className="text-emerald font-semibold">
          {product.variants.length > 1 ? "From " : ""}${cheapest.toFixed(2)}
        </span>
        {defaultVariant && (
          <span className="text-xs text-soft/70">{defaultVariant.label}</span>
        )}
      </div>
    </Link>
  );
}

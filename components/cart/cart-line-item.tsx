"use client";

import Image from "next/image";
import Link from "next/link";
import { Trash2 } from "lucide-react";
import { useCart } from "@/lib/cart-context";
import type { CartLine } from "@/lib/types";

export function CartLineItem({ line }: { line: CartLine }) {
  const { updateQuantity, removeLine } = useCart();

  return (
    <div className="flex gap-4 py-4 border-b border-border">
      <div className="relative w-20 h-20 shrink-0 rounded-lg overflow-hidden bg-[#0d110d]">
        {line.image_url ? (
          <Image src={line.image_url} alt={line.product_name} fill className="object-cover" />
        ) : null}
      </div>

      <div className="flex-1">
        <p className="text-white font-medium">{line.product_name}</p>
        <p className="text-soft text-sm">{line.variant_label}</p>
        <p className="text-emerald font-semibold mt-1">${line.unit_price.toFixed(2)}</p>

        <div className="flex items-center gap-3 mt-2">
          <div className="flex items-center border border-border rounded-full">
            <button
              onClick={() => updateQuantity(line.variant_id, line.quantity - 1)}
              className="w-7 h-7 flex items-center justify-center text-white text-sm"
              aria-label="Decrease quantity"
            >
              −
            </button>
            <span className="w-6 text-center text-white text-sm">{line.quantity}</span>
            <button
              onClick={() => updateQuantity(line.variant_id, line.quantity + 1)}
              className="w-7 h-7 flex items-center justify-center text-white text-sm"
              aria-label="Increase quantity"
            >
              +
            </button>
          </div>
          <button
            onClick={() => removeLine(line.variant_id)}
            className="text-soft hover:text-red-400"
            aria-label="Remove item"
          >
            <Trash2 size={16} />
          </button>
        </div>
      </div>

      <p className="text-white font-semibold">
        ${(line.unit_price * line.quantity).toFixed(2)}
      </p>
    </div>
  );
}

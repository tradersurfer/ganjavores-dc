"use client";

import Image from "next/image";
import { useTransition } from "react";
import { Trash2 } from "lucide-react";
import { addProductImage, deleteProductImage } from "@/app/actions/admin-products";
import { ImageUploadButton } from "@/components/admin/image-upload-button";
import type { ProductImage } from "@/lib/types";

export function ImageManager({
  productId,
  images,
}: {
  productId: string;
  images: ProductImage[];
}) {
  const [isPending, startTransition] = useTransition();

  function saveImageUrl(url: string) {
    const fd = new FormData();
    fd.set("url", url);
    fd.set("alt_text", "");
    startTransition(() => addProductImage(productId, fd));
  }

  return (
    <div className="space-y-4">
      <div className="grid grid-cols-4 gap-3">
        {images.map((img) => (
          <div key={img.id} className="relative aspect-square rounded-lg overflow-hidden bg-[#0d110d] group">
            <Image src={img.url} alt={img.alt_text ?? ""} fill className="object-cover" />
            <button
              onClick={() => startTransition(() => deleteProductImage(img.id, productId))}
              className="absolute top-1 right-1 bg-midnight/80 text-red-400 rounded-full p-1 opacity-0 group-hover:opacity-100 transition-opacity"
              aria-label="Delete image"
            >
              <Trash2 size={14} />
            </button>
          </div>
        ))}
      </div>

      <div className="flex flex-wrap items-center gap-3">
        <ImageUploadButton onUploaded={saveImageUrl} label="Upload Image" />
        <span className="text-soft text-xs">or</span>
        <form
          action={(fd) => startTransition(() => addProductImage(productId, fd))}
          className="flex gap-2 flex-1 min-w-[240px]"
        >
          <input
            name="url"
            placeholder="Paste an image URL instead"
            className="flex-1 bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          />
          <button type="submit" className="gv-btn-outline text-sm px-4">
            Add
          </button>
        </form>
      </div>
    </div>
  );
}

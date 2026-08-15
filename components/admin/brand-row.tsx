"use client";

import { useState, useTransition } from "react";
import { Trash2, Pencil } from "lucide-react";
import { createBrand, updateBrand, deleteBrand } from "@/app/actions/admin-brands";
import { ImageUploadButton } from "@/components/admin/image-upload-button";
import type { Brand } from "@/lib/types";

export function NewBrandForm() {
  const [logoUrl, setLogoUrl] = useState("");
  const [isPending, startTransition] = useTransition();

  return (
    <form action={(fd) => startTransition(() => createBrand(fd))} className="space-y-3">
      <input
        name="name"
        required
        placeholder="Brand name"
        className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
      />
      <textarea
        name="description"
        placeholder="Description (optional)"
        rows={2}
        className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
      />

      <div>
        <input type="hidden" name="logo_url" value={logoUrl} />
        <div className="flex flex-wrap items-center gap-3">
          {logoUrl && (
            <img src={logoUrl} alt="Logo preview" className="w-12 h-12 object-cover rounded-lg border border-border" />
          )}
          <ImageUploadButton onUploaded={setLogoUrl} label="Upload Logo" />
          <span className="text-soft text-xs">or</span>
          <input
            value={logoUrl}
            onChange={(e) => setLogoUrl(e.target.value)}
            placeholder="Paste a logo URL instead"
            className="flex-1 min-w-[180px] bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          />
        </div>
      </div>

      <input
        name="website_url"
        placeholder="Website URL (optional)"
        className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
      />
      <label className="flex items-center gap-2 text-white text-sm cursor-pointer">
        <input type="checkbox" name="is_house_brand" className="accent-highlight" />
        This is a house brand (e.g. Ganjavores by Lee Farms)
      </label>
      <button type="submit" disabled={isPending} className="gv-btn-primary disabled:opacity-50">
        {isPending ? "Adding..." : "Add Brand"}
      </button>
    </form>
  );
}

export function BrandRow({ brand }: { brand: Brand }) {
  const [editing, setEditing] = useState(false);
  const [logoUrl, setLogoUrl] = useState(brand.logo_url ?? "");
  const [isPending, startTransition] = useTransition();

  if (editing) {
    return (
      <form
        action={(fd) => {
          startTransition(async () => {
            await updateBrand(brand.id, fd);
            setEditing(false);
          });
        }}
        className="gv-card space-y-3"
      >
        <input
          name="name"
          required
          defaultValue={brand.name}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
        <textarea
          name="description"
          defaultValue={brand.description ?? ""}
          placeholder="Brand description (shows in 'About the Brand' on PDPs)"
          rows={2}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
        <div>
          <input type="hidden" name="logo_url" value={logoUrl} />
          <div className="flex flex-wrap items-center gap-3">
            {logoUrl && (
              <img src={logoUrl} alt="Logo preview" className="w-10 h-10 object-cover rounded-lg border border-border" />
            )}
            <ImageUploadButton onUploaded={setLogoUrl} label="Upload Logo" />
            <input
              value={logoUrl}
              onChange={(e) => setLogoUrl(e.target.value)}
              placeholder="Logo URL"
              className="flex-1 min-w-[140px] bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
            />
          </div>
        </div>
        <input
          name="website_url"
          defaultValue={brand.website_url ?? ""}
          placeholder="Website URL"
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
        <label className="flex items-center gap-2 text-white text-sm cursor-pointer">
          <input
            type="checkbox"
            name="is_house_brand"
            defaultChecked={brand.is_house_brand}
            className="accent-highlight"
          />
          House brand
        </label>
        <div className="flex gap-3">
          <button type="submit" disabled={isPending} className="gv-btn-primary text-sm px-4 py-2">
            Save
          </button>
          <button
            type="button"
            onClick={() => setEditing(false)}
            className="text-soft text-sm hover:text-white"
          >
            Cancel
          </button>
        </div>
      </form>
    );
  }

  return (
    <div className="gv-card flex items-center justify-between">
      <div>
        <p className="text-white font-medium">
          {brand.name}
          {brand.is_house_brand && <span className="ml-2 gv-badge-exclusive text-[10px]">House</span>}
        </p>
        {brand.description && <p className="text-soft text-sm mt-1">{brand.description}</p>}
      </div>
      <div className="flex items-center gap-3">
        <button onClick={() => setEditing(true)} className="text-soft hover:text-emerald" aria-label="Edit brand">
          <Pencil size={16} />
        </button>
        <button
          onClick={() => {
            if (confirm(`Delete "${brand.name}"? Products stay, but lose this brand link.`)) {
              startTransition(() => deleteBrand(brand.id));
            }
          }}
          className="text-soft hover:text-red-400"
          aria-label="Delete brand"
        >
          <Trash2 size={16} />
        </button>
      </div>
    </div>
  );
}

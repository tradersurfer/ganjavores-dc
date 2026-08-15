"use client";

import { useState, useTransition } from "react";
import { Trash2, Pencil } from "lucide-react";
import { updateCategory, deleteCategory } from "@/app/actions/admin-categories";
import type { Category } from "@/lib/types";

export function CategoryRow({ category }: { category: Category }) {
  const [editing, setEditing] = useState(false);
  const [isPending, startTransition] = useTransition();

  if (editing) {
    return (
      <form
        action={(fd) => {
          startTransition(async () => {
            await updateCategory(category.id, fd);
            setEditing(false);
          });
        }}
        className="gv-card space-y-3"
      >
        <input
          name="name"
          required
          defaultValue={category.name}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
        <textarea
          name="description"
          defaultValue={category.description ?? ""}
          placeholder="Shows as the intro copy on the shop page for this category"
          rows={2}
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
        <div>
          <label className="text-soft text-xs block mb-1">Sort Order</label>
          <input
            name="display_order"
            type="number"
            defaultValue={category.display_order}
            className="w-24 bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          />
        </div>
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
        <p className="text-white font-medium">{category.name}</p>
        {category.description && <p className="text-soft text-sm mt-1">{category.description}</p>}
      </div>
      <div className="flex items-center gap-3">
        <button onClick={() => setEditing(true)} className="text-soft hover:text-emerald" aria-label="Edit category">
          <Pencil size={16} />
        </button>
        <button
          onClick={() => {
            if (confirm(`Delete "${category.name}"? Products stay, but lose this category link.`)) {
              startTransition(() => deleteCategory(category.id));
            }
          }}
          className="text-soft hover:text-red-400"
          aria-label="Delete category"
        >
          <Trash2 size={16} />
        </button>
      </div>
    </div>
  );
}

"use client";

import { useTransition } from "react";
import { Trash2 } from "lucide-react";
import {
  addPotencyRow,
  deletePotencyRow,
} from "@/app/actions/admin-potency";

export function PotencyManager({
  productId,
  kind,
  rows,
}: {
  productId: string;
  kind: "terpene" | "cannabinoid";
  rows: { id: string; name: string; percent: number | null }[];
}) {
  const [isPending, startTransition] = useTransition();

  return (
    <div className="space-y-2">
      {rows.map((row) => (
        <div key={row.id} className="flex items-center gap-3 gv-card !p-2.5">
          <span className="text-white text-sm flex-1">{row.name}</span>
          <span className="text-soft text-sm w-16">{row.percent}%</span>
          <button
            onClick={() => startTransition(() => deletePotencyRow(row.id, productId, kind))}
            className="text-soft hover:text-red-400"
          >
            <Trash2 size={14} />
          </button>
        </div>
      ))}

      <form
        action={(fd) => startTransition(() => addPotencyRow(productId, kind, fd))}
        className="flex items-center gap-2"
      >
        <input
          name="name"
          placeholder={kind === "terpene" ? "e.g. Beta Caryophyllene" : "e.g. THCA"}
          required
          className="flex-1 bg-[#101410] border border-border rounded-lg px-3 py-1.5 text-white text-sm"
        />
        <input
          name="percent"
          type="number"
          step="0.01"
          placeholder="%"
          className="w-20 bg-[#101410] border border-border rounded-lg px-3 py-1.5 text-white text-sm"
        />
        <button type="submit" className="text-emerald text-sm">Add</button>
      </form>
    </div>
  );
}

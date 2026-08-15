"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

const TABLE = {
  terpene: "product_terpenes",
  cannabinoid: "product_cannabinoids",
} as const;

export async function addPotencyRow(
  productId: string,
  kind: "terpene" | "cannabinoid",
  formData: FormData
) {
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return;

  const { count } = await supabase
    .from(TABLE[kind])
    .select("id", { count: "exact", head: true })
    .eq("product_id", productId);

  await supabase.from(TABLE[kind]).insert({
    product_id: productId,
    name,
    percent: formData.get("percent") ? Number(formData.get("percent")) : null,
    display_order: count ?? 0,
  });

  revalidatePath(`/admin/products/${productId}`);
}

export async function deletePotencyRow(
  rowId: string,
  productId: string,
  kind: "terpene" | "cannabinoid"
) {
  const supabase = await createClient();
  await supabase.from(TABLE[kind]).delete().eq("id", rowId);
  revalidatePath(`/admin/products/${productId}`);
}

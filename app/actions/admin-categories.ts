"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");
}

export async function createCategory(formData: FormData) {
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return;

  const { count } = await supabase
    .from("categories")
    .select("id", { count: "exact", head: true });

  await supabase.from("categories").insert({
    name,
    slug: slugify(name),
    description: String(formData.get("description") ?? "") || null,
    display_order: count ?? 0,
  });

  revalidatePath("/admin/categories");
  revalidatePath("/shop");
}

export async function updateCategory(categoryId: string, formData: FormData) {
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return;

  await supabase
    .from("categories")
    .update({
      name,
      description: String(formData.get("description") ?? "") || null,
      display_order: Number(formData.get("display_order") ?? 0),
    })
    .eq("id", categoryId);

  revalidatePath("/admin/categories");
  revalidatePath("/shop");
}

export async function deleteCategory(categoryId: string) {
  const supabase = await createClient();
  // ON DELETE SET NULL on products.category_id — deleting a category
  // un-categorizes its products rather than deleting them.
  await supabase.from("categories").delete().eq("id", categoryId);
  revalidatePath("/admin/categories");
  revalidatePath("/shop");
}

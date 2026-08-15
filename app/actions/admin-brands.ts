"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");
}

export async function createBrand(formData: FormData) {
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return;

  await supabase.from("brands").insert({
    name,
    slug: slugify(name),
    is_house_brand: formData.get("is_house_brand") === "on",
    description: String(formData.get("description") ?? "") || null,
    logo_url: String(formData.get("logo_url") ?? "") || null,
    website_url: String(formData.get("website_url") ?? "") || null,
  });

  revalidatePath("/admin/brands");
  revalidatePath("/brands");
}

export async function updateBrand(brandId: string, formData: FormData) {
  const supabase = await createClient();
  const name = String(formData.get("name") ?? "").trim();
  if (!name) return;

  await supabase
    .from("brands")
    .update({
      name,
      is_house_brand: formData.get("is_house_brand") === "on",
      description: String(formData.get("description") ?? "") || null,
      logo_url: String(formData.get("logo_url") ?? "") || null,
      website_url: String(formData.get("website_url") ?? "") || null,
    })
    .eq("id", brandId);

  revalidatePath("/admin/brands");
  revalidatePath("/brands");
}

export async function deleteBrand(brandId: string) {
  const supabase = await createClient();
  // brands referenced by products use ON DELETE SET NULL (see schema.sql),
  // so this can't orphan a product row — worst case, its brand shows blank
  // until you reassign it.
  await supabase.from("brands").delete().eq("id", brandId);
  revalidatePath("/admin/brands");
  revalidatePath("/brands");
}

"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");
}

export type ProductFormState = { error?: string };

export async function createProduct(formData: FormData): Promise<ProductFormState> {
  const supabase = await createClient();

  const name = String(formData.get("name") ?? "").trim();
  if (!name) return { error: "Product name is required" };

  const { data: product, error } = await supabase
    .from("products")
    .insert({
      slug: slugify(name),
      name,
      brand_id: formData.get("brand_id") || null,
      category_id: formData.get("category_id") || null,
      strain_type: formData.get("strain_type") || null,
      cross_genetics: formData.get("cross_genetics") || null,
      palate: formData.get("palate") || null,
      short_description: formData.get("short_description") || null,
      description: formData.get("description") || "",
      thc_percent: formData.get("thc_percent") ? Number(formData.get("thc_percent")) : null,
      cbd_percent: formData.get("cbd_percent") ? Number(formData.get("cbd_percent")) : null,
      is_ganjavores_exclusive: formData.get("is_ganjavores_exclusive") === "on",
      is_featured: formData.get("is_featured") === "on",
      is_active: formData.get("is_active") !== "off",
      inventory_count: 0,
    })
    .select("id")
    .single();

  if (error || !product) return { error: error?.message ?? "Failed to create product" };

  // first variant + image, added inline on the "new product" form
  const variantLabel = String(formData.get("variant_label") ?? "").trim();
  const variantPrice = formData.get("variant_price");
  if (variantLabel && variantPrice) {
    await supabase.from("product_variants").insert({
      product_id: product.id,
      label: variantLabel,
      price: Number(variantPrice),
      is_default: true,
      inventory_count: Number(formData.get("variant_inventory") ?? 0),
    });
  }

  const imageUrl = String(formData.get("image_url") ?? "").trim();
  if (imageUrl) {
    await supabase.from("product_images").insert({
      product_id: product.id,
      url: imageUrl,
      alt_text: name,
      display_order: 0,
    });
  }

  revalidatePath("/admin/products");
  redirect(`/admin/products/${product.id}`);
}

export async function updateProduct(
  productId: string,
  formData: FormData
): Promise<ProductFormState> {
  const supabase = await createClient();

  const name = String(formData.get("name") ?? "").trim();
  if (!name) return { error: "Product name is required" };

  const { error } = await supabase
    .from("products")
    .update({
      name,
      brand_id: formData.get("brand_id") || null,
      category_id: formData.get("category_id") || null,
      strain_type: formData.get("strain_type") || null,
      cross_genetics: formData.get("cross_genetics") || null,
      palate: formData.get("palate") || null,
      short_description: formData.get("short_description") || null,
      description: formData.get("description") || "",
      thc_percent: formData.get("thc_percent") ? Number(formData.get("thc_percent")) : null,
      cbd_percent: formData.get("cbd_percent") ? Number(formData.get("cbd_percent")) : null,
      is_ganjavores_exclusive: formData.get("is_ganjavores_exclusive") === "on",
      is_featured: formData.get("is_featured") === "on",
      is_active: formData.get("is_active") !== "off",
    })
    .eq("id", productId);

  if (error) return { error: error.message };

  revalidatePath("/admin/products");
  revalidatePath(`/admin/products/${productId}`);
  return {};
}

export async function deleteProduct(productId: string) {
  const supabase = await createClient();
  await supabase.from("products").delete().eq("id", productId);
  revalidatePath("/admin/products");
  redirect("/admin/products");
}

export async function addVariant(productId: string, formData: FormData) {
  const supabase = await createClient();
  await supabase.from("product_variants").insert({
    product_id: productId,
    label: String(formData.get("label") ?? ""),
    price: Number(formData.get("price") ?? 0),
    compare_at_price: formData.get("compare_at_price")
      ? Number(formData.get("compare_at_price"))
      : null,
    inventory_count: Number(formData.get("inventory_count") ?? 0),
    is_default: false,
  });
  revalidatePath(`/admin/products/${productId}`);
}

export async function updateVariantInventory(variantId: string, productId: string, inventory: number) {
  const supabase = await createClient();
  await supabase
    .from("product_variants")
    .update({ inventory_count: inventory })
    .eq("id", variantId);
  revalidatePath(`/admin/products/${productId}`);
  revalidatePath("/shop");
}

export async function deleteVariant(variantId: string, productId: string) {
  const supabase = await createClient();
  await supabase.from("product_variants").delete().eq("id", variantId);
  revalidatePath(`/admin/products/${productId}`);
}

export async function addProductImage(productId: string, formData: FormData) {
  const supabase = await createClient();
  const url = String(formData.get("url") ?? "").trim();
  if (!url) return;
  const { count } = await supabase
    .from("product_images")
    .select("id", { count: "exact", head: true })
    .eq("product_id", productId);
  await supabase.from("product_images").insert({
    product_id: productId,
    url,
    alt_text: String(formData.get("alt_text") ?? ""),
    display_order: count ?? 0,
  });
  revalidatePath(`/admin/products/${productId}`);
}

export async function deleteProductImage(imageId: string, productId: string) {
  const supabase = await createClient();
  await supabase.from("product_images").delete().eq("id", imageId);
  revalidatePath(`/admin/products/${productId}`);
}

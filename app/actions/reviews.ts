"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

export async function submitReview(productId: string, formData: FormData) {
  const supabase = await createClient();

  const author_name = String(formData.get("author_name") ?? "").trim();
  const rating = Number(formData.get("rating"));
  const title = String(formData.get("title") ?? "").trim() || null;
  const body = String(formData.get("body") ?? "").trim();

  if (!author_name || !body || rating < 1 || rating > 5) {
    throw new Error("Missing or invalid review fields");
  }

  const { error } = await supabase.from("reviews").insert({
    product_id: productId,
    author_name,
    rating,
    title,
    body,
    is_approved: false, // admin moderates before it shows publicly
  });

  if (error) throw error;

  revalidatePath("/product", "layout");
}

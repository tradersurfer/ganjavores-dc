"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

export async function approveReview(reviewId: string) {
  const supabase = await createClient();
  await supabase.from("reviews").update({ is_approved: true }).eq("id", reviewId);
  revalidatePath("/admin/reviews");
  revalidatePath("/product", "layout");
}

export async function rejectReview(reviewId: string) {
  const supabase = await createClient();
  await supabase.from("reviews").delete().eq("id", reviewId);
  revalidatePath("/admin/reviews");
}

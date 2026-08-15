"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

export async function createAnnouncement(formData: FormData) {
  const supabase = await createClient();
  await supabase.from("announcements").insert({
    title: String(formData.get("title") ?? ""),
    subtitle: String(formData.get("subtitle") ?? "") || null,
    image_url: String(formData.get("image_url") ?? "") || null,
    mobile_image_url: String(formData.get("mobile_image_url") ?? "") || null,
    link_url: String(formData.get("link_url") ?? "") || null,
    placement: String(formData.get("placement") ?? "homepage_secondary"),
    is_active: formData.get("is_active") === "on",
  });
  revalidatePath("/admin/announcements");
  revalidatePath("/");
  revalidatePath("/deals");
}

export async function toggleAnnouncementActive(id: string, isActive: boolean) {
  const supabase = await createClient();
  await supabase.from("announcements").update({ is_active: isActive }).eq("id", id);
  revalidatePath("/admin/announcements");
  revalidatePath("/");
  revalidatePath("/deals");
}

export async function deleteAnnouncement(id: string) {
  const supabase = await createClient();
  await supabase.from("announcements").delete().eq("id", id);
  revalidatePath("/admin/announcements");
  revalidatePath("/");
  revalidatePath("/deals");
}

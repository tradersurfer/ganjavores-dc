"use server";

import { createClient } from "@/lib/supabase/server";

export async function submitContactMessage(
  formData: FormData
): Promise<{ success: boolean; error?: string }> {
  const name = String(formData.get("name") ?? "").trim();
  const email = String(formData.get("email") ?? "").trim();
  const message = String(formData.get("message") ?? "").trim();

  if (!name || !email || !message) {
    return { success: false, error: "Name, email, and message are required." };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("contact_messages").insert({
    name,
    email,
    phone: String(formData.get("phone") ?? "") || null,
    subject: String(formData.get("subject") ?? "") || null,
    message,
  });

  if (error) return { success: false, error: "Couldn't send — try calling instead." };
  return { success: true };
}

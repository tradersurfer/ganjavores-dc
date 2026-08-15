"use client";

import { useState } from "react";
import { submitContactMessage } from "@/app/actions/contact";

export function ContactForm() {
  const [status, setStatus] = useState<"idle" | "sending" | "sent" | "error">("idle");
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(formData: FormData) {
    setStatus("sending");
    const result = await submitContactMessage(formData);
    if (result.success) {
      setStatus("sent");
    } else {
      setStatus("error");
      setError(result.error ?? "Something went wrong.");
    }
  }

  if (status === "sent") {
    return (
      <div className="gv-card text-center py-10">
        <p className="text-emerald text-lg">Message sent — we'll get back to you shortly.</p>
      </div>
    );
  }

  return (
    <form action={handleSubmit} className="gv-card space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <input
          name="name"
          required
          placeholder="Name"
          className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
        />
        <input
          name="phone"
          placeholder="Phone (optional)"
          className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
        />
      </div>
      <input
        name="email"
        type="email"
        required
        placeholder="Email"
        className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
      />
      <input
        name="subject"
        placeholder="Subject (optional)"
        className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
      />
      <textarea
        name="message"
        required
        rows={5}
        placeholder="How can we help?"
        className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
      />

      {status === "error" && <p className="text-red-400 text-sm">{error}</p>}

      <button
        type="submit"
        disabled={status === "sending"}
        className="gv-btn-primary disabled:opacity-50"
      >
        {status === "sending" ? "Sending..." : "Send Message"}
      </button>
    </form>
  );
}

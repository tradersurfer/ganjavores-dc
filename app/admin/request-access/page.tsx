"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

export default function RequestAccess() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const supabase = createClient();
    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: { emailRedirectTo: `${window.location.origin}/admin` },
    });
    if (!error) {
      setMessage("Magic link sent! Check your email to log in.");
    } else {
      setMessage("An account request has been sent. An admin will approve you.");
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-midnight px-4">
      <form onSubmit={handleSubmit} className="gv-card w-full max-w-sm space-y-4">
        <h1 className="font-display text-2xl text-emerald text-center mb-2">
          Request Admin Access
        </h1>
        <p className="text-soft text-sm text-center">
          Enter your email and we'll send you a magic link to log in as an admin.
        </p>
        <input
          type="email"
          required
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Your email"
          className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
        />
        <button type="submit" className="gv-btn-primary w-full">
          Send Magic Link
        </button>
        {message && <p className="text-emerald text-sm text-center">{message}</p>}
      </form>
    </div>
  );
}

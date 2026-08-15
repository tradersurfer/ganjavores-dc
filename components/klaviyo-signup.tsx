"use client";

import { useState } from "react";

/**
 * Klaviyo list-based email capture. Deliberately does NOT use Klaviyo's
 * embedded form builder (that requires pasting their JS snippet + a
 * specific form ID from the Klaviyo dashboard, which doesn't exist
 * until you've built the form there first). Instead this posts
 * straight to Klaviyo's public subscribe API with your list ID, which
 * you can get today without building anything in their UI first.
 *
 * Setup:
 * 1. In Klaviyo: Account → Settings → API Keys → copy your **public**
 *    API key (safe to expose client-side, it's rate-limited and can
 *    only subscribe people, not read data)
 * 2. Create or find your list ID: Lists & Segments → open a list →
 *    the ID is in the URL
 * 3. Set NEXT_PUBLIC_KLAVIYO_PUBLIC_KEY and NEXT_PUBLIC_KLAVIYO_LIST_ID
 *    in your environment variables
 *
 * Until both are set, this component quietly does nothing when
 * submitted rather than erroring at people — remove the `if (!configured)`
 * guard once you've set the two env vars above.
 */
export function KlaviyoSignup({ className = "" }: { className?: string }) {
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<"idle" | "sending" | "sent" | "error">("idle");

  const publicKey = process.env.NEXT_PUBLIC_KLAVIYO_PUBLIC_KEY;
  const listId = process.env.NEXT_PUBLIC_KLAVIYO_LIST_ID;
  const configured = Boolean(publicKey && listId);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!configured) {
      setStatus("error");
      return;
    }

    setStatus("sending");
    try {
      const res = await fetch(
        `https://a.klaviyo.com/client/subscriptions/?company_id=${publicKey}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            revision: "2024-10-15",
          },
          body: JSON.stringify({
            data: {
              type: "subscription",
              attributes: {
                profile: {
                  data: { type: "profile", attributes: { email } },
                },
              },
              relationships: {
                list: { data: { type: "list", id: listId } },
              },
            },
          }),
        }
      );
      setStatus(res.ok ? "sent" : "error");
    } catch {
      setStatus("error");
    }
  }

  if (status === "sent") {
    return (
      <p className={`text-emerald text-sm ${className}`}>
        You&rsquo;re on the list — watch for deals and drops.
      </p>
    );
  }

  return (
    <form onSubmit={handleSubmit} className={`flex gap-2 ${className}`}>
      <input
        type="email"
        required
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email for deals & drops"
        className="flex-1 bg-[#101410] border border-border rounded-full px-4 py-2.5 text-white text-sm placeholder:text-soft/50"
      />
      <button
        type="submit"
        disabled={status === "sending"}
        className="gv-btn-primary text-sm px-5 py-2.5 disabled:opacity-50 shrink-0"
      >
        {status === "sending" ? "..." : "Sign Up"}
      </button>
      {status === "error" && !configured && (
        <p className="text-soft/60 text-xs absolute mt-12">
          Email signup isn&rsquo;t configured yet — see KlaviyoSignup component setup notes.
        </p>
      )}
    </form>
  );
}

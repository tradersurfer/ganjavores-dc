"use client";

import { useTransition } from "react";
import { markMessageRead } from "@/app/actions/admin-messages";

export function MarkReadButton({ id }: { id: string }) {
  const [isPending, startTransition] = useTransition();

  return (
    <button
      onClick={() => startTransition(() => markMessageRead(id))}
      disabled={isPending}
      className="text-emerald text-sm hover:text-neon disabled:opacity-50 shrink-0"
    >
      Mark Read
    </button>
  );
}

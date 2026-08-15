"use client";

import { useTransition } from "react";
import { approveReview, rejectReview } from "@/app/actions/admin-reviews";

export function ReviewModerationActions({ reviewId }: { reviewId: string }) {
  const [isPending, startTransition] = useTransition();

  return (
    <div className="flex gap-3">
      <button
        onClick={() => startTransition(() => approveReview(reviewId))}
        disabled={isPending}
        className="text-emerald text-sm hover:text-neon disabled:opacity-50"
      >
        Approve
      </button>
      <button
        onClick={() => {
          if (confirm("Reject and permanently delete this review?")) {
            startTransition(() => rejectReview(reviewId));
          }
        }}
        disabled={isPending}
        className="text-red-400 text-sm hover:text-red-300 disabled:opacity-50"
      >
        Reject
      </button>
    </div>
  );
}

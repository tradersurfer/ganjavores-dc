"use client";

import { useState } from "react";
import { Star } from "lucide-react";
import type { Review } from "@/lib/types";
import { submitReview } from "@/app/actions/reviews";

export function ReviewsPanel({
  productId,
  reviews,
}: {
  productId: string;
  reviews: Review[];
}) {
  const [showForm, setShowForm] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const avgRating =
    reviews.length > 0
      ? reviews.reduce((sum, r) => sum + r.rating, 0) / reviews.length
      : 0;

  async function handleSubmit(formData: FormData) {
    await submitReview(productId, formData);
    setSubmitted(true);
    setShowForm(false);
  }

  return (
    <div className="space-y-6">
      {reviews.length > 0 && (
        <div className="flex items-center gap-2">
          <StarRow rating={Math.round(avgRating)} />
          <span className="text-soft text-sm">
            {avgRating.toFixed(1)} ({reviews.length} review{reviews.length !== 1 ? "s" : ""})
          </span>
        </div>
      )}

      {reviews.map((review) => (
        <div key={review.id} className="border-b border-border pb-4">
          <StarRow rating={review.rating} />
          {review.title && <p className="text-white font-medium mt-1">{review.title}</p>}
          <p className="text-soft text-sm mt-1">
            By {review.author_name} on{" "}
            {new Date(review.created_at).toLocaleDateString("en-US", {
              month: "long",
              day: "numeric",
              year: "numeric",
            })}
          </p>
          <p className="text-soft mt-2">{review.body}</p>
        </div>
      ))}

      {reviews.length === 0 && !submitted && (
        <p className="text-soft text-sm">No reviews yet — be the first.</p>
      )}

      {submitted ? (
        <p className="text-emerald text-sm">
          Thanks — your review is in queue for approval and will show up here shortly.
        </p>
      ) : showForm ? (
        <form action={handleSubmit} className="space-y-3 gv-card">
          <input
            name="author_name"
            required
            placeholder="Your name"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          />
          <select
            name="rating"
            required
            defaultValue="5"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          >
            {[5, 4, 3, 2, 1].map((n) => (
              <option key={n} value={n}>
                {n} star{n !== 1 ? "s" : ""}
              </option>
            ))}
          </select>
          <input
            name="title"
            placeholder="Review title (optional)"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          />
          <textarea
            name="body"
            required
            rows={4}
            placeholder="What did you think?"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
          />
          <button type="submit" className="gv-btn-primary text-sm">
            Submit Review
          </button>
        </form>
      ) : (
        <button onClick={() => setShowForm(true)} className="gv-btn-outline text-sm">
          Write a Review
        </button>
      )}
    </div>
  );
}

function StarRow({ rating }: { rating: number }) {
  return (
    <div className="flex gap-0.5">
      {Array.from({ length: 5 }).map((_, i) => (
        <Star
          key={i}
          size={16}
          className={i < rating ? "fill-emerald text-emerald" : "text-border"}
        />
      ))}
    </div>
  );
}

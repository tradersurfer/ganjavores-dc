import { createClient } from "@/lib/supabase/server";
import { ReviewModerationActions } from "@/components/admin/review-moderation-actions";

export const dynamic = "force-dynamic";

export default async function AdminReviewsPage() {
  const supabase = await createClient();
  const { data: pending } = await supabase
    .from("reviews")
    .select("id, author_name, rating, title, body, created_at, product:products(name, slug)")
    .eq("is_approved", false)
    .order("created_at", { ascending: false });

  return (
    <div className="max-w-3xl">
      <h1 className="gv-section-heading mb-8">Reviews Awaiting Approval</h1>

      <div className="space-y-4">
        {(pending ?? []).map((r: any) => (
          <div key={r.id} className="gv-card">
            <div className="flex items-center justify-between mb-2">
              <div>
                <p className="text-white font-medium">
                  {r.product?.name ?? "Unknown product"}
                </p>
                <p className="text-soft text-xs">
                  {r.author_name} · {"★".repeat(r.rating)}
                  {"☆".repeat(5 - r.rating)} ·{" "}
                  {new Date(r.created_at).toLocaleDateString("en-US")}
                </p>
              </div>
              <ReviewModerationActions reviewId={r.id} />
            </div>
            {r.title && <p className="text-white text-sm font-medium">{r.title}</p>}
            <p className="text-soft text-sm mt-1">{r.body}</p>
          </div>
        ))}

        {(pending ?? []).length === 0 && (
          <p className="text-soft text-sm py-8 text-center">
            Nothing waiting on approval right now.
          </p>
        )}
      </div>
    </div>
  );
}

"use client";

import { useState, useTransition } from "react";
import { updateProduct, deleteProduct } from "@/app/actions/admin-products";

export function ProductEditForm({
  productId,
  children,
}: {
  productId: string;
  children: React.ReactNode;
}) {
  const [isPending, startTransition] = useTransition();
  const [saved, setSaved] = useState(false);
  const [error, setError] = useState<string | null>(null);

  function handleSubmit(formData: FormData) {
    startTransition(async () => {
      const result = await updateProduct(productId, formData);
      if (result.error) {
        setError(result.error);
        setSaved(false);
      } else {
        setError(null);
        setSaved(true);
        setTimeout(() => setSaved(false), 2000);
      }
    });
  }

  return (
    <form action={handleSubmit} className="space-y-6">
      {children}

      {error && <p className="text-red-400 text-sm">{error}</p>}

      <div className="flex items-center gap-4">
        <button type="submit" disabled={isPending} className="gv-btn-primary disabled:opacity-50">
          {isPending ? "Saving..." : saved ? "Saved ✓" : "Save Changes"}
        </button>
        <button
          type="button"
          onClick={() => {
            if (confirm("Delete this product permanently? This can't be undone.")) {
              startTransition(() => deleteProduct(productId));
            }
          }}
          className="text-red-400 text-sm hover:text-red-300"
        >
          Delete Product
        </button>
      </div>
    </form>
  );
}

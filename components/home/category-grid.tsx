import Link from "next/link";
import type { Category } from "@/lib/types";

export function CategoryGrid({ categories }: { categories: Category[] }) {
  return (
    <section className="max-w-6xl mx-auto px-4 md:px-6 py-12">
      <h2 className="gv-section-heading mb-6">Shop by Category</h2>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {categories.map((cat) => (
          <Link
            key={cat.id}
            href={`/shop?category=${cat.slug}`}
            className="gv-card text-center py-8 hover:border-emerald transition-colors"
          >
            <p className="text-white font-medium">{cat.name}</p>
          </Link>
        ))}
      </div>
    </section>
  );
}

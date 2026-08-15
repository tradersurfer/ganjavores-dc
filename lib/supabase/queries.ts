import { createClient } from "@/lib/supabase/server";
import type { Product, Brand, Category } from "@/lib/types";

/**
 * All product reads go through here so the "shape a full Product object"
 * logic (joins + nesting) lives in one place instead of being copy-pasted
 * across the shop grid, PDP, and admin.
 */

const PRODUCT_SELECT = `
  id, slug, name, strain_type, cross_genetics, palate,
  short_description, description, thc_percent, cbd_percent,
  is_ganjavores_exclusive, is_featured, is_lab_tested, is_active,
  inventory_count, meta_title, meta_description,
  brand:brands(id, name, slug, is_house_brand, description, logo_url, website_url),
  category:categories(id, name, slug, description, display_order, icon_url),
  variants:product_variants(id, product_id, label, price, compare_at_price, sku, inventory_count, is_default, display_order),
  images:product_images(id, product_id, url, alt_text, display_order),
  terpenes:product_terpenes(id, name, percent, info_text, display_order),
  cannabinoids:product_cannabinoids(id, name, percent, info_text, display_order),
  reviews(id, author_name, rating, title, body, created_at, is_approved)
`;

export type ShopFilters = {
  category?: string; // slug
  brand?: string; // slug
  strainType?: string;
  exclusiveOnly?: boolean;
  minPrice?: number;
  maxPrice?: number;
  minThc?: number;
  maxThc?: number;
  search?: string;
  sort?: "featured" | "price-asc" | "price-desc" | "thc-desc" | "newest";
  page?: number;
  perPage?: number;
};

function sortProduct(p: any): Product {
  return {
    ...p,
    variants: (p.variants ?? []).sort(
      (a: any, b: any) => a.display_order - b.display_order
    ),
    images: (p.images ?? []).sort(
      (a: any, b: any) => a.display_order - b.display_order
    ),
    terpenes: (p.terpenes ?? []).sort(
      (a: any, b: any) => a.display_order - b.display_order
    ),
    cannabinoids: (p.cannabinoids ?? []).sort(
      (a: any, b: any) => a.display_order - b.display_order
    ),
    reviews: (p.reviews ?? []).filter((r: any) => r.is_approved),
  };
}

/**
 * Fetches the shop grid page. Filtering on variant price happens in JS
 * after the query since Supabase can't easily filter a parent row by an
 * aggregate over a nested relation in one call — fine at this catalog
 * size, revisit with a Postgres function/view if the catalog gets large.
 */
export async function getShopProducts(filters: ShopFilters = {}) {
  const supabase = await createClient();
  const perPage = filters.perPage ?? 24;
  const page = filters.page ?? 1;

  let query = supabase.from("products").select(PRODUCT_SELECT).eq("is_active", true);

  if (filters.category) {
    query = query.eq("category.slug", filters.category);
  }
  if (filters.strainType) {
    query = query.eq("strain_type", filters.strainType);
  }
  if (filters.exclusiveOnly) {
    query = query.eq("is_ganjavores_exclusive", true);
  }
  if (filters.minThc !== undefined) {
    query = query.gte("thc_percent", filters.minThc);
  }
  if (filters.maxThc !== undefined) {
    query = query.lte("thc_percent", filters.maxThc);
  }
  if (filters.search) {
    query = query.or(
      `name.ilike.%${filters.search}%,short_description.ilike.%${filters.search}%,description.ilike.%${filters.search}%`
    );
  }

  const { data, error } = await query;
  if (error) throw error;

  let products = (data ?? []).map(sortProduct);

  // brand slug filter (nested relation filters are unreliable pre-join in supabase-js, so filter client-side)
  if (filters.brand) {
    products = products.filter((p) => p.brand?.slug === filters.brand);
  }
  if (filters.category) {
    products = products.filter((p) => p.category?.slug === filters.category);
  }

  // price range — evaluated against each product's cheapest variant
  if (filters.minPrice !== undefined || filters.maxPrice !== undefined) {
    products = products.filter((p) => {
      const prices = p.variants.map((v) => v.price);
      if (!prices.length) return false;
      const min = Math.min(...prices);
      if (filters.minPrice !== undefined && min < filters.minPrice) return false;
      if (filters.maxPrice !== undefined && min > filters.maxPrice) return false;
      return true;
    });
  }

  switch (filters.sort) {
    case "price-asc":
      products.sort(
        (a, b) =>
          Math.min(...a.variants.map((v) => v.price), Infinity) -
          Math.min(...b.variants.map((v) => v.price), Infinity)
      );
      break;
    case "price-desc":
      products.sort(
        (a, b) =>
          Math.min(...b.variants.map((v) => v.price), Infinity) -
          Math.min(...a.variants.map((v) => v.price), Infinity)
      );
      break;
    case "thc-desc":
      products.sort((a, b) => (b.thc_percent ?? 0) - (a.thc_percent ?? 0));
      break;
    case "newest":
      // relies on created_at already being default-ordered by Postgres insert order
      break;
    case "featured":
    default:
      products.sort((a, b) => Number(b.is_featured) - Number(a.is_featured));
      break;
  }

  const total = products.length;
  const start = (page - 1) * perPage;
  const paged = products.slice(start, start + perPage);

  return { products: paged, total, page, perPage };
}

export async function getProductBySlug(slug: string): Promise<Product | null> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("products")
    .select(PRODUCT_SELECT)
    .eq("slug", slug)
    .eq("is_active", true)
    .single();

  if (error || !data) return null;

  const product = sortProduct(data);

  // related products: manual curation first, fall back to same category
  const { data: relatedRows } = await supabase
    .from("related_products")
    .select("related_product_id, display_order")
    .eq("product_id", product.id)
    .order("display_order");

  let related: Product[] = [];
  if (relatedRows && relatedRows.length > 0) {
    const ids = relatedRows.map((r) => r.related_product_id);
    const { data: relatedProducts } = await supabase
      .from("products")
      .select(PRODUCT_SELECT)
      .in("id", ids)
      .eq("is_active", true);
    related = (relatedProducts ?? []).map(sortProduct);
  } else if (product.category) {
    const { data: sameCategory } = await supabase
      .from("products")
      .select(PRODUCT_SELECT)
      .eq("category_id", product.category.id)
      .eq("is_active", true)
      .neq("id", product.id)
      .limit(8);
    related = (sameCategory ?? []).map(sortProduct);
  }

  return { ...product, related_products: related };
}

export async function getAllBrands(): Promise<Brand[]> {
  const supabase = await createClient();
  const { data } = await supabase.from("brands").select("*").order("name");
  return data ?? [];
}

export async function getAllCategories(): Promise<Category[]> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("categories")
    .select("*")
    .order("display_order");
  return data ?? [];
}

export async function getPriceBounds() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("product_variants")
    .select("price")
    .order("price");
  const prices = (data ?? []).map((d) => d.price);
  return {
    min: prices.length ? Math.min(...prices) : 0,
    max: prices.length ? Math.max(...prices) : 200,
  };
}

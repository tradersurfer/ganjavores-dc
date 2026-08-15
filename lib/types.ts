export type Brand = {
  id: string;
  name: string;
  slug: string;
  is_house_brand: boolean;
  description: string | null;
  logo_url: string | null;
  website_url: string | null;
};

export type Category = {
  id: string;
  name: string;
  slug: string;
  description: string | null;
  display_order: number;
  icon_url: string | null;
};

export type ProductVariant = {
  id: string;
  product_id: string;
  label: string;
  price: number;
  compare_at_price: number | null;
  sku: string | null;
  inventory_count: number;
  is_default: boolean;
  display_order: number;
};

export type ProductImage = {
  id: string;
  product_id: string;
  url: string;
  alt_text: string | null;
  display_order: number;
};

export type ProductTerpene = {
  id: string;
  name: string;
  percent: number | null;
  info_text: string | null;
  display_order: number;
};

export type ProductCannabinoid = {
  id: string;
  name: string;
  percent: number | null;
  info_text: string | null;
  display_order: number;
};

export type Review = {
  id: string;
  author_name: string;
  rating: number;
  title: string | null;
  body: string;
  created_at: string;
};

export type StrainType =
  | "Indica"
  | "Sativa"
  | "Hybrid"
  | "Indica Hybrid"
  | "Sativa Hybrid"
  | "N/A";

export type Product = {
  id: string;
  slug: string;
  name: string;
  brand: Brand | null;
  category: Category | null;
  strain_type: StrainType | null;
  cross_genetics: string | null;
  palate: string | null;
  short_description: string | null;
  description: string;
  thc_percent: number | null;
  cbd_percent: number | null;
  is_ganjavores_exclusive: boolean;
  is_featured: boolean;
  is_lab_tested: boolean;
  is_active: boolean;
  inventory_count: number;
  meta_title: string | null;
  meta_description: string | null;
  variants: ProductVariant[];
  images: ProductImage[];
  terpenes: ProductTerpene[];
  cannabinoids: ProductCannabinoid[];
  reviews: Review[];
  related_products?: Product[];
};

export type FulfillmentType = "delivery" | "pickup";

export type OrderStatus =
  | "received"
  | "confirmed"
  | "out_for_delivery"
  | "ready_for_pickup"
  | "completed"
  | "cancelled";

export type CartLine = {
  product_id: string;
  variant_id: string;
  product_name: string;
  variant_label: string;
  unit_price: number;
  quantity: number;
  image_url: string | null;
};

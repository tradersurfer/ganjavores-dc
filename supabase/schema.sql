-- =====================================================================
-- GANJAVORES DC — SUPABASE SCHEMA
-- Multi-vendor cannabis delivery/pickup catalog (no online payments)
-- =====================================================================

create extension if not exists "uuid-ossp";

-- ---------------------------------------------------------------------
-- BRANDS
-- Every product belongs to a brand — could be the house brand
-- ("Ganjavores by Lee Farms") or a third-party supplier
-- (Rise, Cookies, Royal Smoke, District Cannabis, The DC Dispensary,
-- Grow West, etc). This mirrors the "About the Brand" section pattern
-- seen on District Cannabis PDPs.
-- ---------------------------------------------------------------------
create table brands (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique,               -- e.g. "Rise Dispensary", "Ganjavores by Lee Farms"
  slug text not null unique,
  is_house_brand boolean not null default false, -- true only for Ganjavores' own line
  description text,
  logo_url text,
  website_url text,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- CATEGORIES
-- Flower, Vapes, Edibles, Pre-Rolls, Concentrates, Ganjavores Exclusive,
-- Topicals, Tinctures, Accessories (grinders, papers, batteries, etc.)
-- ---------------------------------------------------------------------
create table categories (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique,
  slug text not null unique,
  description text,
  display_order int not null default 0,
  icon_url text,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- PRODUCTS
-- ---------------------------------------------------------------------
create table products (
  id uuid primary key default uuid_generate_v4(),
  slug text not null unique,
  name text not null,
  brand_id uuid references brands(id) on delete set null,
  category_id uuid references categories(id) on delete set null,

  -- classification
  strain_type text check (strain_type in ('Indica','Sativa','Hybrid','Indica Hybrid','Sativa Hybrid','N/A')),
  cross_genetics text,               -- e.g. "Wedding Cake x Gelato 33 - Seedjunky Genetics"
  palate text,                       -- e.g. "grapes, sweet kerosene, and cognac"

  -- copy
  short_description text,            -- used in cards / meta description
  description text not null,         -- full PDP body copy

  -- potency (top-level, matches card + hero display)
  thc_percent numeric(5,2),
  cbd_percent numeric(5,2),

  -- flags
  is_ganjavores_exclusive boolean not null default false,
  is_featured boolean not null default false,
  is_lab_tested boolean not null default true,
  is_active boolean not null default true,   -- soft hide instead of delete

  -- inventory (owner-editable in admin without touching code)
  inventory_count int not null default 0,
  low_stock_threshold int not null default 5,

  -- SEO
  meta_title text,
  meta_description text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index idx_products_category on products(category_id);
create index idx_products_brand on products(brand_id);
create index idx_products_active on products(is_active);
create index idx_products_featured on products(is_featured);
create index idx_products_exclusive on products(is_ganjavores_exclusive);

-- ---------------------------------------------------------------------
-- PRODUCT VARIANTS (weight/size + price)
-- Handles "1/8oz $35.00", "3.5g $45.50", "2-pack", etc. per District's
-- pattern of a weight selector + price on the PDP.
-- ---------------------------------------------------------------------
create table product_variants (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid not null references products(id) on delete cascade,
  label text not null,               -- "1/8oz", "1g", "3.5g", "2-pack"
  price numeric(8,2) not null,
  compare_at_price numeric(8,2),     -- optional strike-through / sale price
  sku text,
  inventory_count int not null default 0,
  is_default boolean not null default false,
  display_order int not null default 0,
  created_at timestamptz not null default now()
);

create index idx_variants_product on product_variants(product_id);

-- ---------------------------------------------------------------------
-- PRODUCT IMAGES (multiple images per product, ordered)
-- ---------------------------------------------------------------------
create table product_images (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid not null references products(id) on delete cascade,
  url text not null,
  alt_text text,
  display_order int not null default 0,
  created_at timestamptz not null default now()
);

create index idx_images_product on product_images(product_id);

-- ---------------------------------------------------------------------
-- TERPENES — per-product terpene panel (District-style depth)
-- ---------------------------------------------------------------------
create table product_terpenes (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid not null references products(id) on delete cascade,
  name text not null,                -- "Alpha Pinene", "Beta Caryophyllene", etc.
  percent numeric(5,2),
  info_text text,                    -- optional tooltip copy
  display_order int not null default 0
);

create index idx_terpenes_product on product_terpenes(product_id);

-- ---------------------------------------------------------------------
-- CANNABINOIDS — THC-D9, THCA, CBGA, CBD, etc. per product
-- ---------------------------------------------------------------------
create table product_cannabinoids (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid not null references products(id) on delete cascade,
  name text not null,                -- "THC-D9", "THCA", "CBGA"
  percent numeric(5,2),
  info_text text,
  display_order int not null default 0
);

create index idx_cannabinoids_product on product_cannabinoids(product_id);

-- ---------------------------------------------------------------------
-- REVIEWS
-- ---------------------------------------------------------------------
create table reviews (
  id uuid primary key default uuid_generate_v4(),
  product_id uuid not null references products(id) on delete cascade,
  author_name text not null,
  rating int not null check (rating between 1 and 5),
  title text,
  body text not null,
  is_approved boolean not null default false,  -- admin moderates before it goes live
  created_at timestamptz not null default now()
);

create index idx_reviews_product on reviews(product_id);

-- ---------------------------------------------------------------------
-- RELATED PRODUCTS (manual curation, falls back to same-category query
-- in app code if no rows exist for a product)
-- ---------------------------------------------------------------------
create table related_products (
  product_id uuid not null references products(id) on delete cascade,
  related_product_id uuid not null references products(id) on delete cascade,
  display_order int not null default 0,
  primary key (product_id, related_product_id)
);

-- ---------------------------------------------------------------------
-- ANNOUNCEMENTS (homepage banners / promo cards / specials page)
-- Covers hero banners, mobile-only banners, and the specials grid
-- (e.g. "15% Off All RSO", "3 for $45 Pre-Rolls")
-- ---------------------------------------------------------------------
create table announcements (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  subtitle text,
  image_url text,
  mobile_image_url text,             -- separate crop for mobile banner slot
  link_url text,
  placement text not null check (placement in ('homepage_hero','homepage_secondary','specials_page','sitewide_banner')),
  display_order int not null default 0,
  starts_at timestamptz,
  ends_at timestamptz,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create index idx_announcements_placement on announcements(placement, is_active);

-- ---------------------------------------------------------------------
-- ORDERS — no payment processing, pay on delivery/pickup only
-- ---------------------------------------------------------------------
create table orders (
  id uuid primary key default uuid_generate_v4(),
  order_number text not null unique,     -- human-friendly, e.g. GV-10234

  -- customer info (no accounts required to order)
  customer_name text not null,
  customer_phone text not null,
  customer_email text,

  -- fulfillment
  fulfillment_type text not null check (fulfillment_type in ('delivery','pickup')),
  delivery_address text,             -- required if fulfillment_type = delivery
  delivery_city text,
  delivery_zip text,
  preferred_window text,             -- "12pm-2pm", "ASAP", etc.
  order_notes text,

  -- status
  status text not null default 'received' check (
    status in ('received','confirmed','out_for_delivery','ready_for_pickup','completed','cancelled')
  ),

  subtotal numeric(10,2) not null default 0,
  -- no tax/payment fields — cash/card collected in person

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index idx_orders_status on orders(status);
create index idx_orders_created on orders(created_at desc);

-- ---------------------------------------------------------------------
-- ORDER ITEMS
-- ---------------------------------------------------------------------
create table order_items (
  id uuid primary key default uuid_generate_v4(),
  order_id uuid not null references orders(id) on delete cascade,
  product_id uuid references products(id) on delete set null,
  variant_id uuid references product_variants(id) on delete set null,
  product_name_snapshot text not null,   -- freeze name/price at time of order
  variant_label_snapshot text,
  unit_price numeric(8,2) not null,
  quantity int not null default 1,
  line_total numeric(10,2) not null
);

create index idx_order_items_order on order_items(order_id);

-- ---------------------------------------------------------------------
-- ADMIN USERS
-- Auth handled by Supabase Auth (auth.users). This table adds role/
-- profile info for anyone with dashboard access.
-- ---------------------------------------------------------------------
create table admin_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'staff' check (role in ('owner','manager','staff')),
  created_at timestamptz not null default now()
);

-- =====================================================================
-- ROW LEVEL SECURITY
-- Public storefront: read-only on catalog tables, active rows only.
-- Orders: public can INSERT (checkout) but not SELECT/UPDATE.
-- Admin tables: authenticated admins only, gated by admin_profiles.
-- =====================================================================

alter table brands enable row level security;
alter table categories enable row level security;
alter table products enable row level security;
alter table product_variants enable row level security;
alter table product_images enable row level security;
alter table product_terpenes enable row level security;
alter table product_cannabinoids enable row level security;
alter table reviews enable row level security;
alter table related_products enable row level security;
alter table announcements enable row level security;
alter table orders enable row level security;
alter table order_items enable row level security;
alter table admin_profiles enable row level security;

-- Public read policies (storefront)
create policy "public read brands" on brands for select using (true);
create policy "public read categories" on categories for select using (true);
create policy "public read active products" on products for select using (is_active = true);
create policy "public read variants" on product_variants for select using (true);
create policy "public read images" on product_images for select using (true);
create policy "public read terpenes" on product_terpenes for select using (true);
create policy "public read cannabinoids" on product_cannabinoids for select using (true);
create policy "public read approved reviews" on reviews for select using (is_approved = true);
create policy "public read related" on related_products for select using (true);
create policy "public read active announcements" on announcements for select using (
  is_active = true and (starts_at is null or starts_at <= now()) and (ends_at is null or ends_at >= now())
);

-- Checkout: anyone can create an order + order items, nobody can read/list them back
create policy "public can place orders" on orders for insert with check (true);
create policy "public can add order items" on order_items for insert with check (true);

-- Anyone can submit a review; it just won't show until an admin approves it
create policy "public can submit reviews" on reviews for insert with check (true);

-- Admin full access (requires a matching admin_profiles row)
create policy "admin full access brands" on brands for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access categories" on categories for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access products" on products for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access variants" on product_variants for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access images" on product_images for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access terpenes" on product_terpenes for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access cannabinoids" on product_cannabinoids for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access reviews" on reviews for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access related" on related_products for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access announcements" on announcements for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access orders" on orders for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin full access order_items" on order_items for all using (
  exists (select 1 from admin_profiles where id = auth.uid())
);
create policy "admin can read own profile" on admin_profiles for select using (id = auth.uid());

-- =====================================================================
-- SEED: categories + house brand (safe to run once)
-- =====================================================================
insert into categories (name, slug, display_order) values
  ('Flower', 'flower', 1),
  ('Pre-Rolls', 'pre-rolls', 2),
  ('Vapes', 'vapes', 3),
  ('Edibles', 'edibles', 4),
  ('Concentrates', 'concentrates', 5),
  ('Ganjavores Exclusive', 'ganjavores-exclusive', 6),
  ('Accessories', 'accessories', 7)
on conflict (slug) do nothing;

insert into brands (name, slug, is_house_brand) values
  ('Ganjavores by Lee Farms', 'ganjavores-by-lee-farms', true),
  ('Rise Dispensary', 'rise-dispensary', false),
  ('Cookies Dispensary', 'cookies-dispensary', false),
  ('Royal Smoke Dispensary', 'royal-smoke-dispensary', false),
  ('District Cannabis', 'district-cannabis', false),
  ('The DC Dispensary', 'the-dc-dispensary', false),
  ('Grow West', 'grow-west', false)
on conflict (slug) do nothing;

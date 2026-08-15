-- =====================================================================
-- GANJAVORES DC — PLACEHOLDER PRODUCT SEED DATA
-- Every price / THC% / variant here is a DRAFT for you to edit.
-- Copy is written in Ganjavores voice (playful, DMV-local, confident) —
-- NOT copied from District Cannabis or the old Winston-Salem THCA site.
-- Search 'EDIT ME' comments for anything that's a placeholder guess.
-- =====================================================================

-- Additional product-manufacturer brands (distinct from the wholesale
-- supplier list already seeded in schema.sql — see chat note on this).
insert into brands (name, slug, is_house_brand) values ('Jeeter', 'jeeter', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Muha Meds', 'muha-meds', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Fryd Extracts', 'fryd-extracts', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Runtz', 'runtz', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Backpackboyz', 'backpackboyz', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Tyson 2.0', 'tyson-2-0', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('RAW', 'raw', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Cali Crusher', 'cali-crusher', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Lookah', 'lookah', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Warheads', 'warheads', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Nerds', 'nerds', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Jolly Rancher', 'jolly-rancher', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Gas Heads', 'gas-heads', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Ruby Gems', 'ruby-gems', False) on conflict (slug) do nothing;

-- ---------------------------------------------------------------
-- Money Kush
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'money-kush',
    'Money Kush',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Indica',
    NULL,
    'earthy diesel with a sweet gas finish',
    'House-grown indica with a heavy hand and a heavier name.',
    'Money Kush is the flagship of the Ganjavores Exclusive line — grown to our own spec, cured slow, and priced like we actually want you to come back next week. Dense, frosty nugs with a loud gas-forward nose and a body-heavy indica finish. If you know, you know. If you don''t yet, you will.',
    24.5,
    True,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Money Kush | Ganjavores DC',
    'House-grown indica with a heavy hand and a heavier name.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 30.00, true),
  ((select id from new_product), '7g', 55.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'money-kush'), '/products/flower/1.png', 'Money Kush', 0);

-- ---------------------------------------------------------------
-- Purple Runtz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'purple-runtz',
    'Purple Runtz',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'candy grape and creamy sweetness',
    'A DMV favorite in-house cut — sweet, purple, and gone fast.',
    'Our house take on the Runtz lineage — vivid purple hues, a candy-sweet nose, and a smooth, balanced hybrid high that doesn''t knock you sideways. Consistently one of our fastest sellers at this price point, for a reason.',
    25.8,
    True,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Purple Runtz | Ganjavores DC',
    'A DMV favorite in-house cut — sweet, purple, and gone fast.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 30.00, true),
  ((select id from new_product), '7g', 55.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'purple-runtz'), '/products/flower/2.png', 'Purple Runtz', 0);

-- ---------------------------------------------------------------
-- Cake Batter
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'cake-batter',
    'Cake Batter',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    NULL,
    'vanilla cake and gassy undertones',
    'Dessert nose, couch-lock finish — house-priced.',
    'Cake Batter brings a genuinely bakery-sweet smell to the table, then backs it up with a heavier indica-leaning effect once it settles in. A go-to for evening wind-down without needing to reach for the top-shelf jars.',
    23.2,
    True,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Cake Batter | Ganjavores DC',
    'Dessert nose, couch-lock finish — house-priced.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 30.00, true),
  ((select id from new_product), '7g', 55.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'cake-batter'), '/products/flower/3.png', 'Cake Batter', 0);

-- ---------------------------------------------------------------
-- Sour Diesel
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'sour-diesel',
    'Sour Diesel',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Sativa',
    NULL,
    'sharp diesel and citrus',
    'Classic DC-area daytime sativa, house-grown.',
    'A DMV staple for a reason — sharp fuel funk up front, energizing head-first effects that make it a solid pick for getting things done. Our house cut keeps the classic profile intact at a price that doesn''t punish loyalty.',
    22.0,
    True,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Sour Diesel | Ganjavores DC',
    'Classic DC-area daytime sativa, house-grown.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 28.00, true),
  ((select id from new_product), '7g', 50.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'sour-diesel'), '/products/flower/4.png', 'Sour Diesel', 0);

-- ---------------------------------------------------------------
-- Gelato Cake
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gelato-cake',
    'Gelato Cake',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    NULL,
    'sweet cream and light citrus',
    'A smooth, dessert-leaning hybrid — house price, top-shelf feel.',
    'Gelato genetics meet a cake-forward finish. Smooth smoke, sweet cream nose, and a relaxed-but-clear hybrid effect that works whether you''re winding down or just easing into the evening.',
    24.9,
    True,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Gelato Cake | Ganjavores DC',
    'A smooth, dessert-leaning hybrid — house price, top-shelf feel.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 32.00, true),
  ((select id from new_product), '7g', 58.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'gelato-cake'), '/products/flower/5.png', 'Gelato Cake', 0);

-- ---------------------------------------------------------------
-- Lemon Cherry Gelato
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'lemon-cherry-gelato',
    'Lemon Cherry Gelato',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'tart cherry and citrus zest',
    'Bright, loud, and one of our most-requested house cuts.',
    'Loud citrus-cherry nose off the jar, balanced hybrid effects that lean slightly uplifting. This one moves fast every batch — grab it while it''s in stock.',
    26.3,
    True,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Lemon Cherry Gelato | Ganjavores DC',
    'Bright, loud, and one of our most-requested house cuts.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 32.00, true),
  ((select id from new_product), '7g', 58.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'lemon-cherry-gelato'), '/products/flower/6.png', 'Lemon Cherry Gelato', 0);

-- ---------------------------------------------------------------
-- OG Kush
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'og-kush',
    'OG Kush',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'pine, earth, and classic gas',
    'The strain that started it all — our version, our price.',
    'No frills, no gimmicks — just a well-grown, classic OG profile. Piney, earthy, gas-forward, and balanced enough for pretty much any time of day. A house-brand shelf staple.',
    21.5,
    True,
    False,
    25, -- EDIT ME: placeholder inventory count
    'OG Kush | Ganjavores DC',
    'The strain that started it all — our version, our price.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 28.00, true),
  ((select id from new_product), '7g', 50.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'og-kush'), '/products/flower/7.png', 'OG Kush', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Gelato
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-gelato',
    'Jeeter Juice Live Resin — Gelato',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'sweet cream and dessert funk',
    'Fresh-squeezed live resin disposable, Gelato flavor.',
    'Jeeter Juice runs their live resin fresh-squeezed with no additives, single-source extraction — you''re tasting the actual plant, not flavoring. Gelato brings the dessert-forward sweetness the strain''s known for, straight through a disposable straw-style pen.',
    85.0,
    False,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Gelato | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Gelato flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-gelato'), '/products/vapes/jeeter-cart-gelato.png', 'Jeeter Juice Live Resin — Gelato', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Honeydew
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-honeydew',
    'Jeeter Juice Live Resin — Honeydew',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'sweet melon, light and clean',
    'Fresh-squeezed live resin disposable, Honeydew flavor.',
    'Bright melon sweetness up front with a clean sativa lift — one of Jeeter''s lighter, more daytime-friendly live resin flavors. No additives, single-source, straight fresh-squeezed.',
    84.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Honeydew | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Honeydew flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-honeydew'), '/products/vapes/jeeter-cart-honeydew.png', 'Jeeter Juice Live Resin — Honeydew', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Maui Wowie
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-maui-wowie',
    'Jeeter Juice Live Resin — Maui Wowie',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'tropical pineapple and citrus',
    'Fresh-squeezed live resin disposable, Maui Wowie flavor.',
    'Classic tropical Maui Wowie profile — pineapple-citrus sweetness with an energetic, sociable sativa effect. Solid pick for daytime or a get-out-of-the-house kind of high.',
    83.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Maui Wowie | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Maui Wowie flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-maui-wowie'), '/products/vapes/jeeter-cart-maui-wowie.png', 'Jeeter Juice Live Resin — Maui Wowie', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Peach Ringz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-peach-ringz',
    'Jeeter Juice Live Resin — Peach Ringz',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'candied peach, sweet and tart',
    'Fresh-squeezed live resin disposable, Peach Ringz flavor.',
    'Tastes like the candy, hits like a well-balanced hybrid. Peach Ringz is one of the sweeter Jeeter Juice flavors in rotation — a favorite with anyone who wants flavor first.',
    84.5,
    False,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Peach Ringz | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Peach Ringz flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-peach-ringz'), '/products/vapes/jeeter-cart-peach-ringz.png', 'Jeeter Juice Live Resin — Peach Ringz', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Watermelon Zkittlez
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-watermelon-zkittlez',
    'Jeeter Juice Live Resin — Watermelon Zkittlez',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'juicy watermelon candy',
    'Fresh-squeezed live resin disposable, Watermelon Zkittlez flavor.',
    'Watermelon-candy sweetness on the exhale with a smooth, balanced Zkittlez-lineage body effect. One of the more sessionable flavors in the Jeeter Juice lineup.',
    85.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Watermelon Zkittlez | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Watermelon Zkittlez flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-watermelon-zkittlez'), '/products/vapes/jeeter-cart-watermelon-zkittlez.png', 'Jeeter Juice Live Resin — Watermelon Zkittlez', 0);

-- ---------------------------------------------------------------
-- Muha Meds Disposable — Skywalker OG
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'muha-meds-disposable-skywalker-og',
    'Muha Meds Disposable — Skywalker OG',
    (select id from brands where slug = 'muha-meds'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'pine, earth, heavy gas',
    'Full gram disposable, Skywalker OG.',
    'Deep-relaxation indica in a disposable format — pine and earth up front, heavy gas underneath. Built for winding all the way down.',
    82.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Muha Meds Disposable — Skywalker OG | Ganjavores DC',
    'Full gram disposable, Skywalker OG.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 35.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'muha-meds-disposable-skywalker-og'), '/products/vapes/muha-meds-disposable-vape-skywalker-og.png', 'Muha Meds Disposable — Skywalker OG', 0);

-- ---------------------------------------------------------------
-- Muha Meds Disposable — Super Sour Diesel
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'muha-meds-disposable-super-sour-diesel',
    'Muha Meds Disposable — Super Sour Diesel',
    (select id from brands where slug = 'muha-meds'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'sharp diesel, citrus edge',
    'Full gram disposable, Super Sour Diesel.',
    'Sharp, fuel-forward sativa in disposable form. Fast-acting, head-first energy — good for mornings that need a push.',
    81.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Muha Meds Disposable — Super Sour Diesel | Ganjavores DC',
    'Full gram disposable, Super Sour Diesel.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 35.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'muha-meds-disposable-super-sour-diesel'), '/products/vapes/muha-meds-disposable-vape-super-sour-diesel.png', 'Muha Meds Disposable — Super Sour Diesel', 0);

-- ---------------------------------------------------------------
-- Tyson 2.0 Disposable — Dole Whip
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'tyson-2-0-disposable-dole-whip',
    'Tyson 2.0 Disposable — Dole Whip',
    (select id from brands where slug = 'tyson-2-0'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'pineapple, coconut, creamy sweetness',
    'Tyson-brand disposable pod, Dole Whip flavor.',
    'Tropical and creamy — pineapple-coconut sweetness in a smooth, balanced hybrid pen. One of Tyson 2.0''s most popular dessert-leaning flavors.',
    80.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Tyson 2.0 Disposable — Dole Whip | Ganjavores DC',
    'Tyson-brand disposable pod, Dole Whip flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 38.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'tyson-2-0-disposable-dole-whip'), '/products/vapes/tyson-pod-disposable-vape-dole-whip.png', 'Tyson 2.0 Disposable — Dole Whip', 0);

-- ---------------------------------------------------------------
-- Tyson 2.0 Disposable — Passion Fruit
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'tyson-2-0-disposable-passion-fruit',
    'Tyson 2.0 Disposable — Passion Fruit',
    (select id from brands where slug = 'tyson-2-0'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'tart tropical passion fruit',
    'Tyson-brand disposable pod, Passion Fruit flavor.',
    'Tart, tropical, and bright — a sativa-leaning disposable that''s easy to reach for during the day. Clean flavor, no guesswork.',
    79.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Tyson 2.0 Disposable — Passion Fruit | Ganjavores DC',
    'Tyson-brand disposable pod, Passion Fruit flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 38.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'tyson-2-0-disposable-passion-fruit'), '/products/vapes/tyson-pod-disposable-vape-passion-fruit.png', 'Tyson 2.0 Disposable — Passion Fruit', 0);

-- ---------------------------------------------------------------
-- Backpackboyz Disposable — Lemonz & Cherriez
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'backpackboyz-disposable-lemonz-cherriez',
    'Backpackboyz Disposable — Lemonz & Cherriez',
    (select id from brands where slug = 'backpackboyz'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'tart lemon and dark cherry',
    'Backpackboyz disposable, Lemonz & Cherriez flavor.',
    'A tart-sweet flavor combo layered over a smooth, balanced hybrid effect. Backpackboyz built a following on flavor-first genetics, and this one shows why.',
    83.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Backpackboyz Disposable — Lemonz & Cherriez | Ganjavores DC',
    'Backpackboyz disposable, Lemonz & Cherriez flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 38.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'backpackboyz-disposable-lemonz-cherriez'), '/products/vapes/backpackboyz-disposable-vape-lemonz-and-cherriez.png', 'Backpackboyz Disposable — Lemonz & Cherriez', 0);

-- ---------------------------------------------------------------
-- Fryd Extracts Disposable — Code Red
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'fryd-extracts-disposable-code-red',
    'Fryd Extracts Disposable — Code Red',
    (select id from brands where slug = 'fryd-extracts'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'cinnamon candy heat',
    'Fryd Extracts disposable, Code Red flavor.',
    'Spicy-sweet cinnamon-candy profile with a balanced hybrid body. Fryd''s dessert/candy-inspired lineup keeps flavor as the whole point.',
    84.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Fryd Extracts Disposable — Code Red | Ganjavores DC',
    'Fryd Extracts disposable, Code Red flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 36.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'fryd-extracts-disposable-code-red'), '/products/vapes/code-red-fryd-extracts-dispo.png', 'Fryd Extracts Disposable — Code Red', 0);

-- ---------------------------------------------------------------
-- Fryd Extracts Disposable — Blue Gummy Shark
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'fryd-extracts-disposable-blue-gummy-shark',
    'Fryd Extracts Disposable — Blue Gummy Shark',
    (select id from brands where slug = 'fryd-extracts'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'blue raspberry gummy candy',
    'Fryd Extracts disposable, Blue Gummy Shark flavor.',
    'Straight blue-raspberry candy flavor in disposable form — sweet, smooth, and built for flavor chasers over anything else.',
    83.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Fryd Extracts Disposable — Blue Gummy Shark | Ganjavores DC',
    'Fryd Extracts disposable, Blue Gummy Shark flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 36.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'fryd-extracts-disposable-blue-gummy-shark'), '/products/vapes/fryd-extracts-dispo-blue-gummy-shark.png', 'Fryd Extracts Disposable — Blue Gummy Shark', 0);

-- ---------------------------------------------------------------
-- Fryd Extracts Disposable — Lemon Heads
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'fryd-extracts-disposable-lemon-heads',
    'Fryd Extracts Disposable — Lemon Heads',
    (select id from brands where slug = 'fryd-extracts'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'sour lemon candy',
    'Fryd Extracts disposable, Lemon Heads flavor.',
    'Sour lemon candy up front, sativa-leaning lift underneath. One of the tarter flavors in the Fryd lineup.',
    82.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Fryd Extracts Disposable — Lemon Heads | Ganjavores DC',
    'Fryd Extracts disposable, Lemon Heads flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 36.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'fryd-extracts-disposable-lemon-heads'), '/products/vapes/fryd-extracts-disposable-lemon-heads.png', 'Fryd Extracts Disposable — Lemon Heads', 0);

-- ---------------------------------------------------------------
-- Fryd Extracts Disposable — Bubble Gum Gelato
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'fryd-extracts-disposable-bubble-gum-gelato',
    'Fryd Extracts Disposable — Bubble Gum Gelato',
    (select id from brands where slug = 'fryd-extracts'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'bubble gum sweetness with Gelato smoothness',
    'Fryd Extracts disposable, Bubble Gum Gelato flavor.',
    'Classic bubble gum candy flavor layered over Gelato''s signature smoothness. A crowd favorite among the flavor-forward Fryd line.',
    84.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Fryd Extracts Disposable — Bubble Gum Gelato | Ganjavores DC',
    'Fryd Extracts disposable, Bubble Gum Gelato flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 36.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'fryd-extracts-disposable-bubble-gum-gelato'), '/products/vapes/bubble-gum-gelato-fryd.png', 'Fryd Extracts Disposable — Bubble Gum Gelato', 0);

-- ---------------------------------------------------------------
-- Fryd Extracts Disposable — Pink Slushiee
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'fryd-extracts-disposable-pink-slushiee',
    'Fryd Extracts Disposable — Pink Slushiee',
    (select id from brands where slug = 'fryd-extracts'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'pink slush candy, icy-sweet',
    'Fryd Extracts disposable, Pink Slushiee flavor.',
    'Icy-sweet pink slush candy flavor with a smooth, balanced hybrid finish. Another strong flavor-first pick from Fryd.',
    83.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Fryd Extracts Disposable — Pink Slushiee | Ganjavores DC',
    'Fryd Extracts disposable, Pink Slushiee flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 36.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'fryd-extracts-disposable-pink-slushiee'), '/products/vapes/pink-slushiee-fryd.png', 'Fryd Extracts Disposable — Pink Slushiee', 0);

-- ---------------------------------------------------------------
-- Runtz Disposable — White Runtz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'runtz-disposable-white-runtz',
    'Runtz Disposable — White Runtz',
    (select id from brands where slug = 'runtz'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'sweet candy, creamy finish',
    'Runtz-brand disposable, White Runtz flavor.',
    'The strain that put Runtz on the map, in disposable form. Sweet, candy-forward, and balanced — a safe pick for anyone new to the brand.',
    82.0,
    False,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Runtz Disposable — White Runtz | Ganjavores DC',
    'Runtz-brand disposable, White Runtz flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 37.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'runtz-disposable-white-runtz'), '/products/vapes/white-runtz-dispo.png', 'Runtz Disposable — White Runtz', 0);

-- ---------------------------------------------------------------
-- Runtz Disposable — Pink Runtz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'runtz-disposable-pink-runtz',
    'Runtz Disposable — Pink Runtz',
    (select id from brands where slug = 'runtz'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'sweet berry candy',
    'Runtz-brand disposable, Pink Runtz flavor.',
    'Berry-forward sweetness with the same smooth, balanced Runtz effect. One of the more requested flavors on the shelf.',
    82.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Runtz Disposable — Pink Runtz | Ganjavores DC',
    'Runtz-brand disposable, Pink Runtz flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 37.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'runtz-disposable-pink-runtz'), '/products/vapes/pink-runtz-dispo.png', 'Runtz Disposable — Pink Runtz', 0);

-- ---------------------------------------------------------------
-- Runtz Disposable — Hawaiian Runtz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'runtz-disposable-hawaiian-runtz',
    'Runtz Disposable — Hawaiian Runtz',
    (select id from brands where slug = 'runtz'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'tropical fruit sweetness',
    'Runtz-brand disposable, Hawaiian Runtz flavor.',
    'Tropical-leaning take on the Runtz line with a brighter, more sativa-forward effect. Good pick for daytime flavor chasers.',
    81.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Runtz Disposable — Hawaiian Runtz | Ganjavores DC',
    'Runtz-brand disposable, Hawaiian Runtz flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 37.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'runtz-disposable-hawaiian-runtz'), '/products/vapes/hawaiian-runtz-dispo.png', 'Runtz Disposable — Hawaiian Runtz', 0);

-- ---------------------------------------------------------------
-- Runtz Disposable — GRuntz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'runtz-disposable-gruntz',
    'Runtz Disposable — GRuntz',
    (select id from brands where slug = 'runtz'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'gassy candy, heavy finish',
    'Runtz-brand disposable, GRuntz flavor.',
    'A gassier, heavier-hitting cross in the Runtz family. Candy-sweet nose with an indica-leaning body effect underneath.',
    83.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Runtz Disposable — GRuntz | Ganjavores DC',
    'Runtz-brand disposable, GRuntz flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 37.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'runtz-disposable-gruntz'), '/products/vapes/gruntz-dispo.png', 'Runtz Disposable — GRuntz', 0);

-- ---------------------------------------------------------------
-- Warheads Sour Gummies
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'warheads-sour-gummies',
    'Warheads Sour Gummies',
    (select id from brands where slug = 'warheads'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'extreme sour candy',
    'The sour candy you grew up on — now infused.',
    'Same brutal sour hit you remember, now with a dose baked in. Not for the faint of heart — sour first, sweet after, effects on a delay so don''t double up early.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Warheads Sour Gummies | Ganjavores DC',
    'The sour candy you grew up on — now infused.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '100mg Pack', 20.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'warheads-sour-gummies'), '/products/edibles/warheads.png', 'Warheads Sour Gummies', 0),
  ((select id from products where slug = 'warheads-sour-gummies'), '/products/edibles/warheads-2.png', 'Warheads Sour Gummies', 1);

-- ---------------------------------------------------------------
-- Nerds Rope
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'nerds-rope',
    'Nerds Rope',
    (select id from brands where slug = 'nerds'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'crunchy candy-coated sweetness',
    'The crunchy candy rope, infused and ready.',
    'Chewy rope center, crunchy candy shell, dosed evenly across the strip so you can actually control your intake — snap off what you need.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Nerds Rope | Ganjavores DC',
    'The crunchy candy rope, infused and ready.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '300mg Rope', 15.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'nerds-rope'), '/products/edibles/nerds-rope-edibles.png', 'Nerds Rope', 0);

-- ---------------------------------------------------------------
-- Nerds — Yellow Pack
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'nerds-yellow-pack',
    'Nerds — Yellow Pack',
    (select id from brands where slug = 'nerds'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'tangy citrus candy',
    'Classic tiny-candy crunch, citrus flavor pack.',
    'Bite-sized, tangy, and easy to dose in small increments — good option if you want more control over how much you''re taking at once.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Nerds — Yellow Pack | Ganjavores DC',
    'Classic tiny-candy crunch, citrus flavor pack.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '200mg Pack', 18.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'nerds-yellow-pack'), '/products/edibles/nerds-yellow-pack.png', 'Nerds — Yellow Pack', 0);

-- ---------------------------------------------------------------
-- Jolly Rancher Gummies
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jolly-rancher-gummies',
    'Jolly Rancher Gummies',
    (select id from brands where slug = 'jolly-rancher'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'assorted fruit candy',
    'The fruit candy classic, infused.',
    'Assorted fruit flavors in the Jolly Rancher gummy format you already know. Reliable, sweet, and consistent dosing per piece.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jolly Rancher Gummies | Ganjavores DC',
    'The fruit candy classic, infused.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '300mg Pack', 20.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jolly-rancher-gummies'), '/products/edibles/jolly-rancher-gummies.png', 'Jolly Rancher Gummies', 0);

-- ---------------------------------------------------------------
-- Sour Skittlez Gummiez
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'sour-skittlez-gummiez',
    'Sour Skittlez Gummiez',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'sour rainbow candy',
    'Rainbow-flavored sour gummies, house-priced.',
    'Sour candy-shell gummies in a mixed-fruit lineup. Easy to split into smaller doses if you''re pacing yourself.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    True,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Sour Skittlez Gummiez | Ganjavores DC',
    'Rainbow-flavored sour gummies, house-priced.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '300mg Pack', 16.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'sour-skittlez-gummiez'), '/products/edibles/sour-skitttlez-gummiez.png', 'Sour Skittlez Gummiez', 0);

-- ---------------------------------------------------------------
-- Gas Heads Edibles
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gas-heads-edibles',
    'Gas Heads Edibles',
    (select id from brands where slug = 'gas-heads'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'strain-specific, stronger profile',
    'Higher-potency edibles for the experienced crowd.',
    'Gas Heads leans into stronger doses for people who already know their tolerance. Not a beginner edible — start low even if you think you know better.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Gas Heads Edibles | Ganjavores DC',
    'Higher-potency edibles for the experienced crowd.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '500mg Pack', 25.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'gas-heads-edibles'), '/products/edibles/gas-heads-edibles.png', 'Gas Heads Edibles', 0);

-- ---------------------------------------------------------------
-- Ruby Gems Edibles
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'ruby-gems-edibles',
    'Ruby Gems Edibles',
    (select id from brands where slug = 'ruby-gems'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'fruit gem candy',
    'Jewel-cut fruit gummies, evenly dosed.',
    'Clean fruit flavor in a gem-shaped gummy, consistent dosing per piece. A solid daily-use option without a heavy candy overload.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Ruby Gems Edibles | Ganjavores DC',
    'Jewel-cut fruit gummies, evenly dosed.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '300mg Pack', 18.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'ruby-gems-edibles'), '/products/edibles/ruby-gems-edibles.png', 'Ruby Gems Edibles', 0);

-- ---------------------------------------------------------------
-- Ruby Gems Edibles — Blue Razz
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'ruby-gems-edibles-blue-razz',
    'Ruby Gems Edibles — Blue Razz',
    (select id from brands where slug = 'ruby-gems'),
    (select id from categories where slug = 'edibles'),
    'N/A',
    NULL,
    'blue raspberry',
    'Ruby Gems in blue raspberry, evenly dosed.',
    'Same even-dose gem gummy format as the original Ruby Gems, in a straight blue raspberry flavor.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Ruby Gems Edibles — Blue Razz | Ganjavores DC',
    'Ruby Gems in blue raspberry, evenly dosed.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '300mg Pack', 18.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'ruby-gems-edibles-blue-razz'), '/products/edibles/ruby-gems-edibles-blue-razz.png', 'Ruby Gems Edibles — Blue Razz', 0);

-- ---------------------------------------------------------------
-- Cali Crusher 4-Piece Grinder
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'cali-crusher-4-piece-grinder',
    'Cali Crusher 4-Piece Grinder',
    (select id from brands where slug = 'cali-crusher'),
    (select id from categories where slug = 'accessories'),
    NULL,
    NULL,
    NULL,
    'The grinder that actually holds up.',
    'Aircraft-grade aluminum, sharp diamond teeth, and a real pollen screen — Cali Crusher built their name on grinders that don''t strip out after a month. If you''re still using the free plastic one that came with something else, this is the upgrade.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Cali Crusher 4-Piece Grinder | Ganjavores DC',
    'The grinder that actually holds up.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '2.5"', 45.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'cali-crusher-4-piece-grinder'), '/products/accessories/cali-crusher-grinder.jpg', 'Cali Crusher 4-Piece Grinder', 0);

-- ---------------------------------------------------------------
-- RAW Pre-Rolled Cones — King Size (3-Pack)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'raw-pre-rolled-cones-king-size-3-pack',
    'RAW Pre-Rolled Cones — King Size (3-Pack)',
    (select id from brands where slug = 'raw'),
    (select id from categories where slug = 'accessories'),
    NULL,
    NULL,
    NULL,
    'Pure hemp, pre-rolled and ready — bring your own flower.',
    'RAW''s natural unbleached hemp paper, pre-rolled into king-size cones so all you have to do is pack, twist, and go. No papers to fumble, no uneven burn.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'RAW Pre-Rolled Cones — King Size (3-Pack) | Ganjavores DC',
    'Pure hemp, pre-rolled and ready — bring your own flower.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), 'King Size 3-Pack', 6.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'raw-pre-rolled-cones-king-size-3-pack'), '/products/accessories/raw-cones-3pack.png', 'RAW Pre-Rolled Cones — King Size (3-Pack)', 0),
  ((select id from products where slug = 'raw-pre-rolled-cones-king-size-3-pack'), '/products/accessories/raw-3pack-tube.webp', 'RAW Pre-Rolled Cones — King Size (3-Pack)', 1);

-- ---------------------------------------------------------------
-- RAW Pressed Bud Wraps — King Size Cones (12-Tube Display)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'raw-pressed-bud-wraps-king-size-cones-12-tube-display',
    'RAW Pressed Bud Wraps — King Size Cones (12-Tube Display)',
    (select id from brands where slug = 'raw'),
    (select id from categories where slug = 'accessories'),
    NULL,
    NULL,
    NULL,
    'Pre-rolled cones, 2 per glass tube, king size.',
    'RAW''s pressed bud wrap cones ship two to a glass storage tube — pack your own, keep the rest sealed and fresh for later. King size, natural fiber, no additives.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'RAW Pressed Bud Wraps — King Size Cones (12-Tube Display) | Ganjavores DC',
    'Pre-rolled cones, 2 per glass tube, king size.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '2-Cone Tube', 8.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'raw-pressed-bud-wraps-king-size-cones-12-tube-display'), '/products/accessories/raw-pressed-bud-wraps-tube.png', 'RAW Pressed Bud Wraps — King Size Cones (12-Tube Display)', 0);

-- ---------------------------------------------------------------
-- Lookah Turtle Battery
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'lookah-turtle-battery',
    'Lookah Turtle Battery',
    (select id from brands where slug = 'lookah'),
    (select id from categories where slug = 'accessories'),
    NULL,
    NULL,
    NULL,
    '510-thread battery, available in 8 colors.',
    'The Lookah Turtle is a compact 510-thread battery built for cartridges — solid draw, reliable heat, no complicated buttons. Pick your color: green, gray, blue, black, red, purple, orange, or neon.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Lookah Turtle Battery | Ganjavores DC',
    '510-thread battery, available in 8 colors.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), 'Green', 25.00, true),
  ((select id from new_product), 'Gray', 25.00, false),
  ((select id from new_product), 'Blue', 25.00, false),
  ((select id from new_product), 'Black', 25.00, false),
  ((select id from new_product), 'Red', 25.00, false),
  ((select id from new_product), 'Purple', 25.00, false),
  ((select id from new_product), 'Orange', 25.00, false),
  ((select id from new_product), 'Neon', 25.00, false);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'lookah-turtle-battery'), '/products/accessories/lookah-turtle-battery-colors.jpg', 'Lookah Turtle Battery', 0);

-- ---------------------------------------------------------------
-- RAW x Lyrical Lemonade Bud Wrap
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'raw-x-lyrical-lemonade-bud-wrap',
    'RAW x Lyrical Lemonade Bud Wrap',
    (select id from brands where slug = 'raw'),
    (select id from categories where slug = 'accessories'),
    NULL,
    NULL,
    NULL,
    'Limited RAW collab, lemonade-flavored bud wrap.',
    'A limited RAW x Lyrical Lemonade collab — terpene-enhanced lemonade-flavored bud wrap, 2 cones per tube. Grab it while it''s in stock; collabs like this don''t restock.',
    NULL, -- EDIT ME: no THC% supplied for this product yet
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'RAW x Lyrical Lemonade Bud Wrap | Ganjavores DC',
    'Limited RAW collab, lemonade-flavored bud wrap.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '2-Cone Tube', 9.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'raw-x-lyrical-lemonade-bud-wrap'), '/products/accessories/raw-lyrical-lemonade-budwrap-box.jpg', 'RAW x Lyrical Lemonade Bud Wrap', 0),
  ((select id from products where slug = 'raw-x-lyrical-lemonade-bud-wrap'), '/products/accessories/raw-lyrical-lemonade-budwrap.jpg', 'RAW x Lyrical Lemonade Bud Wrap', 1);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Ice Cream Banana
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-ice-cream-banana',
    'Jeeter Juice Live Resin — Ice Cream Banana',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'creamy banana and vanilla',
    'Fresh-squeezed live resin disposable, Ice Cream Banana flavor.',
    'Creamy banana-and-vanilla flavor over a heavier indica body effect. One of the dessert-leaning Jeeter Juice flavors, built for evening wind-down.',
    85.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Ice Cream Banana | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Ice Cream Banana flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-ice-cream-banana'), '/products/vapes/jeeter-juice-ice-cream-banana.jpg', 'Jeeter Juice Live Resin — Ice Cream Banana', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Wedding Cake
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-wedding-cake',
    'Jeeter Juice Live Resin — Wedding Cake',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'sweet vanilla cake with peppery undertones',
    'Fresh-squeezed live resin disposable, Wedding Cake flavor.',
    'Wedding Cake''s signature sweet, slightly peppery profile in disposable form — smooth, balanced hybrid effect with real flavor behind it.',
    86.0,
    False,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Wedding Cake | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Wedding Cake flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-wedding-cake'), '/products/vapes/jeeter-juice-wedding-cake.jpg', 'Jeeter Juice Live Resin — Wedding Cake', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Papaya #5
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-papaya-5',
    'Jeeter Juice Live Resin — Papaya #5',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'tropical papaya, mellow sweetness',
    'Fresh-squeezed live resin disposable, Papaya #5 flavor — 500mg.',
    'Tropical papaya sweetness with a relaxed indica-leaning finish. The #5 cut runs 500mg per disposable, fresh-squeezed with no additives.',
    84.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Papaya #5 | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Papaya #5 flavor — 500mg.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '500mg Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-papaya-5'), '/products/vapes/jeeter-juice-papaya-5.webp', 'Jeeter Juice Live Resin — Papaya #5', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Papaya
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-papaya',
    'Jeeter Juice Live Resin — Papaya',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'ripe tropical papaya',
    'Fresh-squeezed live resin disposable, Papaya flavor.',
    'Straightforward ripe papaya sweetness, indica-leaning, single-source live resin with no additives — the base cut in the Papaya lineup.',
    83.5,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Papaya | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Papaya flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-papaya'), '/products/vapes/jeeter-juice-papaya.jpg', 'Jeeter Juice Live Resin — Papaya', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Do-Si-Lato
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-do-si-lato',
    'Jeeter Juice Live Resin — Do-Si-Lato',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'sweet cookie dough, earthy finish',
    'Fresh-squeezed live resin disposable, Do-Si-Lato flavor.',
    'Sweet, cookie-forward nose with an earthy indica finish underneath. A heavier hitter in the Jeeter Juice lineup — good for nights you''re not going anywhere after.',
    87.0,
    False,
    False,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Do-Si-Lato | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Do-Si-Lato flavor.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '500mg Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-do-si-lato'), '/products/vapes/jeeter-juice-do-si-lato.jpg', 'Jeeter Juice Live Resin — Do-Si-Lato', 0);

-- ---------------------------------------------------------------
-- Jeeter Juice Live Resin — Ice Cream Cake
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jeeter-juice-live-resin-ice-cream-cake',
    'Jeeter Juice Live Resin — Ice Cream Cake',
    (select id from brands where slug = 'jeeter'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    NULL,
    'sweet cream and vanilla cake',
    'Fresh-squeezed live resin disposable, Ice Cream Cake flavor — 500mg.',
    'Rich, dessert-forward flavor over a heavy indica body effect — one of Jeeter''s most requested flavors and a solid nightcap pick.',
    86.5,
    False,
    True,
    25, -- EDIT ME: placeholder inventory count
    'Jeeter Juice Live Resin — Ice Cream Cake | Ganjavores DC',
    'Fresh-squeezed live resin disposable, Ice Cream Cake flavor — 500mg.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '500mg Disposable', 40.00, true);

insert into product_images (product_id, url, alt_text, display_order)
values
  ((select id from products where slug = 'jeeter-juice-live-resin-ice-cream-cake'), '/products/vapes/jeeter-juice-ice-cream-cake.webp', 'Jeeter Juice Live Resin — Ice Cream Cake', 0);

-- =====================================================================
-- GANJAVORES DC — SEED BATCH 2: real product data supplied by Adrian.
-- Descriptions/THC%/terpenes/cannabinoids are real, sourced content —
-- NOT placeholders. Prices ARE placeholders (none were supplied) —
-- search 'EDIT ME' for every price that needs a real number.
-- Images are NOT yet attached (pending spreadsheet) — every product
-- will show the site's 'No image yet' placeholder until images are
-- added via /admin/products/[id].
--
-- FLAG: some of this copy (esp. the Gelato #33 entry referencing
-- 'Best of Weedmaps Semifinalist') reads as sourced from a menu
-- aggregator rather than written fresh for Ganjavores — worth a
-- copyright/duplicate-content-SEO check before this goes fully live.
-- =====================================================================

insert into brands (name, slug, is_house_brand) values ('Gas Boys', 'gas-boys', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Tapestry Herb Co.', 'tapestry-herb-co', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Premium Flower', 'premium-flower', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Jungle Boys', 'jungle-boys', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Connected Cannabis Co', 'connected-cannabis-co', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Alien Labs', 'alien-labs', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Dank By Definition', 'dank-by-definition', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Cultivar Premium Flower', 'cultivar-premium-flower', False) on conflict (slug) do nothing;

-- ---------------------------------------------------------------
-- Purple Punch All-In-One (purple-punch-all-in-one-2000mg)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'purple-punch-all-in-one-2000mg',
    'Purple Punch All-In-One',
    NULL,
    (select id from categories where slug = 'vapes'),
    'Indica Hybrid',
    'Larry OG x Granddaddy Purple',
    'grape, berry, sugary',
    '2000mg all-in-one, deeply relaxing indica-dominant.',
    'Purple Punch is a delectable indica-dominant strain born from a cross of Larry OG and Granddaddy Purple, originally crafted by the renowned Hawaiian breeders at Supernova Gardens. Celebrated for its sweet, candy-like flavor, this strain boasts dense, frosty buds with deep purple and green hues. Perfect for unwinding, Purple Punch delivers a deeply relaxing and sedating experience, ideal for promoting restful sleep or soothing stress. Top reported effects: relaxed, euphoric, happy. Often chosen to help manage stress, insomnia, and mild pain.',
    22.5,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Purple Punch All-In-One | Ganjavores DC',
    '2000mg all-in-one, deeply relaxing indica-dominant.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '2000mg All-In-One', 55.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-punch-all-in-one-2000mg'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'purple-punch-all-in-one-2000mg'), 'Caryophyllene', NULL, 1);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-punch-all-in-one-2000mg'), 'THC', 22.5, 0),
  ((select id from products where slug = 'purple-punch-all-in-one-2000mg'), 'CBD', 0.1, 1);

-- ---------------------------------------------------------------
-- Jack Herer All-In-One (jack-herer-all-in-one-2000mg)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jack-herer-all-in-one-2000mg',
    'Jack Herer All-In-One',
    NULL,
    (select id from categories where slug = 'vapes'),
    'Sativa Hybrid',
    NULL,
    'pine, earthy, spicy/herbal',
    '2000mg all-in-one, uplifting sativa-dominant classic.',
    'Jack Herer, named after the iconic cannabis activist and author of The Emperor Wears No Clothes, is a legendary sativa-dominant strain bred by Sensi Seeds, winner of 9 first-place High Times Cannabis Cup awards. Delivers a complex flavor profile of earthy pine, zesty citrus, and spicy wood. Celebrated for its uplifting and energizing effects, sparking creativity, focus, and euphoria — ideal for daytime use. Top reported effects: uplifted, happy, relaxed. Often chosen to help manage stress, anxiety, and fatigue.',
    NULL, -- EDIT ME: no THC% supplied for this product
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Jack Herer All-In-One | Ganjavores DC',
    '2000mg all-in-one, uplifting sativa-dominant classic.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '2000mg All-In-One', 55.00, true); -- EDIT ME: placeholder price

-- ---------------------------------------------------------------
-- Cherry Grapefruit All-In-One (cherry-grapefruit-all-in-one-2000mg)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'cherry-grapefruit-all-in-one-2000mg',
    'Cherry Grapefruit All-In-One',
    NULL,
    (select id from categories where slug = 'vapes'),
    'Sativa',
    NULL,
    'cherry, grapefruit, fruity candy',
    '2000mg all-in-one, bright and energizing sativa.',
    'Cherry Grapefruit is a vibrant sativa strain that marries the juicy sweetness of ripe cherries with the zesty tang of grapefruit. Known for its glistening, trichome-covered buds. Ideal for daytime use, it sparks a euphoric and uplifting high, boosting mood, creativity, and a sense of well-being. Top reported effects: euphoric, uplifting, creative. Often chosen to help manage depression, fatigue, and stress.',
    NULL, -- EDIT ME: no THC% supplied for this product
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Cherry Grapefruit All-In-One | Ganjavores DC',
    '2000mg all-in-one, bright and energizing sativa.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '2000mg All-In-One', 55.00, true); -- EDIT ME: placeholder price

-- ---------------------------------------------------------------
-- Permanent Marker
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'permanent-marker',
    'Permanent Marker',
    (select id from brands where slug = 'gas-boys'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Biscotti x Sherb Bx x Jealousy',
    'sweet, earthy, gassy',
    'Leafly''s 2023 Strain of the Year — bold and sophisticated.',
    'Permanent Marker, an indica-dominant hybrid, was bred by Seed Junky Genetics and selected by Doja Pak in 2022. Named Leafly''s 2023 Strain of the Year, it delivers dense, frosty buds with a vibrant mix of earthy, sweet, and gassy notes — a tingly, talkative buzz blending into deep relaxation. Top reported effects: tingly, relaxed, euphoric. Potential negatives: anxiousness, dry eyes, dry mouth. Often chosen to help manage stress, anxiety, and social discomfort.',
    26.66,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Permanent Marker | Ganjavores DC',
    'Leafly''s 2023 Strain of the Year — bold and sophisticated.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'permanent-marker'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'permanent-marker'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'permanent-marker'), 'Caryophyllene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'permanent-marker'), 'THCA', 26.66, 0),
  ((select id from products where slug = 'permanent-marker'), 'THC-D9', 0.02, 1),
  ((select id from products where slug = 'permanent-marker'), 'Total Cannabinoids', 26.68, 2);

-- ---------------------------------------------------------------
-- Hawk Tuah
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'hawk-tuah',
    'Hawk Tuah',
    (select id from brands where slug = 'gas-boys'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'OG Kush x Strawberry Diesel',
    'citrus, diesel, sweet fruit',
    '50/50 hybrid, viral name, serious genetics.',
    'Hawk Tuah is a vibrant 50/50 hybrid bred from OG Kush and Strawberry Diesel by Collins Ave in collaboration with Cookies and Kaia Kush. Dense, frosty buds with potent THCa content. Offers a versatile high — euphoric lift into soothing relaxation. Top reported effects: euphoria, relaxing, creative. Often chosen to help manage stress, fatigue, and mild pain.',
    28.17,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Hawk Tuah | Ganjavores DC',
    '50/50 hybrid, viral name, serious genetics.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'hawk-tuah'), 'Caryophyllene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'hawk-tuah'), 'THCA', 28.17, 0),
  ((select id from products where slug = 'hawk-tuah'), 'THC-D9', 0.25, 1),
  ((select id from products where slug = 'hawk-tuah'), 'Total Cannabinoids', 28.42, 2);

-- ---------------------------------------------------------------
-- Purple Dream
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'purple-dream',
    'Purple Dream',
    (select id from brands where slug = 'gas-boys'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Granddaddy Purple x Blue Dream',
    'blueberry, grape, earthy',
    'Lavender-hued hybrid, balanced euphoria and relaxation.',
    'Purple Dream is a captivating indica-leaning hybrid from Granddaddy Purple and Blue Dream, showcasing dense buds with lavender, green, and purple-blue hues. Offers a harmonious balance of uplifting euphoria and deep relaxation. Top reported effects: hungry, aroused, happy. Often chosen to help manage stress, mild pain, and anxiety.',
    32.2,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Purple Dream | Ganjavores DC',
    'Lavender-hued hybrid, balanced euphoria and relaxation.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 48.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-dream'), 'Myrcene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-dream'), 'THCA', 32.2, 0),
  ((select id from products where slug = 'purple-dream'), 'THC-D9', 0.19, 1),
  ((select id from products where slug = 'purple-dream'), 'Total Cannabinoids', 32.4, 2);

-- ---------------------------------------------------------------
-- Grape Gas Exotic Indoor Flower
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'grape-gas-exotic-indoor-flower',
    'Grape Gas Exotic Indoor Flower',
    NULL,
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    '(OG Chem x Granddaddy Purple) x The Truth',
    'grape, diesel, citrus',
    'Diesel-fueled potency meets grape sweetness.',
    'Grape Gas is a captivating indica-dominant hybrid grown indoors, combining the diesel-fueled potency of OG Chem, grape-like sweetness of Granddaddy Purple, and earthy depth of The Truth. Dense, frosty buds. Delivers a harmonious blend of relaxation, euphoria, and upliftment. Top reported effects: calming, euphoria, happy, relaxing, uplifting. Often chosen to help manage stress, anxiety, mild pain, and insomnia.',
    30.68,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Grape Gas Exotic Indoor Flower | Ganjavores DC',
    'Diesel-fueled potency meets grape sweetness.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'grape-gas-exotic-indoor-flower'), 'Myrcene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'grape-gas-exotic-indoor-flower'), 'THCA', 30.68, 0),
  ((select id from products where slug = 'grape-gas-exotic-indoor-flower'), 'THC-D9', 0.19, 1),
  ((select id from products where slug = 'grape-gas-exotic-indoor-flower'), 'Total Cannabinoids', 30.88, 2);

-- ---------------------------------------------------------------
-- Gushers Exotic Indoor Flower
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gushers-exotic-indoor-flower',
    'Gushers Exotic Indoor Flower',
    NULL,
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Gelato #41 x Triangle Kush',
    'earthy, herbal, sour',
    'Tropical, sweet, and balanced hybrid.',
    'Gushers is an exhilarating hybrid born from Gelato #41 and Triangle Kush, with a sweet tropical aroma and vibrant fruity flavors. Dense, trichome-laden buds. Delivers a balanced high combining soothing body buzz with uplifting cerebral lift. Top reported effects: euphoria, relaxing, uplifting. Often chosen to help manage stress, anxiety, and mood disorders.',
    31.16,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gushers Exotic Indoor Flower | Ganjavores DC',
    'Tropical, sweet, and balanced hybrid.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gushers-exotic-indoor-flower'), 'Caryophyllene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gushers-exotic-indoor-flower'), 'THCA', 31.16, 0),
  ((select id from products where slug = 'gushers-exotic-indoor-flower'), 'THC-D9', 1.28, 1),
  ((select id from products where slug = 'gushers-exotic-indoor-flower'), 'Total Cannabinoids', 31.29, 2);

-- ---------------------------------------------------------------
-- Chemdawg 91
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'chemdawg-91',
    'Chemdawg 91',
    (select id from brands where slug = 'tapestry-herb-co'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'chemical, skunk, earthy',
    'Legendary East Coast chem strain, exotic whole flower.',
    'Chemdawg 91, also known as Chem 91, is a legendary hybrid celebrated for its mysterious origins, believed crafted by East Coast cultivator Chemdog with possible Thai landrace roots. Dense, trichome-rich buds with a striking chemical aroma. Uplifting and social effects, perfect for sparking conversation. Top reported effects: happy, talkative, euphoric. Often chosen to help manage stress, depression, and fatigue.',
    32.85,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Chemdawg 91 | Ganjavores DC',
    'Legendary East Coast chem strain, exotic whole flower.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 48.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'chemdawg-91'), 'Myrcene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'chemdawg-91'), 'THCA', 32.85, 0),
  ((select id from products where slug = 'chemdawg-91'), 'THC-D9', 0.15, 1),
  ((select id from products where slug = 'chemdawg-91'), 'Total Cannabinoids', 31.92, 2);

-- ---------------------------------------------------------------
-- Gelato Cake (gelato-cake-tapestry)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gelato-cake-tapestry',
    'Gelato Cake',
    (select id from brands where slug = 'tapestry-herb-co'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Gelato #33 x Wedding Cake',
    'creamy vanilla, sweet berries, gas, pine',
    'Dessert-forward hybrid, living soil grown.',
    'Gelato Cake is a luxurious indica-dominant hybrid from Gelato #33 and Wedding Cake, both members of the Cookie strain family. Frosty, trichome-laden buds with a dessert-like allure. Rich, creamy flavor and deeply relaxing effects with a touch of euphoria. Top reported effects: sleepy, relaxed, hungry. Often chosen to help manage insomnia, stress, and lack of appetite.',
    16.82,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gelato Cake | Ganjavores DC',
    'Dessert-forward hybrid, living soil grown.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 42.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gelato-cake-tapestry'), 'Limonene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gelato-cake-tapestry'), 'THCA', 16.82, 0),
  ((select id from products where slug = 'gelato-cake-tapestry'), 'THC-D9', 0.29, 1),
  ((select id from products where slug = 'gelato-cake-tapestry'), 'Total Cannabinoids', 17.57, 2);

-- ---------------------------------------------------------------
-- Peanut Butter Breath
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'peanut-butter-breath',
    'Peanut Butter Breath',
    (select id from brands where slug = 'premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Do-Si-Dos x Mendo Breath',
    'nutty, creamy, earthy',
    'Nutty, buttery hybrid from ThugPug Genetics.',
    'Peanut Butter Breath is a captivating hybrid bred by ThugPug Genetics from Do-Si-Dos and Mendo Breath. Dense, frosty buds with a unique nutty aroma. Delivers a profoundly relaxing experience with gentle sedation. Top reported effects: relaxed, sleepy, hungry. Often chosen to help manage stress, insomnia, and lack of appetite.',
    29.02,
    True,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Peanut Butter Breath | Ganjavores DC',
    'Nutty, buttery hybrid from ThugPug Genetics.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 42.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'peanut-butter-breath'), 'Limonene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'peanut-butter-breath'), 'THC', 29.03, 0),
  ((select id from products where slug = 'peanut-butter-breath'), 'THCA', 29.02, 1),
  ((select id from products where slug = 'peanut-butter-breath'), 'THC-D9', 0.2, 2),
  ((select id from products where slug = 'peanut-butter-breath'), 'Total Cannabinoids', 27.3, 3);

-- ---------------------------------------------------------------
-- Sour Diesel (sour-diesel-premium-flower)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'sour-diesel-premium-flower',
    'Sour Diesel',
    (select id from brands where slug = 'premium-flower'),
    (select id from categories where slug = 'flower'),
    'Sativa Hybrid',
    'Chemdawg x Super Skunk',
    'diesel, pungent, earthy',
    'Fast-acting, cerebral classic since the early ''90s.',
    'Sour Diesel, affectionately known as ''Sour D'', is a legendary hybrid born from Chemdawg and Super Skunk. Vibrant, frosty buds with a pungent diesel aroma. A favorite since the early 1990s, delivering a fast-acting, cerebral high that sparks energy, talkativeness, and uplifted mood. Top reported effects: energetic, talkative, uplifted. Potential negatives: dry mouth, dry eyes, paranoia. Often chosen to help manage depression, stress, and pain.',
    32.49,
    True,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Sour Diesel | Ganjavores DC',
    'Fast-acting, cerebral classic since the early ''90s.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'sour-diesel-premium-flower'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'sour-diesel-premium-flower'), 'Myrcene', NULL, 1),
  ((select id from products where slug = 'sour-diesel-premium-flower'), 'Limonene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'sour-diesel-premium-flower'), 'THCA', 32.49, 0),
  ((select id from products where slug = 'sour-diesel-premium-flower'), 'THC-D9', 0.24, 1),
  ((select id from products where slug = 'sour-diesel-premium-flower'), 'Total Cannabinoids', 32.74, 2);

-- ---------------------------------------------------------------
-- Green Crack
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'green-crack',
    'Green Crack',
    (select id from brands where slug = 'premium-flower'),
    (select id from categories where slug = 'flower'),
    'Sativa',
    'Skunk #1 x unknown indica',
    'citrus, tropical, sweet',
    'Sharp, energizing sativa for daytime focus.',
    'Green Crack, a vibrant sativa also known as ''Green Crush'' or ''Mango Crack'', delivers a sharp, energizing high that keeps you focused and productive. Perfect for daytime use, celebrated for combating fatigue, stress, and depression. Top reported effects: energetic, talkative, focused. Often chosen to help manage fatigue, stress, and depression.',
    29.58,
    True,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Green Crack | Ganjavores DC',
    'Sharp, energizing sativa for daytime focus.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 42.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'green-crack'), 'Myrcene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'green-crack'), 'THCA', 29.58, 0),
  ((select id from products where slug = 'green-crack'), 'THC-D9', 0.26, 1),
  ((select id from products where slug = 'green-crack'), 'Total Cannabinoids', 26.96, 2);

-- ---------------------------------------------------------------
-- Sherbinski
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'sherbinski',
    'Sherbinski',
    (select id from brands where slug = 'jungle-boys'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Sunset Sherbert x Thin Mint GSC',
    'berry, diesel, earthy',
    'Jungle Boys'' connoisseur favorite, balanced high.',
    'Sherbinski (Sunset Sherb) is a premium hybrid from Sunset Sherbert and Thin Mint Girl Scout Cookies, cultivated by Jungle Boys. Frosty, trichome-drenched buds with irresistible bag appeal. Balanced high — deep relaxation with waves of happiness. Top reported effects: relaxed, happy, uplifted. Often chosen to help manage stress, anxiety, mood disorders, and mild pain.',
    31.42,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Sherbinski | Ganjavores DC',
    'Jungle Boys'' connoisseur favorite, balanced high.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 50.00, true); -- EDIT ME: placeholder price

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'sherbinski'), 'THC', 31.42, 0),
  ((select id from products where slug = 'sherbinski'), 'CBD', 0.07, 1);

-- ---------------------------------------------------------------
-- Gelato #33
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gelato-33',
    'Gelato #33',
    (select id from brands where slug = 'jungle-boys'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Sunset Sherbet x Thin Mint GSC',
    'berry, creamy vanilla, fruity citrus',
    '17,770 favorites — the cut that started the Gelato craze.',
    'Gelato #33, also known as Larry Bird, is the legendary hybrid that sparked the Gelato craze, cultivated by Jungle Boys through careful pheno-hunting. Dense, trichome-laden buds in deep purple and vibrant green with fiery orange hairs. Balanced high — euphoric cerebral uplift with soothing physical relaxation. Top reported effects: relaxed, euphoric, happy. Often chosen to help manage stress, anxiety, depression, pain, and fatigue.',
    21.5,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gelato #33 | Ganjavores DC',
    '17,770 favorites — the cut that started the Gelato craze.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 50.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gelato-33'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'gelato-33'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'gelato-33'), 'Myrcene', NULL, 2);

-- ---------------------------------------------------------------
-- Ice Cream Cake (ice-cream-cake-jungle-boys)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'ice-cream-cake-jungle-boys',
    'Ice Cream Cake',
    (select id from brands where slug = 'jungle-boys'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Wedding Cake x Gelato #33',
    'sweet, vanilla, berry',
    'Deeply sedating, dessert-sweet nighttime hybrid.',
    'Ice Cream Cake is an indulgent indica-dominant hybrid from Wedding Cake and Gelato #33, cultivated by Jungle Boys. Dense, frost-covered buds in deep purple and vibrant green. Deeply sedating yet blissfully happy high — perfect for evening unwind. Top reported effects: relaxed, happy, sleepy. Often chosen to help manage stress, anxiety, insomnia, chronic pain, and depression.',
    24.4,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Ice Cream Cake | Ganjavores DC',
    'Deeply sedating, dessert-sweet nighttime hybrid.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 48.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'ice-cream-cake-jungle-boys'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'ice-cream-cake-jungle-boys'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'ice-cream-cake-jungle-boys'), 'Myrcene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'ice-cream-cake-jungle-boys'), 'THC', 24.4, 0);

-- ---------------------------------------------------------------
-- Gushers (gushers-connected-cannabis-co)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gushers-connected-cannabis-co',
    'Gushers',
    (select id from brands where slug = 'connected-cannabis-co'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Triangle Kush x Gelato #41',
    'diesel, fuel, coffee-like',
    'Bulk 10g pack, edgy and alert indica-dominant.',
    'Gushers is a potent indica-dominant hybrid from Connected Cannabis Co, blending Triangle Kush with Gelato #41. Dense, frosty buds with vibrant greens and subtle purple accents. Invigorating body buzz paired with mental clarity — alert and focused rather than sedating. Top reported effects: edgy, alert, strong body high. Often chosen to help manage stress, fatigue, mild pain, and mood.',
    NULL, -- EDIT ME: no THC% supplied for this product
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gushers | Ganjavores DC',
    'Bulk 10g pack, edgy and alert indica-dominant.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '10g', 110.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gushers-connected-cannabis-co'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'gushers-connected-cannabis-co'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'gushers-connected-cannabis-co'), 'Linalool', NULL, 2);

-- ---------------------------------------------------------------
-- Area 41
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'area-41',
    'Area 41',
    (select id from brands where slug = 'alien-labs'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Lemon Fuel OG x Gelato #41',
    'lemon, creamy berry, earth/gas',
    'Half-ounce top-shelf, bold gas and citrus.',
    'Area 41 is a potent indica-leaning hybrid from Alien Labs, crossing Lemon Fuel OG and Gelato #41. Dense, trichome-heavy buds in vibrant greens with hints of purple. Powerful, well-rounded high — uplifting euphoria transitioning into deep body relaxation. Top reported effects: euphoric, relaxed, uplifted. Often chosen to help manage stress, anxiety, pain, and depression.',
    28.5,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Area 41 | Ganjavores DC',
    'Half-ounce top-shelf, bold gas and citrus.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 140.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'area-41'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'area-41'), 'Myrcene', NULL, 1),
  ((select id from products where slug = 'area-41'), 'Caryophyllene', NULL, 2);

-- ---------------------------------------------------------------
-- Duct Tape
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'duct-tape',
    'Duct Tape',
    (select id from brands where slug = 'premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Original Glue (GG#4) x Do-Si-Dos',
    'diesel, skunk, pepper',
    'Half-ounce, resin-packed and intensely relaxing.',
    'Duct Tape is a powerful hybrid crafted from Original Glue (GG#4) and Do-Si-Dos. Dense, resin-packed buds in vibrant green and purple hues. Deeply relaxing yet uplifting experience, blending stress relief with a spark of creativity. Top reported effects: relaxed, sleepy, euphoric. Often chosen to help manage stress, anxiety, and chronic pain.',
    25.0,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Duct Tape | Ganjavores DC',
    'Half-ounce, resin-packed and intensely relaxing.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 130.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'duct-tape'), 'Limonene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'duct-tape'), 'THC', 25.0, 0),
  ((select id from products where slug = 'duct-tape'), 'CBD', 0.1, 1),
  ((select id from products where slug = 'duct-tape'), 'CBG', 1.0, 2);

-- ---------------------------------------------------------------
-- Super Lemon G
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'super-lemon-g',
    'Super Lemon G',
    (select id from brands where slug = 'premium-flower'),
    (select id from categories where slug = 'flower'),
    'Sativa Hybrid',
    'Super Lemon Haze x G13',
    'tart lemon, herbal, floral citrus',
    'Half-ounce, zesty and motivating daytime sativa.',
    'Super Lemon G is a vibrant 70/30 sativa-dominant hybrid from Super Lemon Haze and G13. Bright, frosty buds with golden trichomes and fiery orange hairs. Ideal for daytime use — ignites creativity, sharpens focus, sparks joy without heavy sedation. Top reported effects: energetic, focused, euphoric, creative, uplifted. Often chosen to help manage stress, anxiety, depression, fatigue, and low mood.',
    23.0,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Super Lemon G | Ganjavores DC',
    'Half-ounce, zesty and motivating daytime sativa.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 130.00, true); -- EDIT ME: placeholder price

-- ---------------------------------------------------------------
-- Wedding Cake
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'wedding-cake',
    'Wedding Cake',
    (select id from brands where slug = 'dank-by-definition'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Triangle Kush x Animal Mints',
    'vanilla, sweet, earthy pepper',
    '1st place Best Hybrid, SoCal High Times Cup 2018.',
    'Wedding Cake, also known as Pink Cookies, is a potent indica-dominant hybrid from Triangle Kush and Animal Mints, bred by Seed Junky Genetics. Sparkling, resin-drenched buds with hints of pink and purple. Deep relaxation and euphoric bliss, perfect for evening use. Bred by Seed Junky Genetics, won 1st place for Best Hybrid Flower at the 2018 SoCal High Times Medical Cannabis Cup. Top reported effects: relaxed, euphoric, sleepy. Often chosen to help manage pain, insomnia, and loss of appetite.',
    24.0,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Wedding Cake | Ganjavores DC',
    '1st place Best Hybrid, SoCal High Times Cup 2018.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 135.00, true); -- EDIT ME: placeholder price

-- ---------------------------------------------------------------
-- Jenny Kush
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jenny-kush',
    'Jenny Kush',
    (select id from brands where slug = 'premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Amnesia Haze x Rare Dankness #2',
    'earthy, hazy, sweet herbal, citrus',
    'Named for cannabis activist Jenny Monson — balanced and potent.',
    'Jenny Kush is an evenly balanced hybrid from Amnesia Haze and Rare Dankness #2, named in loving memory of cannabis activist Jennifer ''Jenny Kush'' Monson, who helped found chapters of Moms for Marijuana and was a staple at Colorado cannabis rallies before her passing in 2013 — August 31st is celebrated as Jenny Kush Day. Small, grape-shaped olive green nugs with rich purple undertones and fiery orange hairs. Delivers profound relaxation, blissful euphoria, and effective pain relief. Top reported effects: relaxed, blissful, pain free. Often chosen to help manage chronic pain, stress, anxiety, and inflammation.',
    34.56,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Jenny Kush | Ganjavores DC',
    'Named for cannabis activist Jenny Monson — balanced and potent.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 140.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'jenny-kush'), 'Myrcene', 1.379, 0),
  ((select id from products where slug = 'jenny-kush'), 'Caryophyllene', 0.437, 1),
  ((select id from products where slug = 'jenny-kush'), 'Limonene', 0.34, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'jenny-kush'), 'THC', 34.56, 0),
  ((select id from products where slug = 'jenny-kush'), 'CBD', 0.07, 1);

-- ---------------------------------------------------------------
-- Colonial Kush
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description
  ) values (
    'colonial-kush',
    'Colonial Kush',
    (select id from brands where slug = 'cultivar-premium-flower'),
    (select id from categories where slug = 'flower'),
    'Indica',
    NULL,
    'pine, herbal hash, citrus zest, spicy earth',
    'Master-grower indica, deep body melt for nighttime.',
    'Colonial Kush is a potent indica-dominant strain from the Cultivar collection, blending classic Kush genetics with modern cultivation. Dense, resinous buds coated in trichomes, vibrant green with amber pistils. Ideal for evening unwind — profound relaxation melting into happy, sleepy euphoria. Top reported effects: relaxed, sleepy, happy. Often chosen to help manage stress, insomnia, chronic pain, and anxiety.',
    33.13,
    False,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Colonial Kush | Ganjavores DC',
    'Master-grower indica, deep body melt for nighttime.'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 48.00, true); -- EDIT ME: placeholder price

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'colonial-kush'), 'Limonene', 1.02, 0),
  ((select id from products where slug = 'colonial-kush'), 'Caryophyllene', 0.3, 1),
  ((select id from products where slug = 'colonial-kush'), 'Pinene', 0.21, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'colonial-kush'), 'THCA', 33.13, 0),
  ((select id from products where slug = 'colonial-kush'), 'THC-D9', 0.43, 1),
  ((select id from products where slug = 'colonial-kush'), 'CBGA', 0.9, 2),
  ((select id from products where slug = 'colonial-kush'), 'CBG', 0.11, 3);

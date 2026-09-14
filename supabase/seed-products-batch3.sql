-- =====================================================================
-- GANJAVORES DC — SEED BATCH 3: sourced from Cannabis_Product_Descriptions.xlsx
-- 40 products, real pricing on 32 of them (Notes sheet tier structure used
-- to infer the remaining 8 — see README for exactly which ones + reasoning).
-- Multi-size products get one variant row PER size, parsed from the sheet's
-- 'X: $Y | A: $B' price strings.
-- =====================================================================

insert into brands (name, slug, is_house_brand) values ('Exotic Genetix', 'exotic-genetix', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Cookies Premium Flower', 'cookies-premium-flower', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Cookies', 'cookies', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Khalifa Kush', 'khalifa-kush', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Rythm', 'rythm', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Cultivar Collection by Trulieve', 'cultivar-collection-by-trulieve', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Bargain Budd', 'bargain-budd', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('White Runtz', 'white-runtz', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Devour', 'devour', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Faded Fruits', 'faded-fruits', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Friendly Farms', 'friendly-farms', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Lemonnade', 'lemonnade', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Loud Flower', 'loud-flower', False) on conflict (slug) do nothing;
insert into brands (name, slug, is_house_brand) values ('Cultivation Labs', 'cultivation-labs', False) on conflict (slug) do nothing;

-- ---------------------------------------------------------------------
-- UPDATES to existing rows (same product, real data now available) —
-- see README 'Batch 3' section for why these are UPDATEs, not inserts.
-- ---------------------------------------------------------------------
update product_variants set label = '500mg Disposable', price = 65.00
  where product_id = (select id from products where slug = 'jeeter-juice-live-resin-ice-cream-banana') and is_default = true;
update product_variants set label = '500mg Disposable', price = 65.00
  where product_id = (select id from products where slug = 'jeeter-juice-live-resin-wedding-cake') and is_default = true;
update product_variants set label = '500mg Disposable', price = 65.00
  where product_id = (select id from products where slug = 'jeeter-juice-live-resin-papaya-5') and is_default = true;
update product_variants set label = '500mg Disposable', price = 65.00
  where product_id = (select id from products where slug = 'jeeter-juice-live-resin-papaya') and is_default = true;
update product_variants set label = '500mg Disposable', price = 65.00
  where product_id = (select id from products where slug = 'jeeter-juice-live-resin-do-si-lato') and is_default = true;
update product_variants set label = '500mg Disposable', price = 65.00
  where product_id = (select id from products where slug = 'jeeter-juice-live-resin-ice-cream-cake') and is_default = true;

delete from product_variants where product_id = (select id from products where slug = 'sour-diesel');
insert into product_variants (product_id, label, price, is_default) values
  ((select id from products where slug = 'sour-diesel'), '3.5g', 45.00, true),
  ((select id from products where slug = 'sour-diesel'), '7g', 80.00, false),
  ((select id from products where slug = 'sour-diesel'), '14g', 140.00, false),
  ((select id from products where slug = 'sour-diesel'), '28g', 190.00, false);
update products set thc_percent = 26, description = 'Ganjavores'' house-grown Sour Diesel — the DMV staple, bred from Chemdawg and Super Skunk. Sharp fuel funk up front, energizing head-first effects. Flat house pricing across every size.' where slug = 'sour-diesel';

delete from product_variants where product_id = (select id from products where slug = 'gelato-33');
insert into product_variants (product_id, label, price, is_default) values
  ((select id from products where slug = 'gelato-33'), '3.5g', 65.00, true),
  ((select id from products where slug = 'gelato-33'), '7g', 120.00, false),
  ((select id from products where slug = 'gelato-33'), '14g', 220.00, false),
  ((select id from products where slug = 'gelato-33'), '28g', 380.00, false);
update products set thc_percent = 31 where slug = 'gelato-33';

-- =====================================================================
-- NEW products
-- =====================================================================

-- ---------------------------------------------------------------
-- 91 Octane (Exotic Genetix)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    '91-octane',
    '91 Octane',
    (select id from brands where slug = 'exotic-genetix'),
    (select id from categories where slug = 'flower'),
    'Sativa Hybrid',
    'Biscotti x Scotty2hotty',
    'To be determined',
    'To be determined (community feedback welcomed)',
    '91 Octane is a dynamic hybrid strain born from a cross of Biscotti and Scotty2hotty, blending 60% sativa and 40% indica genetics. Renowned for its potent buds and high THC levels, this strain delivers a vibrant, energizing high that appeals to seasoned cannabis enthusiasts. With its rich, aromatic profile and powerful effects, 91 Octane, bred by Exotic Genetix, is a standout choice for those seeking a bold and uplifting flower experience.',
    28.0,
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    '91 Octane | Ganjavores DC',
    'To be determined (community feedback welcomed)'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 190.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = '91-octane'), 'Myrcene', NULL, 0);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = '91-octane'), 'THC', 28.0, 0);

-- ---------------------------------------------------------------
-- Apple Gelato ICE (Muha Meds)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'apple-gelato-ice',
    'Apple Gelato ICE',
    (select id from brands where slug = 'muha-meds'),
    (select id from categories where slug = 'vapes'),
    'Hybrid',
    NULL,
    'Juicy Apple, Creamy Gelato, Fruity',
    'Relaxed, Calm, Happy',
    'Inspired by the sleek, premium design of the Muha Meds vape cartridges, Apple Gelato ICE is a standout hybrid strain that brings a fresh apple taste to life with a creamy, indulgent twist. Encased in stylish blue packaging with the iconic Muha Meds emblem, this strain offers a visually appealing experience that matches its quality. Crafted by Muha Meds, known for their innovative vaping solutions since 2018 in Los Angeles, this strain delivers a soothing, relaxing vibe perfect for unwinding, complemented by its delightful fruity essence. Ideal for cannabis aficionados and newcomers alike, Apple Gelato ICE from Puff Palace promises a flavorful escape that’s as enjoyable as it is calming. Top reported effects: Relaxed, Calm, Happy. Often chosen to help manage Stress, Anxiety, Mild Pain.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Apple Gelato ICE | Ganjavores DC',
    'Relaxed, Calm, Happy'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), 'Not specified (various cartridge sizes)', 55.00, true);

-- ---------------------------------------------------------------
-- Bat Sh!t (Cookies Premium Flower)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'bat-sh-t',
    'Bat Sh!t',
    (select id from brands where slug = 'cookies-premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'Sweet, Herbal, Citrus',
    'Uplifted, Relaxed, Creative',
    'Bat Sh!t is an exhilarating hybrid strain from Cookies, expertly crafted to deliver a unique and unforgettable cannabis experience. With its dense, frosty buds and a vibrant mix of green and amber hues, this strain is as visually captivating as it is potent. Designed for seasoned users, Bat Sh!t combines an energizing cerebral high with a soothing body relaxation, making it perfect for those seeking a balance of creativity and calm. Its distinctive aroma and bold flavors have earned it a loyal following among cannabis enthusiasts looking for a premium flower with character and strength. Top reported effects: Uplifted, Relaxed, Creative. Often chosen to help manage Stress, Depression, Fatigue.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Bat Sh!t | Ganjavores DC',
    'Uplifted, Relaxed, Creative'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true);

-- ---------------------------------------------------------------
-- Black Cherry Gelato (Cookies Premium Flower)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'black-cherry-gelato',
    'Black Cherry Gelato',
    (select id from brands where slug = 'cookies-premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Acai x Gelato',
    'Black Cherry, Gelato Cream, Berry',
    'Relaxed, Euphoric, Creative',
    'Black Cherry Gelato is a delectable hybrid strain from Cookies, renowned for its exquisite balance of potency and flavor. This strain, born from a cross of Acai and Gelato, features dense, frosty buds with deep purple and green hues, making it a visual masterpiece. Perfect for both novice and seasoned cannabis users, Black Cherry Gelato offers a smooth, relaxing high paired with a burst of creative energy. Its rich, dessert-like flavor profile and powerful effects make it a standout choice for those seeking a premium flower experience with a touch of indulgence. Top reported effects: Relaxed, Euphoric, Creative. Often chosen to help manage Stress, Mild Pain, Mood Swings.',
    25.82,
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Black Cherry Gelato | Ganjavores DC',
    'Relaxed, Euphoric, Creative'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '7 grams (1/4 ounce)', 90.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'black-cherry-gelato'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'black-cherry-gelato'), 'Caryophyllene', NULL, 1);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'black-cherry-gelato'), 'THC', 25.82, 0);

-- ---------------------------------------------------------------
-- Cinnamon Milk (Cookies Premium Flower)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'cinnamon-milk',
    'Cinnamon Milk',
    (select id from brands where slug = 'cookies-premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'Sweet Spice, Creamy Milk, Baked Goods',
    'Relaxed, Uplifted, Focused',
    'Cinnamon Milk, a delectable hybrid strain from Cookies, is a standout for cannabis connoisseurs seeking a unique and flavorful experience. Born from a carefully selected genetic lineage, this strain boasts dense, frosty buds with subtle amber hues, making it as visually enticing as it is potent. Renowned for its creamy, dessert-like aroma and smooth effects, Cinnamon Milk offers a balanced high that soothes the body while keeping the mind clear and uplifted. Its rich, spice-infused flavor profile and well-rounded effects make it a must-try for those who appreciate premium flower with a touch of indulgence. Top reported effects: Relaxed, Uplifted, Focused. Often chosen to help manage Stress, Mild Pain, Mood Swings.',
    19.37,
    0.15,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Cinnamon Milk | Ganjavores DC',
    'Relaxed, Uplifted, Focused'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '7g', 80.00, true);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'cinnamon-milk'), 'THC', 19.37, 0),
  ((select id from products where slug = 'cinnamon-milk'), 'CBD', 0.15, 1);

-- ---------------------------------------------------------------
-- Blueberry Banana (Cookies Premium Flower)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'blueberry-banana-cookies-premium-flower',
    'Blueberry Banana',
    (select id from brands where slug = 'cookies-premium-flower'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    NULL,
    'Blueberry, Banana, Creamy',
    'Relaxed, Uplifted, Happy',
    'Blueberry Banana is a delectable hybrid strain from Cookies, blending the sweet, fruity genetics of its parent strains to create a truly indulgent cannabis experience. This strain showcases dense, trichome-laden buds with deep green and violet tones, offering a visual allure that matches its irresistible flavor profile. Perfect for both novice and seasoned users, Blueberry Banana delivers a balanced high that soothes the body while uplifting the mind, making it ideal for relaxation or creative pursuits. Its dessert-like aroma and smooth, flavorful smoke have made it a favorite among those seeking a premium flower with a unique, fruit-forward twist. Top reported effects: Relaxed, Uplifted, Happy. Often chosen to help manage Stress, Mild Pain, Mood Swings.',
    20.25,
    0.19,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Blueberry Banana | Ganjavores DC',
    'Relaxed, Uplifted, Happy'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '7g', 80.00, true) -- EDIT ME: inferred price, confirm;

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'blueberry-banana-cookies-premium-flower'), 'THC', 20.25, 0),
  ((select id from products where slug = 'blueberry-banana-cookies-premium-flower'), 'CBD', 0.19, 1);

-- ---------------------------------------------------------------
-- Khalifa Kush (Khalifa Kush)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'khalifa-kush',
    'Khalifa Kush',
    (select id from brands where slug = 'khalifa-kush'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'OG Kush lineage (closely guarded)',
    'Velvety Kush, Citrus, Pepper',
    'Calm, Happy, Relaxed, Energetic',
    'Khalifa Kush is a legendary hybrid strain crafted exclusively for Wiz Khalifa and now available to cannabis enthusiasts everywhere. Born from a closely guarded OG Kush lineage, this iconic strain boasts dense, resin-drenched buds bursting with velvety kush, zesty citrus, earthy pine, and a dash of peppered spice. Powered by a dynamic terpene trio of limonene, caryophyllene, and pinene, Khalifa Kush delivers an energizing, cerebral high that sparks creativity, sharpens focus, and elevates mood. Perfect for mornings, work sessions, or whenever inspiration calls, this strain offers a smooth, balanced potency with a signature OG twist that sets it apart. Whether you’re seeking mental clarity, stress relief, or simply a higher vibe, Khalifa Kush brings star-quality performance to every session. Top reported effects: Calm, Happy, Relaxed, Energetic. Often chosen to help manage Stress, Anxiety, Lack of Focus, Mood Swings.',
    29.7,
    0.05,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Khalifa Kush | Ganjavores DC',
    'Calm, Happy, Relaxed, Energetic'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '14g', 240.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'khalifa-kush'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'khalifa-kush'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'khalifa-kush'), 'Pinene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'khalifa-kush'), 'THC', 29.7, 0),
  ((select id from products where slug = 'khalifa-kush'), 'CBD', 0.05, 1);

-- ---------------------------------------------------------------
-- Gary Payton (Cookies)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gary-payton',
    'Gary Payton',
    (select id from brands where slug = 'cookies'),
    (select id from categories where slug = 'vapes'),
    'Indica Hybrid',
    NULL,
    'Earthy, Spice, Citrus',
    'Uplifted, Relaxed, Creative, Calm',
    'Gary Payton is a standout hybrid strain from Cookies, blending indica and sativa genetics into a versatile cannabis terp cartridge. Named after the basketball legend, this 1000mg vape cartridge features a sleek design and delivers a potent experience with dense, flavorful vapor. Known for its balanced effects, Gary Payton offers a cerebral uplift paired with a soothing body calm, making it ideal for both daytime creativity and evening relaxation. Infused with a rich terpene profile, it brings a smooth, earthy taste with hints of spice and citrus, appealing to connoisseurs and casual users alike who crave a high-quality, all-day vape. Top reported effects: Uplifted, Relaxed, Creative, Calm. Often chosen to help manage Stress, Anxiety, Pain, Fatigue.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gary Payton | Ganjavores DC',
    'Uplifted, Relaxed, Creative, Calm'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Cartridge', 60.00, true);

-- ---------------------------------------------------------------
-- Lemonchello (Lemonnade)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'lemonchello',
    'Lemonchello',
    (select id from brands where slug = 'lemonnade'),
    (select id from categories where slug = 'vapes'),
    'Sativa Hybrid',
    NULL,
    'Lemon, Sweet, Earthy',
    'Uplifted, Energetic, Focused, Happy',
    'Lemonchello is a vibrant hybrid strain from Lemonnade, packed into a premium 1000mg cannabis terp cartridge. This sativa-leaning hybrid is celebrated for its bright, uplifting effects and zesty citrus-driven profile, derived from its carefully curated genetics. The Lemonchello strain delivers a burst of lemony freshness with every puff, complemented by subtle sweet and earthy undertones, making it a refreshing choice for vape enthusiasts. Perfect for daytime use, it provides an energizing and mood-boosting high that sparks creativity and focus while keeping you relaxed. Lemonchello’s smooth, flavorful vapor and potent effects make it a top pick for those seeking a lively yet balanced vaping experience. Top reported effects: Uplifted, Energetic, Focused, Happy. Often chosen to help manage Stress, Depression, Fatigue, Lack of Focus.',
    86.1,
    0.2,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Lemonchello | Ganjavores DC',
    'Uplifted, Energetic, Focused, Happy'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1g Cartridge', 65.00, true);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'lemonchello'), 'THC', 86.1, 0),
  ((select id from products where slug = 'lemonchello'), 'CBD', 0.2, 1);

-- ---------------------------------------------------------------
-- OG Kush Breath (Rythm)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'og-kush-breath',
    'OG Kush Breath',
    (select id from brands where slug = 'rythm'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Girl Scout Cookies x Unknown (OG Kush lineage)',
    'Nutty, Vanilla, Earthy Diesel',
    'Relaxed, Sleepy, Euphoric',
    'OG Kush Breath (OGKB) is an intensely potent, indica-dominant hybrid born from the renowned Girl Scout Cookies lineage. Featuring dense, trichome-blanketed buds with deep purple undertones and fiery orange pistils, OGKB delivers a deeply soothing full-body melt paired with an initial cerebral uplift. Ideal for evening relaxation, it combines dessert-like earthy sweetness with a pungent herbal fuel aroma. Top reported effects: Relaxed, Sleepy, Euphoric. Often chosen to help manage Stress, Chronic Pain, Insomnia.',
    28.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'OG Kush Breath | Ganjavores DC',
    'Relaxed, Sleepy, Euphoric'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 55.00, true),
  ((select id from new_product), '7g', 100.00, false),
  ((select id from new_product), '14g', 180.00, false),
  ((select id from new_product), '28g', 320.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'og-kush-breath'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'og-kush-breath'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'og-kush-breath'), 'Myrcene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'og-kush-breath'), 'THC', 28.0, 0),
  ((select id from products where slug = 'og-kush-breath'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Cultivar Collection Whole Flower (Cultivar Collection by Trulieve)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'cultivar-collection-whole-flower',
    'Cultivar Collection Whole Flower',
    (select id from brands where slug = 'cultivar-collection-by-trulieve'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Select Proprietary Genetics',
    'Citrus, Floral Spice, Earthy Pine',
    'Euphoric, Balanced, Body Melt',
    'Cultivar Collection represents Trulieve''s craft-tier flower program, focusing on small-batch cultivation, pristine hand-trimming, and exquisite terpene retention. Packaged in light-protective UV glass jars, this whole flower delivers a rich bouquet of floral citrus and earthy pine, culminating in a smooth, high-impact hybrid experience. Top reported effects: Euphoric, Balanced, Body Melt. Often chosen to help manage Anxiety, Stress, Mild Inflammation.',
    29.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Cultivar Collection Whole Flower | Ganjavores DC',
    'Euphoric, Balanced, Body Melt'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 60.00, true),
  ((select id from new_product), '7g', 110.00, false),
  ((select id from new_product), '14g', 200.00, false),
  ((select id from new_product), '28g', 350.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'cultivar-collection-whole-flower'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'cultivar-collection-whole-flower'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'cultivar-collection-whole-flower'), 'Linalool', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'cultivar-collection-whole-flower'), 'THC', 29.0, 0),
  ((select id from products where slug = 'cultivar-collection-whole-flower'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Green Crack (Ganjavores)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'green-crack-ganjavores',
    'Green Crack',
    (select id from brands where slug = 'ganjavores-by-lee-farms'),
    (select id from categories where slug = 'flower'),
    'Sativa',
    'Skunk #1 x Unknown Indica',
    'Tangy Citrus, Sweet Tropical Mango, Earthy',
    'Energetic, Focused, Uplifted',
    'Green Crack is the quintessential daytime sativa, engineered for sharp mental clarity and invigorating energy. Featuring bright green nugs covered in golden trichomes and rust-colored pistils, this signature house strain delivers an invigorating burst of sweet tropical mango and tangy citrus fruit. Top reported effects: Energetic, Focused, Uplifted. Often chosen to help manage Depression, Fatigue, Daytime Stress.',
    24.0,
    1.0,
    true,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Green Crack | Ganjavores DC',
    'Energetic, Focused, Uplifted'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true),
  ((select id from new_product), '7g', 80.00, false),
  ((select id from new_product), '14g', 140.00, false),
  ((select id from new_product), '28g', 190.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'green-crack-ganjavores'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'green-crack-ganjavores'), 'Terpinolene', NULL, 1),
  ((select id from products where slug = 'green-crack-ganjavores'), 'Caryophyllene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'green-crack-ganjavores'), 'THC', 24.0, 0),
  ((select id from products where slug = 'green-crack-ganjavores'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- OGKB 2.1 (Loud Flower)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'ogkb-2-1',
    'OGKB 2.1',
    (select id from brands where slug = 'loud-flower'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'OGKB x Dosidos',
    'Toasted Vanilla, Earthy Dough, Heavy Gas',
    'Heavy Body Melt, Couch-Lock, Sedative',
    'OGKB 2.1 by Loud Flower is an ultra-potent evolution of the OG Kush Breath genetic line crossed with Dosidos. Displaying chunky, resinous buds that reek of heavy diesel, toasted nutty dough, and pungent herbal spice, OGKB 2.1 is crafted strictly for the experienced cannabis connoisseur seeking deep couch-lock sedation and therapeutic relief. Top reported effects: Heavy Body Melt, Couch-Lock, Sedative. Often chosen to help manage Insomnia, Severe Pain, Muscle Spasms.',
    30.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'OGKB 2.1 | Ganjavores DC',
    'Heavy Body Melt, Couch-Lock, Sedative'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 65.00, true),
  ((select id from new_product), '7g', 120.00, false),
  ((select id from new_product), '14g', 220.00, false),
  ((select id from new_product), '28g', 380.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'ogkb-2-1'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'ogkb-2-1'), 'Myrcene', NULL, 1),
  ((select id from products where slug = 'ogkb-2-1'), 'Linalool', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'ogkb-2-1'), 'THC', 30.0, 0),
  ((select id from products where slug = 'ogkb-2-1'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Jenny Kush (Cultivation Labs)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'jenny-kush-cultivation-labs',
    'Jenny Kush',
    (select id from brands where slug = 'cultivation-labs'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Amnesia Haze x Rare Dankness #2',
    'Sweet Floral Citrus, Delicate Pine, Herbal Zest',
    'Uplifting, Cerebral Rush, Blissful Euphoria',
    'Named in loving tribute to cannabis activist Jenny Monson, Jenny Kush by Cultivation Labs is a legendary balanced hybrid boasting astronomical potency exceeding 32% THC. Packaged in a designer matte-pink gradient glass jar, this strain yields an invigorating burst of sweet citrus blossom and delicate pine, creating a wonderfully buoyant cerebral high that settles into soothing full-body comfort. Top reported effects: Uplifting, Cerebral Rush, Blissful Euphoria. Often chosen to help manage Depression, Fatigue, Chronic Stress.',
    32.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Jenny Kush | Ganjavores DC',
    'Uplifting, Cerebral Rush, Blissful Euphoria'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 65.00, true),
  ((select id from new_product), '7g', 120.00, false),
  ((select id from new_product), '14g', 220.00, false),
  ((select id from new_product), '28g', 380.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'jenny-kush-cultivation-labs'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'jenny-kush-cultivation-labs'), 'Myrcene', NULL, 1),
  ((select id from products where slug = 'jenny-kush-cultivation-labs'), 'Pinene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'jenny-kush-cultivation-labs'), 'THC', 32.0, 0),
  ((select id from products where slug = 'jenny-kush-cultivation-labs'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Rythm Hybrid Whole Flower (Rythm)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'rythm-hybrid-whole-flower',
    'Rythm Hybrid Whole Flower',
    (select id from brands where slug = 'rythm'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'Proprietary Hybrid Lineage',
    'Crisp Citrus Diesel, Pine, Earthy Sweetness',
    'Balanced, Relaxed, Clear-Headed',
    'Rythm''s Premium Hybrid Whole Flower delivers full-spectrum potency and terpene-rich freshness in a signature 28g tall glass jar or individual 3.5g options. Hand-trimmed and cured to perfection, this versatile hybrid provides the perfect daytime-to-evening bridge with crisp citrus pine notes and steady relaxation. Top reported effects: Balanced, Relaxed, Clear-Headed. Often chosen to help manage Stress, Mild Pain, Daily Tension.',
    27.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Rythm Hybrid Whole Flower | Ganjavores DC',
    'Balanced, Relaxed, Clear-Headed'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 55.00, true),
  ((select id from new_product), '7g', 100.00, false),
  ((select id from new_product), '14g', 180.00, false),
  ((select id from new_product), '28g', 320.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'rythm-hybrid-whole-flower'), 'Limonene', NULL, 0),
  ((select id from products where slug = 'rythm-hybrid-whole-flower'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'rythm-hybrid-whole-flower'), 'Pinene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'rythm-hybrid-whole-flower'), 'THC', 27.0, 0),
  ((select id from products where slug = 'rythm-hybrid-whole-flower'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Watermelon Slices Sour Gummies (1500mg) (Devour)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'watermelon-slices-sour-gummies-1500mg',
    'Watermelon Slices Sour Gummies (1500mg)',
    (select id from brands where slug = 'devour'),
    (select id from categories where slug = 'edibles'),
    'Hybrid',
    'High-Potency Cannabis Distillate',
    'Sour Watermelon, Sweet Candy',
    'Deep Sedation, Heavy Body Melt, Euphoria',
    'Devour Watermelon Slices deliver an ultra-potent, delicious edible experience for high-tolerance consumers. Each pack contains 10 individually dosed watermelon slice gummies loaded with 150mg of THC each (1500mg total per pouch). Coated in a tangy sour sugar crystals, they deliver a deeply relaxing full-body high and blissful calm. Top reported effects: Deep Sedation, Heavy Body Melt, Euphoria. Often chosen to help manage Severe Pain, Insomnia, Muscle Spasms.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Watermelon Slices Sour Gummies (1500mg) | Ganjavores DC',
    'Deep Sedation, Heavy Body Melt, Euphoria'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '10 pieces (1500mg THC total)', 45.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'watermelon-slices-sour-gummies-1500mg'), 'Cannabis Terpene Infused', NULL, 0);

-- ---------------------------------------------------------------
-- High Crawlers Sour Worms (1500mg) (Devour)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'high-crawlers-sour-worms-1500mg',
    'High Crawlers Sour Worms (1500mg)',
    (select id from brands where slug = 'devour'),
    (select id from categories where slug = 'edibles'),
    'Hybrid',
    'High-Potency Cannabis Distillate',
    'Sour Fruit Medley (Cherry, Lemon, Blue Razz)',
    'Relaxing, Mood Elevation, Body Euphoria',
    'Devour High Crawlers bring a nostalgic sour gummy worm punch backed by powerhouse potency. Packed with 1500mg total THC (10 worms x 150mg each), these multi-flavored sour worms offer long-lasting physical relaxation, stress relief, and uplifting mood elevation. Top reported effects: Relaxing, Mood Elevation, Body Euphoria. Often chosen to help manage Chronic Stress, Pain Relief, Appetite Loss.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'High Crawlers Sour Worms (1500mg) | Ganjavores DC',
    'Relaxing, Mood Elevation, Body Euphoria'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '10 pieces (1500mg THC total)', 45.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'high-crawlers-sour-worms-1500mg'), 'Cannabis Terpene Infused', NULL, 0);

-- ---------------------------------------------------------------
-- Purple Punch (1000mg) (Muha Meds)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'purple-punch-1000mg',
    'Purple Punch (1000mg)',
    (select id from brands where slug = 'muha-meds'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    'Larry OG x Granddaddy Purple',
    'Sweet Grape, Berry Candy, Tart Fruit',
    'Relaxed, Sleepy, Euphoric',
    'Muha Meds Purple Punch delivers the ultimate dessert-like indica vape experience. A cross of Larry OG and Granddaddy Purple, this 1000mg cartridge packs a rich profile of sweet grape punch and tart blueberry candy. Perfect for evening sessions to melt away daily tension and induce deep, restful sleep. Top reported effects: Relaxed, Sleepy, Euphoric. Often chosen to help manage Insomnia, Stress, Chronic Pain.',
    90.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Purple Punch (1000mg) | Ganjavores DC',
    'Relaxed, Sleepy, Euphoric'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg (1.0g)', 60.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-punch-1000mg'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'purple-punch-1000mg'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'purple-punch-1000mg'), 'Pinene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-punch-1000mg'), 'THC', 90.0, 0),
  ((select id from products where slug = 'purple-punch-1000mg'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Cherry Grapefruit (1000mg) (Muha Meds)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'cherry-grapefruit-1000mg',
    'Cherry Grapefruit (1000mg)',
    (select id from brands where slug = 'muha-meds'),
    (select id from categories where slug = 'vapes'),
    'Sativa',
    'Cherry Pie x Grapefruit',
    'Tart Cherry, Zesty Grapefruit, Citrus Punch',
    'Energetic, Uplifted, Creative',
    'Muha Meds Cherry Grapefruit is an invigorating sativa cartridge that blends juicy tart cherries with tangy ruby red grapefruit. Engineered for daytime focus and creative flow, it provides a fast-acting cerebral boost and mood elevation without heavy physical drag. Top reported effects: Energetic, Uplifted, Creative. Often chosen to help manage Fatigue, Depression, Lack of Appetite.',
    90.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Cherry Grapefruit (1000mg) | Ganjavores DC',
    'Energetic, Uplifted, Creative'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg (1.0g)', 60.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'cherry-grapefruit-1000mg'), 'Terpinolene', NULL, 0),
  ((select id from products where slug = 'cherry-grapefruit-1000mg'), 'Myrcene', NULL, 1),
  ((select id from products where slug = 'cherry-grapefruit-1000mg'), 'Limonene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'cherry-grapefruit-1000mg'), 'THC', 90.0, 0),
  ((select id from products where slug = 'cherry-grapefruit-1000mg'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Blooberry Z Live Resin Cartridge (1000mg) (Friendly Farms)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'blooberry-z-live-resin-cartridge-1000mg',
    'Blooberry Z Live Resin Cartridge (1000mg)',
    (select id from brands where slug = 'friendly-farms'),
    (select id from categories where slug = 'vapes'),
    'Indica Hybrid',
    'Blueberry x Zkittlez',
    'Ripe Blueberry, Sweet Candy Zkittlez, Fruity Tart',
    'Euphoric, Calming, Full-Body Relaxation',
    'A collaboration featuring The Original Z lineage, Friendly Farms Blooberry Z brings true-to-plant full spectrum live resin to a 1000mg 510 cartridge. Combining ripe blueberry sweetness with the candied fruit explosion of Zkittlez, this strain delivers a smooth, flavorful vapor and balanced, soothing full-body euphoria. Top reported effects: Euphoric, Calming, Full-Body Relaxation. Often chosen to help manage Stress, Muscle Soreness, Mood Disorders.',
    86.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Blooberry Z Live Resin Cartridge (1000mg) | Ganjavores DC',
    'Euphoric, Calming, Full-Body Relaxation'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg (1.0g / .035oz)', 65.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), 'Caryophyllene', NULL, 1),
  ((select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), 'Pinene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), 'THC', 86.0, 0),
  ((select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Wedding Cake (1000mg) (Muha Meds)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'wedding-cake-1000mg',
    'Wedding Cake (1000mg)',
    (select id from brands where slug = 'muha-meds'),
    (select id from categories where slug = 'vapes'),
    'Indica',
    'Triangle Kush x Animal Mints',
    'Vanilla Frosting, Sweet Cake Dough, Earthy Pepper',
    'Relaxed, Euphoric, Body Melt',
    'Muha Meds Wedding Cake is a classic indica vape with rich, decadent flavors of vanilla frosting, sweet baked cake, and peppery earth. Known for its potent physical relaxation and soothing mental euphoria, it’s a go-to choice for evening unwinding and stress relief. Top reported effects: Relaxed, Euphoric, Body Melt. Often chosen to help manage Chronic Pain, Stress, Insomnia.',
    90.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Wedding Cake (1000mg) | Ganjavores DC',
    'Relaxed, Euphoric, Body Melt'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg (1.0g)', 60.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'wedding-cake-1000mg'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'wedding-cake-1000mg'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'wedding-cake-1000mg'), 'Myrcene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'wedding-cake-1000mg'), 'THC', 90.0, 0),
  ((select id from products where slug = 'wedding-cake-1000mg'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Purple Drank Medicated Gummies (1000mg) (Faded Fruits)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'purple-drank-medicated-gummies-1000mg',
    'Purple Drank Medicated Gummies (1000mg)',
    (select id from brands where slug = 'faded-fruits'),
    (select id from categories where slug = 'edibles'),
    'Indica',
    'High-Potency Distillate Infused',
    'Sweet Grape Syrup, Berry Punch',
    'Heavy Sedation, Couch-Lock, Pain Relief',
    'Faded Fruits Purple Drank Gummies bring extreme potency in a classic grape punch confection. Infused with 1000mg total THC in a single pack, these small-batch gummies are made without pesticides and deliver deep indica sedation, full-body tranquility, and long-lasting relief. Top reported effects: Heavy Sedation, Couch-Lock, Pain Relief. Often chosen to help manage Severe Pain, Insomnia, Muscle Spasms.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Purple Drank Medicated Gummies (1000mg) | Ganjavores DC',
    'Heavy Sedation, Couch-Lock, Pain Relief'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg Package', 40.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'purple-drank-medicated-gummies-1000mg'), 'Cannabis Terpene Infused', NULL, 0);

-- ---------------------------------------------------------------
-- Lime Diesel Medicated Gummies (1000mg) (Faded Fruits)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'lime-diesel-medicated-gummies-1000mg',
    'Lime Diesel Medicated Gummies (1000mg)',
    (select id from brands where slug = 'faded-fruits'),
    (select id from categories where slug = 'edibles'),
    'Sativa',
    'High-Potency Distillate Infused',
    'Tart Lime, Sour Diesel Candy, Tangy Citrus',
    'Energetic Buzz, Cerebral Lift, Mood Elevation',
    'Faded Fruits Lime Diesel Medicated Gummies combine bright, zesty lime tartness with high-octane sativa potency. Delivering 1000mg total THC per pouch, these gummies provide an invigorating cerebral buzz and uplifting euphoria perfect for daytime social gatherings and creative projects. Top reported effects: Energetic Buzz, Cerebral Lift, Mood Elevation. Often chosen to help manage Depression, Fatigue, Social Anxiety.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Lime Diesel Medicated Gummies (1000mg) | Ganjavores DC',
    'Energetic Buzz, Cerebral Lift, Mood Elevation'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg Package', 40.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'lime-diesel-medicated-gummies-1000mg'), 'Cannabis Terpene Infused', NULL, 0);

-- ---------------------------------------------------------------
-- Orange Sherbet Medicated Gummies (1000mg) (Faded Fruits)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'orange-sherbet-medicated-gummies-1000mg',
    'Orange Sherbet Medicated Gummies (1000mg)',
    (select id from brands where slug = 'faded-fruits'),
    (select id from categories where slug = 'edibles'),
    'Sativa',
    'High-Potency Distillate Infused',
    'Sweet Orange Cream, Tangerine Candy, Citrus Sherbet',
    'Uplifted, Happy, Focus',
    'Faded Fruits Orange Sherbet Gummies feature a sweet, creamy citrus profile reminiscent of frozen orange creamsicles. Packing 1000mg of THC per package, this sativa-infused edible delivers an uplifting, mood-boosting burst of energy and cheerful euphoria. Top reported effects: Uplifted, Happy, Focus. Often chosen to help manage Chronic Fatigue, Stress, Mood Imbalance.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Orange Sherbet Medicated Gummies (1000mg) | Ganjavores DC',
    'Uplifted, Happy, Focus'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg Package', 40.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'orange-sherbet-medicated-gummies-1000mg'), 'Cannabis Terpene Infused', NULL, 0);

-- ---------------------------------------------------------------
-- Blue Slush Medicated Gummies (1000mg) (Faded Fruits)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'blue-slush-medicated-gummies-1000mg',
    'Blue Slush Medicated Gummies (1000mg)',
    (select id from brands where slug = 'faded-fruits'),
    (select id from categories where slug = 'edibles'),
    'Sativa',
    'High-Potency Distillate Infused',
    'Blue Raspberry Slushie, Sweet Berry Syrup',
    'Euphoric, Uplifting Energy, Stress Relief',
    'Faded Fruits Blue Slush Gummies deliver the sweet and tangy nostalgic flavor of an icy blue raspberry slushie. Infused with 1000mg of high-potency sativa distillate, they produce a quick wave of euphoric happiness and clear-headed energy. Top reported effects: Euphoric, Uplifting Energy, Stress Relief. Often chosen to help manage Daytime Stress, Mild Pain, Fatigue.',
    NULL, -- EDIT ME: THC% not numeric in source sheet
    NULL,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Blue Slush Medicated Gummies (1000mg) | Ganjavores DC',
    'Euphoric, Uplifting Energy, Stress Relief'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg Package', 40.00, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'blue-slush-medicated-gummies-1000mg'), 'Cannabis Terpene Infused', NULL, 0);

-- ---------------------------------------------------------------
-- Gary Payton (Flower) (Cookies)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gary-payton-flower',
    'Gary Payton (Flower)',
    (select id from brands where slug = 'cookies'),
    (select id from categories where slug = 'flower'),
    'Hybrid',
    'The Y (Y Life) x Snowman',
    'Spicy Diesel, Sweet Cream, Subtle Citrus',
    'Uplifting, Focused, Relaxed',
    'Named after the NBA Hall of Famer, Gary Payton is an all-star hybrid developed in collaboration between Cookies and Powerzzz Genetics. Testing at an impressive 31.74% THC, this strain delivers championship-level effects, combining hard-hitting potency with exceptional clarity. Dense, colorful buds coated in frosty trichomes showcase rich purple and dark green tones with fiery orange pistils. Top reported effects: Uplifting, Focused, Relaxed. Often chosen to help manage Depression, Chronic Pain, Social Anxiety.',
    31.74,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gary Payton (Flower) | Ganjavores DC',
    'Uplifting, Focused, Relaxed'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 60.00, true),
  ((select id from new_product), '7g', 110.00, false),
  ((select id from new_product), '14g', 200.00, false),
  ((select id from new_product), '28g', 350.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gary-payton-flower'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'gary-payton-flower'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'gary-payton-flower'), 'Linalool', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gary-payton-flower'), 'THC', 31.74, 0),
  ((select id from products where slug = 'gary-payton-flower'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Blueberry Banana (Cookies)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'blueberry-banana',
    'Blueberry Banana',
    (select id from brands where slug = 'cookies'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Blueberry x Banana Kush lineage',
    'Ripe Blueberries, Tropical Banana, Sweet Fruit',
    'Calming, Happy, Appetite-Stimulating',
    'Experience a luscious fruit basket profile with Cookies Blueberry Banana. This indica-dominant hybrid combines the rich sweetness of fresh blueberries with the tropical notes of ripe banana. Its frosty buds display vibrant hues of forest green with deep purple flecks, delivering a gradual, deeply soothing body buzz while keeping the mind clear. Top reported effects: Calming, Happy, Appetite-Stimulating. Often chosen to help manage Anxiety, Muscle Tension, Nausea.',
    27.18,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Blueberry Banana | Ganjavores DC',
    'Calming, Happy, Appetite-Stimulating'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 45.00, true),
  ((select id from new_product), '7g', 80.00, false),
  ((select id from new_product), '14g', 140.00, false),
  ((select id from new_product), '28g', 200.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'blueberry-banana'), 'Myrcene', NULL, 0),
  ((select id from products where slug = 'blueberry-banana'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'blueberry-banana'), 'Pinene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'blueberry-banana'), 'THC', 27.18, 0),
  ((select id from products where slug = 'blueberry-banana'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- White Truffle (Bargain Budd)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'white-truffle',
    'White Truffle',
    (select id from brands where slug = 'bargain-budd'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Gorilla Butter (Gorilla Glue #4 x Peanut Butter Breath)',
    'Melted Butter, Roasted Hazelnuts, Earthy Truffle, Gas',
    'Cerebral Rush, Deep Relaxation, Tranquility',
    'White Truffle is a luxury indica-dominant phenotype derived from Gorilla Butter. Boasting dense, snow-white nugs blanketed in thick crystal resin, it carries an intoxicating gourmet aroma of savory truffle, melted butter, roasted hazelnuts, and gassy diesel. Testing at 30% THC, it delivers a rapid euphoric rush followed by deep, restorative sedation. Top reported effects: Cerebral Rush, Deep Relaxation, Tranquility. Often chosen to help manage Insomnia, Stress, Chronic Pain.',
    30.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'White Truffle | Ganjavores DC',
    'Cerebral Rush, Deep Relaxation, Tranquility'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 55.00, true),
  ((select id from new_product), '7g', 100.00, false),
  ((select id from new_product), '14g', 180.00, false),
  ((select id from new_product), '28g', 320.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'white-truffle'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'white-truffle'), 'Myrcene', NULL, 1),
  ((select id from products where slug = 'white-truffle'), 'Limonene', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'white-truffle'), 'THC', 30.0, 0),
  ((select id from products where slug = 'white-truffle'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Gary Payton FAT BOY Cartridge (1g) (Cookies)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'gary-payton-fat-boy-cartridge-1g',
    'Gary Payton FAT BOY Cartridge (1g)',
    (select id from brands where slug = 'cookies'),
    (select id from categories where slug = 'vapes'),
    'Indica Hybrid',
    'Snowman x Y Life',
    'Heavy Gas, Sweet Spice, Earthy Diesel',
    'Strong, Heavy Body High, Calming',
    'Cookies FAT BOY 1g Cartridge delivers high-octane potency powered by strain-specific natural cannabis terpenes. The Gary Payton profile hits immediately with heavy diesel fuel and sweet peppery spice, producing a deeply relaxing, heavy full-body stone. Top reported effects: Strong, Heavy Body High, Calming. Often chosen to help manage Severe Pain, Tension, Stress.',
    88.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Gary Payton FAT BOY Cartridge (1g) | Ganjavores DC',
    'Strong, Heavy Body High, Calming'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '1000mg (1.0g)', 59.99, true);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gary-payton-fat-boy-cartridge-1g'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'gary-payton-fat-boy-cartridge-1g'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'gary-payton-fat-boy-cartridge-1g'), 'Linalool', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'gary-payton-fat-boy-cartridge-1g'), 'THC', 88.0, 0),
  ((select id from products where slug = 'gary-payton-fat-boy-cartridge-1g'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- White Runtz 1g Pre-Rolls (5pk / 10pk) (White Runtz)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'white-runtz-1g-pre-rolls-5pk-10pk',
    'White Runtz 1g Pre-Rolls (5pk / 10pk)',
    (select id from brands where slug = 'white-runtz'),
    (select id from categories where slug = 'pre-rolls'),
    'Hybrid',
    'Gelato x Zkittlez',
    'Sweet Candy, Tropical Fruit, Creamy Citrus',
    'Relaxing, Tingly, Euphoric, Long-Lasting',
    'White Runtz is the celebrated cross between Gelato and Zkittlez, famous for its dense trichome coverage and candy-sweet flavor profile. These premium whole-flower 1g pre-rolls deliver a high-terpene punch (featuring over 1% Linalool and Myrcene) that soothes physical discomfort while imparting a tingly, euphoric state. Top reported effects: Relaxing, Tingly, Euphoric, Long-Lasting. Often chosen to help manage Chronic Pain, Anxiety, Stress.',
    22.77,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'White Runtz 1g Pre-Rolls (5pk / 10pk) | Ganjavores DC',
    'Relaxing, Tingly, Euphoric, Long-Lasting'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '5pk', 80.00, true),
  ((select id from new_product), '10pk', 150.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 'Linalool', 1.16, 0),
  ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 'Myrcene', 1.12, 1),
  ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 'Limonene', 0.81, 2),
  ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 'Caryophyllene', 0.63, 3);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 'THC', 22.77, 0),
  ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 'CBD', 1.0, 1);

-- ---------------------------------------------------------------
-- Space Runtz (Ounce Special) (Bargain Budd)
-- ---------------------------------------------------------------
with new_product as (
  insert into products (
    slug, name, brand_id, category_id, strain_type, cross_genetics,
    palate, short_description, description, thc_percent, cbd_percent,
    is_ganjavores_exclusive, is_featured, inventory_count, meta_title, meta_description
  ) values (
    'space-runtz-ounce-special',
    'Space Runtz (Ounce Special)',
    (select id from brands where slug = 'bargain-budd'),
    (select id from categories where slug = 'flower'),
    'Indica Hybrid',
    'Runtz x Candy Rain (Bred by Tiki Madman)',
    'Sweet Pear, Floral Violet, Earthy Fruit',
    'Sleepy, Relaxed, Uplifted',
    'Bred by Tiki Madman from the powerhouse cross of Runtz and Candy Rain, Space Runtz is a premium hybrid testing at 22% THC and 1% CBG. It features a delightful aroma and flavor profile of sweet ripe pear, violet blossoms, and earthy candied gas. Ideal for unwinding, socializing, or managing late-night insomnia and anxiety. Top reported effects: Sleepy, Relaxed, Uplifted. Often chosen to help manage Anxiety (28%), Depression (14%), Insomnia (14%).',
    22.0,
    1.0,
    false,
    false,
    25, -- EDIT ME: placeholder inventory count
    'Space Runtz (Ounce Special) | Ganjavores DC',
    'Sleepy, Relaxed, Uplifted'
  )
  returning id
)
insert into product_variants (product_id, label, price, is_default)
values
  ((select id from new_product), '3.5g', 40.00, true),
  ((select id from new_product), '7g', 75.00, false),
  ((select id from new_product), '14g', 120.00, false),
  ((select id from new_product), '28g', 150.00, false);

insert into product_terpenes (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'space-runtz-ounce-special'), 'Caryophyllene', NULL, 0),
  ((select id from products where slug = 'space-runtz-ounce-special'), 'Limonene', NULL, 1),
  ((select id from products where slug = 'space-runtz-ounce-special'), 'Linalool', NULL, 2);

insert into product_cannabinoids (product_id, name, percent, display_order)
values
  ((select id from products where slug = 'space-runtz-ounce-special'), 'THC', 22.0, 0),
  ((select id from products where slug = 'space-runtz-ounce-special'), 'CBD', 1.0, 1),
  ((select id from products where slug = 'space-runtz-ounce-special'), 'CBG', 1.0, 2);

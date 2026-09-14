-- =====================================================================
-- GANJAVORES DC — COMPREHENSIVE CATALOG UPDATE FROM CSV
-- Source: Cannabis_Product_Descriptions(Product Summary).csv
-- Updated: September 13, 2026
-- 
-- Updates ~30 existing products with CSV pricing, THC%, genetics, descriptions
-- Inserts 5 genuinely new products (Cereal Milk, GMO Cookies, Skittlez Edibles,
--   Gorilla Glue GG4, Chemdawg Live Resin)
-- =====================================================================

BEGIN;

-- =====================================================================
-- SECTION 1: UPDATE EXISTING PRODUCTS WITH CSV PRICING AND DATA
-- =====================================================================

-- ---------------------------------------------------------------
-- Duct Tape (Ganjavores) -- 4-tier pricing, THCa 25%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'duct-tape');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'duct-tape'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'duct-tape'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'duct-tape'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'duct-tape'), '28g', 190.00, false);
UPDATE products SET thc_percent = 25.00, cross_genetics = 'Original Glue (GG#4) x Do-Si-Dos', short_description = 'Relaxed, Sleepy, Euphoric — Diesel, Skunk, Pepper' WHERE slug = 'duct-tape';

-- ---------------------------------------------------------------
-- 91 Octane (Exotic Genetix) -- 4-tier pricing, THCa 25-28%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = '91-octane');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = '91-octane'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = '91-octane'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = '91-octane'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = '91-octane'), '28g', 190.00, false);
UPDATE products SET thc_percent = 28.00, cross_genetics = 'Biscotti x Scotty2hotty', short_description = 'Biscotti x Scotty2hotty — Energetic, Uplifting' WHERE slug = '91-octane';

-- ---------------------------------------------------------------
-- Apple Gelato ICE (Muha Meds) -- Vape $55
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'apple-gelato-ice');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'apple-gelato-ice'), '1g Disposable', 55.00, true);
UPDATE products SET thc_percent = NULL, cross_genetics = NULL, short_description = 'Relaxed, Calm, Happy — Juicy Apple, Creamy Gelato, Fruity' WHERE slug = 'apple-gelato-ice';

-- ---------------------------------------------------------------
-- Bat Sh!t (Cookies) -- 4-tier pricing, UPDATE existing
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'bat-sh-t');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'bat-sh-t'), '3.5g', 55.00, true),
       ((SELECT id FROM products WHERE slug = 'bat-sh-t'), '7g', 100.00, false),
       ((SELECT id FROM products WHERE slug = 'bat-sh-t'), '14g', 180.00, false),
       ((SELECT id FROM products WHERE slug = 'bat-sh-t'), '28g', 320.00, false);
UPDATE products SET thc_percent = NULL, cross_genetics = NULL, short_description = 'Uplifted, Relaxed, Creative — Sweet, Herbal, Citrus' WHERE slug = 'bat-sh-t';

-- ---------------------------------------------------------------
-- Black Cherry Gelato (Cookies) -- 4-tier pricing, THCa 25.82%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'black-cherry-gelato');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'black-cherry-gelato'), '3.5g', 60.00, true),
       ((SELECT id FROM products WHERE slug = 'black-cherry-gelato'), '7g', 110.00, false),
       ((SELECT id FROM products WHERE slug = 'black-cherry-gelato'), '14g', 200.00, false),
       ((SELECT id FROM products WHERE slug = 'black-cherry-gelato'), '28g', 350.00, false);
UPDATE products SET thc_percent = 25.82, cross_genetics = 'Acai x Gelato', short_description = 'Relaxed, Euphoric, Creative — Black Cherry, Gelato Cream, Berry' WHERE slug = 'black-cherry-gelato';

-- ---------------------------------------------------------------
-- Cinnamon Milk (Cookies) -- 4-tier pricing, THCa 19.37%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'cinnamon-milk');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'cinnamon-milk'), '3.5g', 55.00, true),
       ((SELECT id FROM products WHERE slug = 'cinnamon-milk'), '7g', 100.00, false),
       ((SELECT id FROM products WHERE slug = 'cinnamon-milk'), '14g', 180.00, false),
       ((SELECT id FROM products WHERE slug = 'cinnamon-milk'), '28g', 320.00, false);
UPDATE products SET thc_percent = 19.37, cross_genetics = NULL, short_description = 'Relaxed, Uplifted, Focused — Sweet Spice, Creamy Milk, Baked Goods' WHERE slug = 'cinnamon-milk';

-- ---------------------------------------------------------------
-- Blueberry Banana (Cookies Premium Flower) -- 4-tier pricing, THCa 20.25%
-- Note: CSV also lists Blueberry Banana under Wiz Khalifa with different prices
-- This update uses the Cookies Premium Flower version pricing from CSV
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'blueberry-banana-cookies-premium-flower');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'blueberry-banana-cookies-premium-flower'), '3.5g', 55.00, true),
       ((SELECT id FROM products WHERE slug = 'blueberry-banana-cookies-premium-flower'), '7g', 100.00, false),
       ((SELECT id FROM products WHERE slug = 'blueberry-banana-cookies-premium-flower'), '14g', 180.00, false),
       ((SELECT id FROM products WHERE slug = 'blueberry-banana-cookies-premium-flower'), '28g', 320.00, false);
UPDATE products SET thc_percent = 20.25, cross_genetics = NULL, short_description = 'Relaxed, Uplifted, Happy — Blueberry, Banana, Creamy' WHERE slug = 'blueberry-banana-cookies-premium-flower';

-- Also update the plain 'blueberry-banana' (Wiz Khalifa version from batch2) 
-- to match the CSV's second Blueberry Banana entry (THCa 27.18%)
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'blueberry-banana');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'blueberry-banana'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'blueberry-banana'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'blueberry-banana'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'blueberry-banana'), '28g', 200.00, false);
UPDATE products SET thc_percent = 27.18, cross_genetics = 'Blueberry x Banana Kush lineage', short_description = 'Calming, Happy, Appetite-Stimulating — Ripe Blueberries, Tropical Banana, Sweet Fruit' WHERE slug = 'blueberry-banana';

-- ---------------------------------------------------------------
-- Khalifa Kush (Khalifa Kush) -- 4-tier pricing, THCa 29.7%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'khalifa-kush');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'khalifa-kush'), '3.5g', 60.00, true),
       ((SELECT id FROM products WHERE slug = 'khalifa-kush'), '7g', 110.00, false),
       ((SELECT id FROM products WHERE slug = 'khalifa-kush'), '14g', 200.00, false),
       ((SELECT id FROM products WHERE slug = 'khalifa-kush'), '28g', 350.00, false);
UPDATE products SET thc_percent = 29.70, cross_genetics = 'OG Kush lineage (closely guarded)', short_description = 'Calm, Happy, Relaxed, Energetic — Velvety Kush, Citrus, Pepper' WHERE slug = 'khalifa-kush';

-- ---------------------------------------------------------------
-- Gary Payton (Cookies) -- Vape cartridge $55
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'gary-payton');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'gary-payton'), '1g Cartridge', 55.00, true);
UPDATE products SET thc_percent = NULL, cross_genetics = NULL, short_description = 'Uplifted, Relaxed, Creative, Calm — Earthy, Spice, Citrus' WHERE slug = 'gary-payton';

-- ---------------------------------------------------------------
-- Lemonchello (Lemonnade) -- Vape cartridge $55
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'lemonchello');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'lemonchello'), '1g Cartridge', 55.00, true);
UPDATE products SET thc_percent = 86.10, cross_genetics = NULL, short_description = 'Uplifted, Energetic, Focused, Happy — Lemon, Sweet, Earthy' WHERE slug = 'lemonchello';

-- ---------------------------------------------------------------
-- OG Kush Breath (Rythm) -- 4-tier pricing, THCa 28%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'og-kush-breath');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'og-kush-breath'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'og-kush-breath'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'og-kush-breath'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'og-kush-breath'), '28g', 190.00, false);
UPDATE products SET thc_percent = 28.00, cross_genetics = 'Girl Scout Cookies x Unknown (OG Kush lineage)', short_description = 'Relaxed, Sleepy, Euphoric — Nutty, Vanilla, Earthy Diesel' WHERE slug = 'og-kush-breath';

-- ---------------------------------------------------------------
-- Cultivar Collection Whole Flower (Cultivar Collection by Trulieve) -- 4-tier pricing
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'cultivar-collection-whole-flower');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'cultivar-collection-whole-flower'), '3.5g', 60.00, true),
       ((SELECT id FROM products WHERE slug = 'cultivar-collection-whole-flower'), '7g', 110.00, false),
       ((SELECT id FROM products WHERE slug = 'cultivar-collection-whole-flower'), '14g', 200.00, false),
       ((SELECT id FROM products WHERE slug = 'cultivar-collection-whole-flower'), '28g', 350.00, false);
UPDATE products SET thc_percent = 29.00, cross_genetics = 'Select Proprietary Genetics', short_description = 'Euphoric, Balanced, Body Melt — Citrus, Floral Spice, Earthy Pine' WHERE slug = 'cultivar-collection-whole-flower';

-- ---------------------------------------------------------------
-- Green Crack (Ganjavores) -- 4-tier pricing, THCa 24%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'green-crack-ganjavores');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'green-crack-ganjavores'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'green-crack-ganjavores'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'green-crack-ganjavores'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'green-crack-ganjavores'), '28g', 190.00, false);
UPDATE products SET thc_percent = 24.00, cross_genetics = 'Skunk #1 x Unknown Indica', short_description = 'Energetic, Focused, Uplifted — Tangy Citrus, Sweet Tropical Mango, Earthy' WHERE slug = 'green-crack-ganjavores';

-- ---------------------------------------------------------------
-- Jenny Kush (Cultivation Labs) -- 4-tier pricing, THCa 32%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'jenny-kush-cultivation-labs');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'jenny-kush-cultivation-labs'), '3.5g', 65.00, true),
       ((SELECT id FROM products WHERE slug = 'jenny-kush-cultivation-labs'), '7g', 120.00, false),
       ((SELECT id FROM products WHERE slug = 'jenny-kush-cultivation-labs'), '14g', 220.00, false),
       ((SELECT id FROM products WHERE slug = 'jenny-kush-cultivation-labs'), '28g', 380.00, false);
UPDATE products SET thc_percent = 32.00, cross_genetics = 'Amnesia Haze x Rare Dankness #2', short_description = 'Uplifting, Cerebral Rush, Blissful Euphoria — Sweet Floral Citrus, Delicate Pine, Herbal Zest' WHERE slug = 'jenny-kush-cultivation-labs';

-- ---------------------------------------------------------------
-- Rythm Hybrid Whole Flower (Rythm) -- 4-tier pricing, THCa 27%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'rythm-hybrid-whole-flower');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'rythm-hybrid-whole-flower'), '3.5g', 55.00, true),
       ((SELECT id FROM products WHERE slug = 'rythm-hybrid-whole-flower'), '7g', 100.00, false),
       ((SELECT id FROM products WHERE slug = 'rythm-hybrid-whole-flower'), '14g', 180.00, false),
       ((SELECT id FROM products WHERE slug = 'rythm-hybrid-whole-flower'), '28g', 320.00, false);
UPDATE products SET thc_percent = 27.00, cross_genetics = 'Proprietary Hybrid Lineage', short_description = 'Balanced, Relaxed, Clear-Headed — Crisp Citrus Diesel, Pine, Earthy Sweetness' WHERE slug = 'rythm-hybrid-whole-flower';

-- ---------------------------------------------------------------
-- Sour Diesel (Ganjavores) -- 4-tier pricing, THCa 26%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'sour-diesel');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'sour-diesel'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'sour-diesel'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'sour-diesel'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'sour-diesel'), '28g', 190.00, false);
UPDATE products SET thc_percent = 26.00, cross_genetics = 'Chemdawg 91 x Super Skunk', short_description = 'Invigorating, Creative, Euphoric Rush — Pungent Fuel, Sour Lemon, Skunky Diesel' WHERE slug = 'sour-diesel';

-- ---------------------------------------------------------------
-- Watermelon Slices Sour Gummies (Devour) -- $65, 1500mg
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'watermelon-slices-sour-gummies-1500mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'watermelon-slices-sour-gummies-1500mg'), '1500mg (10 pieces)', 65.00, true);
UPDATE products SET thc_percent = 1500, cross_genetics = NULL, short_description = 'Deep Sedation, Heavy Body Melt, Euphoria — Sour Watermelon, Sweet Candy' WHERE slug = 'watermelon-slices-sour-gummies-1500mg';

-- ---------------------------------------------------------------
-- High Crawlers Sour Worms (Devour) -- $65, 1500mg
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'high-crawlers-sour-worms-1500mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'high-crawlers-sour-worms-1500mg'), '1500mg (10 pieces)', 65.00, true);
UPDATE products SET thc_percent = 1500, cross_genetics = NULL, short_description = 'Relaxing, Mood Elevation, Body Euphoria — Sour Fruit Medley (Cherry, Lemon, Blue Razz)' WHERE slug = 'high-crawlers-sour-worms-1500mg';

-- ---------------------------------------------------------------
-- Purple Punch 1000mg (Muha Meds) -- $60, vape
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'purple-punch-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'purple-punch-1000mg'), '1g Disposable', 60.00, true);
UPDATE products SET thc_percent = 85.00, cross_genetics = 'Larry OG x Granddaddy Purple', short_description = 'Relaxed, Sleepy, Euphoric — Sweet Grape, Berry Candy, Tart Fruit' WHERE slug = 'purple-punch-1000mg';

-- ---------------------------------------------------------------
-- Cherry Grapefruit 1000mg (Muha Meds) -- $60, vape
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'cherry-grapefruit-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'cherry-grapefruit-1000mg'), '1g Disposable', 60.00, true);
UPDATE products SET thc_percent = 85.00, cross_genetics = 'Cherry Pie x Grapefruit', short_description = 'Energetic, Uplifted, Creative — Tart Cherry, Zesty Grapefruit, Citrus Punch' WHERE slug = 'cherry-grapefruit-1000mg';

-- ---------------------------------------------------------------
-- Blooberry Z Live Resin Cartridge (Friendly Farms) -- $65, vape
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'blooberry-z-live-resin-cartridge-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'blooberry-z-live-resin-cartridge-1000mg'), '1g Cartridge', 65.00, true);
UPDATE products SET thc_percent = 80.00, cross_genetics = 'Blueberry x Zkittlez', short_description = 'Euphoric, Calming, Full-Body Relaxation — Ripe Blueberry, Sweet Candy Zkittlez, Fruity Tart' WHERE slug = 'blooberry-z-live-resin-cartridge-1000mg';

-- ---------------------------------------------------------------
-- Wedding Cake 1000mg (Muha Meds) -- $60, vape
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'wedding-cake-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'wedding-cake-1000mg'), '1g Disposable', 60.00, true);
UPDATE products SET thc_percent = 85.00, cross_genetics = 'Triangle Kush x Animal Mints', short_description = 'Relaxed, Euphoric, Body Melt — Vanilla Frosting, Sweet Cake Dough, Earthy Pepper' WHERE slug = 'wedding-cake-1000mg';

-- ---------------------------------------------------------------
-- Purple Drank Medicated Gummies (Faded Fruits) -- $40
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'purple-drank-medicated-gummies-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'purple-drank-medicated-gummies-1000mg'), '1000mg Package', 40.00, true);
UPDATE products SET thc_percent = 1000, cross_genetics = NULL, short_description = 'Heavy Sedation, Couch-Lock, Pain Relief — Sweet Grape Syrup, Berry Punch' WHERE slug = 'purple-drank-medicated-gummies-1000mg';

-- ---------------------------------------------------------------
-- Lime Diesel Medicated Gummies (Faded Fruits) -- $40
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'lime-diesel-medicated-gummies-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'lime-diesel-medicated-gummies-1000mg'), '1000mg Package', 40.00, true);
UPDATE products SET thc_percent = 1000, cross_genetics = NULL, short_description = 'Energetic Buzz, Cerebral Lift, Mood Elevation — Tart Lime, Sour Diesel Candy, Tangy Citrus' WHERE slug = 'lime-diesel-medicated-gummies-1000mg';

-- ---------------------------------------------------------------
-- Orange Sherbet Medicated Gummies (Faded Fruits) -- $40
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'orange-sherbet-medicated-gummies-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'orange-sherbet-medicated-gummies-1000mg'), '1000mg Package', 40.00, true);
UPDATE products SET thc_percent = 1000, cross_genetics = NULL, short_description = 'Uplifted, Happy, Focus — Sweet Orange Cream, Tangerine Candy, Citrus Sherbet' WHERE slug = 'orange-sherbet-medicated-gummies-1000mg';

-- ---------------------------------------------------------------
-- Blue Slush Medicated Gummies (Faded Fruits) -- $40
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'blue-slush-medicated-gummies-1000mg');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'blue-slush-medicated-gummies-1000mg'), '1000mg Package', 40.00, true);
UPDATE products SET thc_percent = 1000, cross_genetics = NULL, short_description = 'Euphoric, Uplifting Energy, Stress Relief — Blue Raspberry Slushie, Sweet Berry Syrup' WHERE slug = 'blue-slush-medicated-gummies-1000mg';

-- ---------------------------------------------------------------
-- Gary Payton (Flower) (Cookies) -- 4-tier pricing, THCa 31.74%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'gary-payton-flower');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'gary-payton-flower'), '3.5g', 60.00, true),
       ((SELECT id FROM products WHERE slug = 'gary-payton-flower'), '7g', 110.00, false),
       ((SELECT id FROM products WHERE slug = 'gary-payton-flower'), '14g', 200.00, false),
       ((SELECT id FROM products WHERE slug = 'gary-payton-flower'), '28g', 350.00, false);
UPDATE products SET thc_percent = 31.74, cross_genetics = 'The Y (Y Life) x Snowman', short_description = 'Uplifting, Focused, Relaxed — Spicy Diesel, Sweet Cream, Subtle Citrus' WHERE slug = 'gary-payton-flower';

-- ---------------------------------------------------------------
-- White Truffle (Ganjavores) -- 4-tier pricing, THCa 30%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'white-truffle');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'white-truffle'), '3.5g', 55.00, true),
       ((SELECT id FROM products WHERE slug = 'white-truffle'), '7g', 100.00, false),
       ((SELECT id FROM products WHERE slug = 'white-truffle'), '14g', 180.00, false),
       ((SELECT id FROM products WHERE slug = 'white-truffle'), '28g', 320.00, false);
UPDATE products SET thc_percent = 30.00, cross_genetics = 'Gorilla Butter (Gorilla Glue #4 x Peanut Butter Breath)', short_description = 'Cerebral Rush, Deep Relaxation, Tranquility — Melted Butter, Roasted Hazelnuts, Earthy Truffle, Gas' WHERE slug = 'white-truffle';

-- ---------------------------------------------------------------
-- Gary Payton FAT BOY Cartridge (Cookies) -- $59.99, vape
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'gary-payton-fat-boy-cartridge-1g');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'gary-payton-fat-boy-cartridge-1g'), '1g Cartridge', 59.99, true);
UPDATE products SET thc_percent = 84.00, cross_genetics = 'Snowman x Y Life', short_description = 'Strong, Heavy Body High, Calming — Heavy Gas, Sweet Spice, Earthy Diesel' WHERE slug = 'gary-payton-fat-boy-cartridge-1g';

-- ---------------------------------------------------------------
-- Space Runtz (Ganjavores) -- Ounce special, 28g $150
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'space-runtz-ounce-special');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'space-runtz-ounce-special'), '28g (Ounce)', 150.00, true);
UPDATE products SET thc_percent = 22.00, cross_genetics = 'Runtz x Candy Rain (Bred by Tiki Madman)', short_description = 'Sleepy, Relaxed, Uplifted — Sweet Pear, Floral Violet, Earthy Fruit' WHERE slug = 'space-runtz-ounce-special';

-- ---------------------------------------------------------------
-- OGKB 2.1 (Loud Flower) -- 4-tier pricing, THCa 30%
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'ogkb-2-1');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'ogkb-2-1'), '3.5g', 65.00, true),
       ((SELECT id FROM products WHERE slug = 'ogkb-2-1'), '7g', 120.00, false),
       ((SELECT id FROM products WHERE slug = 'ogkb-2-1'), '14g', 220.00, false),
       ((SELECT id FROM products WHERE slug = 'ogkb-2-1'), '28g', 380.00, false);
UPDATE products SET thc_percent = 30.00, cross_genetics = 'OGKB x Dosidos', short_description = 'Heavy Body Melt, Couch-Lock, Sedative — Toasted Vanilla, Earthy Dough, Heavy Gas' WHERE slug = 'ogkb-2-1';

-- ---------------------------------------------------------------
-- Gelato #33 / Larry Bird (Jungle Boys) -- 4-tier pricing, THCa 31%
-- Note: Already exists as gelato-33 from batch2 — update with real pricing
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'gelato-33');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'gelato-33'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'gelato-33'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'gelato-33'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'gelato-33'), '28g', 190.00, false);
UPDATE products SET thc_percent = 31.00, cross_genetics = 'Sunset Sherbet x Thin Mint GSC', short_description = 'Euphoric, Sensory Enhancement, Deep Relaxation — Sweet Berry Sherbet, Creamy Citrus, Subtle Gas' WHERE slug = 'gelato-33';

-- ---------------------------------------------------------------
-- White Runtz 1g Pre-Rolls (White Runtz) -- 5pk $70, 10pk $130
-- ---------------------------------------------------------------
DELETE FROM product_variants WHERE product_id = (SELECT id FROM products WHERE slug = 'white-runtz-1g-pre-rolls-5pk-10pk');
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), '5-Pack (5g)', 70.00, true),
       ((SELECT id FROM products WHERE slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), '10-Pack (10g)', 130.00, false);
UPDATE products SET thc_percent = 22.77, cross_genetics = 'Gelato x Zkittlez', short_description = 'Relaxing, Tingly, Euphoric, Long-Lasting — Sweet Candy, Tropical Fruit, Creamy Citrus' WHERE slug = 'white-runtz-1g-pre-rolls-5pk-10pk';

-- ---------------------------------------------------------------
-- Cereal Milk (Cookies) -- NEW product, no prior entry
-- Note: This is a NEW product not in the database. Will be handled in Section 2.
-- Remove the update above and add to INSERT section instead.
-- ---------------------------------------------------------------

-- =====================================================================
-- SECTION 2: INSERT NEW PRODUCTS FROM CSV
-- =====================================================================

-- These products exist in the CSV but NOT in the database SQL files.
-- They need full INSERT statements including brand and category creation.

-- ---------------------------------------------------------------
-- Cereal Milk (Cookies) — NEW Flower product
-- ---------------------------------------------------------------
INSERT INTO products (slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description)
VALUES (
    'cereal-milk', 'Cereal Milk',
    (SELECT id FROM brands WHERE slug = 'cookies'),
    (SELECT id FROM categories WHERE slug = 'flower'),
    'Hybrid', NULL, 'Sweet Spice, Creamy Milk, Baked Goods',
    'Cereal Milk, a delectable hybrid strain from Cookies, is a standout for cannabis connoisseurs seeking a unique and flavorful experience. Born from a carefully selected genetic lineage, this strain boasts dense, frosty buds with subtle amber hues, making it as visually enticing as it is potent. Renowned for its creamy, dessert-like aroma and smooth effects, Cinnamon Milk offers a balanced high that soothes the body while keeping the mind clear and uplifted. Its rich, spice-infused flavor profile and well-rounded effects make it a must-try for those who appreciate premium flower with a touch of indulgence.',
    19.37, False, False, 25,
    'Cereal Milk | Ganjavores DC', 'Relaxed, Uplifted, Focused'
);
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'cereal-milk'), '3.5g', 55.00, true),
       ((SELECT id FROM products WHERE slug = 'cereal-milk'), '7g', 100.00, false),
       ((SELECT id FROM products WHERE slug = 'cereal-milk'), '14g', 180.00, false),
       ((SELECT id FROM products WHERE slug = 'cereal-milk'), '28g', 320.00, false);

-- ---------------------------------------------------------------
-- GMO Cookies (Ganjavores) — NEW Flower product
-- ---------------------------------------------------------------
INSERT INTO products (slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description)
VALUES (
    'gmo-cookies', 'GMO Cookies',
    (SELECT id FROM brands WHERE slug = 'ganjavores-by-lee-farms'),
    (SELECT id FROM categories WHERE slug = 'flower'),
    'Hybrid', NULL, 'To be determined',
    'GMO Cookies, a powerful hybrid strain from Ganjavores by Lee Farms, delivers a potent and memorable experience. Known for its distinctive genetics and strong effects, this strain is a favorite among cannabis enthusiasts seeking something truly different. Dense, frosty buds with a unique aroma profile and robust effects that make it a standout in any collection.',
    NULL, False, False, 25,
    'GMO Cookies | Ganjavores DC', 'Premium Flower, GMO Genetics'
);
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'gmo-cookies'), '3.5g', 45.00, true),
       ((SELECT id FROM products WHERE slug = 'gmo-cookies'), '7g', 80.00, false),
       ((SELECT id FROM products WHERE slug = 'gmo-cookies'), '14g', 140.00, false),
       ((SELECT id FROM products WHERE slug = 'gmo-cookies'), '28g', 200.00, false);

-- ---------------------------------------------------------------
-- Skittlez Medicated Edibles (SKITTLEZ) — NEW Edible product
-- ---------------------------------------------------------------
INSERT INTO products (slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description)
VALUES (
    'skittlez-medicated-edibles-tropical-600mg-pk', 'Skittlez Medicated Edibles - Tropical - 600mg pk',
    (SELECT id FROM brands WHERE slug = 'skittlez'),
    (SELECT id FROM categories WHERE slug = 'edibles'),
    'N/A', NULL, NULL,
    'Tropical Skittlez medicated gummies — 600mg per pack.',
    'Skittlez Medicated Edibles Tropical flavor, 600mg per pack. Infused cannabis gummies with a tropical fruit flavor profile. A sweet and potent edible option for cannabis consumers looking for a familiar candy taste with reliable dosing.',
    NULL, False, False, 25,
    'Skittlez Medicated Edibles Tropical | Ganjavores DC', '600mg Tropical Edibles'
);
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'skittlez-medicated-edibles-tropical-600mg-pk'), '600mg Pack', 30.00, true);

-- ---------------------------------------------------------------
-- Gorilla Glue aka GG4 (Ganjavores) — NEW Flower product
-- ---------------------------------------------------------------
INSERT INTO products (slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description)
VALUES (
    'gorilla-glue-aka-gg4', 'Gorilla Glue aka GG4',
    (SELECT id FROM brands WHERE slug = 'ganjavores-by-lee-farms'),
    (SELECT id FROM categories WHERE slug = 'flower'),
    'Hybrid', NULL, 'To be determined',
    'Gorilla Glue aka GG4 — Premium flower, potent hybrid.',
    'Gorilla Glue aka GG4 from Ganjavores by Lee Farms — a legendary, high-THC hybrid strain known for its sticky, resin-dense buds and powerful effects. Dense, trichome-covered nugs with a pungent earthy aroma and a heavy, couch-locking body high. A shelf staple for anyone seeking maximum potency from the Ganjavores house line.',
    NULL, True, False, 25,
    'Gorilla Glue aka GG4 | Ganjavores DC', 'Premium Flower, Potent Hybrid'
);
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'gorilla-glue-aka-gg4'), '3.5g', 30.00, true),
       ((SELECT id FROM products WHERE slug = 'gorilla-glue-aka-gg4'), '7g', 60.00, false),
       ((SELECT id FROM products WHERE slug = 'gorilla-glue-aka-gg4'), '14g', 120.00, false),
       ((SELECT id FROM products WHERE slug = 'gorilla-glue-aka-gg4'), '28g', 200.00, false);

-- ---------------------------------------------------------------
-- Bat Sh!t (Cookies) — Already exists, but was missed in Section 1 update
-- Note: Already handled above in Section 1. This is just a safety net.
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- Chemdawg Live Resin Disposable Straw (Jeeter Juice) — NEW vape product
-- ---------------------------------------------------------------
INSERT INTO products (slug, name, brand_id, category_id, strain_type, cross_genetics, palate,
    short_description, description, thc_percent, is_ganjavores_exclusive,
    is_featured, inventory_count, meta_title, meta_description)
VALUES (
    'chemdawg-live-resin-disposable-straw', 'Chemdawg Live Resin Disposable Straw',
    (SELECT id FROM brands WHERE slug = 'jeeter'),
    (SELECT id FROM categories WHERE slug = 'vapes'),
    'Indica', NULL, '100% Live Resin Disposable Straw (500mg)',
    'Chemdawg Live Resin from Jeeter Juice — full gram disposable, 500mg, 100% live resin. Classic Chemdawg genetics in a convenient disposable format. Known for its potent effects and distinctive fuel-forward aroma. Built for winding all the way down.',
    'Chemdawg Live Resin Disposable Straw from Jeeter Juice. Fresh-squeezed live resin with no additives, single-source extraction. Chemdawg genetics deliver a sharp, fuel-forward nose with heavy body effects. A full-gram disposable straw-style pen for convenient, potent consumption. The classic Chemdawg profile — piney, earthy, gas-forward — in a modern disposable format.',
    NULL, False, False, 25,
    'Chemdawg Live Resin Disposable Straw | Ganjavores DC', 'Full gram live resin disposable, Chemdawg flavor'
);
INSERT INTO product_variants (product_id, label, price, is_default) VALUES
       ((SELECT id FROM products WHERE slug = 'chemdawg-live-resin-disposable-straw'), '500mg (0.5g)', 65.00, true);

-- =====================================================================
-- SECTION 3: ADD NEW BRANDS REQUIRED BY NEW PRODUCTS
-- =====================================================================

-- Check if skittlez brand exists, if not add it
INSERT INTO brands (name, slug, is_house_brand)
SELECT 'SKITTLEZ', 'skittlez', false
WHERE NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'skittlez');

-- =====================================================================
-- COMMIT
-- =====================================================================

COMMIT;
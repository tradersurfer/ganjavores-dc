-- =====================================================================
-- GANJAVORES DC — product images from Ganjavores_DC_Product_Catalog_Handoff.zip
-- 30 real product images matched to existing catalog rows. Run this AFTER
-- schema.sql + seed-products.sql + seed-products-batch2.sql +
-- seed-products-batch3.sql (and cleanup-duplicates.sql if you'd already run
-- an earlier buggy version of batch3).
--
-- Uses ON CONFLICT-safe pattern: deletes any existing image at display_order 0
-- for that product first, so re-running this is safe and won't create dupes.
-- =====================================================================

-- og-kush-breath
delete from product_images where product_id = (select id from products where slug = 'og-kush-breath') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'og-kush-breath'), '/products/flower/og-kush-breath.png', (select name from products where slug = 'og-kush-breath'), 0);

-- cultivar-collection-whole-flower
delete from product_images where product_id = (select id from products where slug = 'cultivar-collection-whole-flower') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'cultivar-collection-whole-flower'), '/products/flower/cultivar-collection-whole-flower.png', (select name from products where slug = 'cultivar-collection-whole-flower'), 0);

-- green-crack-ganjavores
delete from product_images where product_id = (select id from products where slug = 'green-crack-ganjavores') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'green-crack-ganjavores'), '/products/flower/green-crack-ganjavores.png', (select name from products where slug = 'green-crack-ganjavores'), 0);

-- gelato-33
delete from product_images where product_id = (select id from products where slug = 'gelato-33') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'gelato-33'), '/products/flower/gelato-33.png', (select name from products where slug = 'gelato-33'), 0);

-- ogkb-2-1
delete from product_images where product_id = (select id from products where slug = 'ogkb-2-1') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'ogkb-2-1'), '/products/flower/ogkb-2-1.png', (select name from products where slug = 'ogkb-2-1'), 0);

-- jenny-kush-cultivation-labs
delete from product_images where product_id = (select id from products where slug = 'jenny-kush-cultivation-labs') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jenny-kush-cultivation-labs'), '/products/flower/jenny-kush-cultivation-labs.png', (select name from products where slug = 'jenny-kush-cultivation-labs'), 0);

-- rythm-hybrid-whole-flower
delete from product_images where product_id = (select id from products where slug = 'rythm-hybrid-whole-flower') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'rythm-hybrid-whole-flower'), '/products/flower/rythm-hybrid-whole-flower.png', (select name from products where slug = 'rythm-hybrid-whole-flower'), 0);

-- sour-diesel
delete from product_images where product_id = (select id from products where slug = 'sour-diesel') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'sour-diesel'), '/products/flower/sour-diesel.png', (select name from products where slug = 'sour-diesel'), 0);

-- watermelon-slices-sour-gummies-1500mg
delete from product_images where product_id = (select id from products where slug = 'watermelon-slices-sour-gummies-1500mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'watermelon-slices-sour-gummies-1500mg'), '/products/edibles/watermelon-slices-sour-gummies-1500mg.png', (select name from products where slug = 'watermelon-slices-sour-gummies-1500mg'), 0);

-- high-crawlers-sour-worms-1500mg
delete from product_images where product_id = (select id from products where slug = 'high-crawlers-sour-worms-1500mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'high-crawlers-sour-worms-1500mg'), '/products/edibles/high-crawlers-sour-worms-1500mg.png', (select name from products where slug = 'high-crawlers-sour-worms-1500mg'), 0);

-- purple-punch-1000mg
delete from product_images where product_id = (select id from products where slug = 'purple-punch-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'purple-punch-1000mg'), '/products/vapes/purple-punch-1000mg.png', (select name from products where slug = 'purple-punch-1000mg'), 0);

-- jeeter-juice-live-resin-ice-cream-cake
delete from product_images where product_id = (select id from products where slug = 'jeeter-juice-live-resin-ice-cream-cake') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jeeter-juice-live-resin-ice-cream-cake'), '/products/vapes/jeeter-juice-live-resin-ice-cream-cake.png', (select name from products where slug = 'jeeter-juice-live-resin-ice-cream-cake'), 0);

-- cherry-grapefruit-1000mg
delete from product_images where product_id = (select id from products where slug = 'cherry-grapefruit-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'cherry-grapefruit-1000mg'), '/products/vapes/cherry-grapefruit-1000mg.png', (select name from products where slug = 'cherry-grapefruit-1000mg'), 0);

-- blooberry-z-live-resin-cartridge-1000mg
delete from product_images where product_id = (select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), '/products/vapes/blooberry-z-live-resin-cartridge-1000mg.png', (select name from products where slug = 'blooberry-z-live-resin-cartridge-1000mg'), 0);

-- wedding-cake-1000mg
delete from product_images where product_id = (select id from products where slug = 'wedding-cake-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'wedding-cake-1000mg'), '/products/vapes/wedding-cake-1000mg.png', (select name from products where slug = 'wedding-cake-1000mg'), 0);

-- purple-drank-medicated-gummies-1000mg
delete from product_images where product_id = (select id from products where slug = 'purple-drank-medicated-gummies-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'purple-drank-medicated-gummies-1000mg'), '/products/edibles/purple-drank-medicated-gummies-1000mg.png', (select name from products where slug = 'purple-drank-medicated-gummies-1000mg'), 0);

-- lime-diesel-medicated-gummies-1000mg
delete from product_images where product_id = (select id from products where slug = 'lime-diesel-medicated-gummies-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'lime-diesel-medicated-gummies-1000mg'), '/products/edibles/lime-diesel-medicated-gummies-1000mg.png', (select name from products where slug = 'lime-diesel-medicated-gummies-1000mg'), 0);

-- orange-sherbet-medicated-gummies-1000mg
delete from product_images where product_id = (select id from products where slug = 'orange-sherbet-medicated-gummies-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'orange-sherbet-medicated-gummies-1000mg'), '/products/edibles/orange-sherbet-medicated-gummies-1000mg.png', (select name from products where slug = 'orange-sherbet-medicated-gummies-1000mg'), 0);

-- blue-slush-medicated-gummies-1000mg
delete from product_images where product_id = (select id from products where slug = 'blue-slush-medicated-gummies-1000mg') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'blue-slush-medicated-gummies-1000mg'), '/products/edibles/blue-slush-medicated-gummies-1000mg.png', (select name from products where slug = 'blue-slush-medicated-gummies-1000mg'), 0);

-- jeeter-juice-live-resin-papaya-5
delete from product_images where product_id = (select id from products where slug = 'jeeter-juice-live-resin-papaya-5') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jeeter-juice-live-resin-papaya-5'), '/products/vapes/jeeter-juice-live-resin-papaya-5.png', (select name from products where slug = 'jeeter-juice-live-resin-papaya-5'), 0);

-- jeeter-juice-live-resin-do-si-lato
delete from product_images where product_id = (select id from products where slug = 'jeeter-juice-live-resin-do-si-lato') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jeeter-juice-live-resin-do-si-lato'), '/products/vapes/jeeter-juice-live-resin-do-si-lato.png', (select name from products where slug = 'jeeter-juice-live-resin-do-si-lato'), 0);

-- jeeter-juice-live-resin-wedding-cake
delete from product_images where product_id = (select id from products where slug = 'jeeter-juice-live-resin-wedding-cake') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jeeter-juice-live-resin-wedding-cake'), '/products/vapes/jeeter-juice-live-resin-wedding-cake.png', (select name from products where slug = 'jeeter-juice-live-resin-wedding-cake'), 0);

-- jeeter-juice-live-resin-papaya
delete from product_images where product_id = (select id from products where slug = 'jeeter-juice-live-resin-papaya') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jeeter-juice-live-resin-papaya'), '/products/vapes/jeeter-juice-live-resin-papaya.png', (select name from products where slug = 'jeeter-juice-live-resin-papaya'), 0);

-- jeeter-juice-live-resin-ice-cream-banana
delete from product_images where product_id = (select id from products where slug = 'jeeter-juice-live-resin-ice-cream-banana') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'jeeter-juice-live-resin-ice-cream-banana'), '/products/vapes/jeeter-juice-live-resin-ice-cream-banana.png', (select name from products where slug = 'jeeter-juice-live-resin-ice-cream-banana'), 0);

-- gary-payton-flower
delete from product_images where product_id = (select id from products where slug = 'gary-payton-flower') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'gary-payton-flower'), '/products/flower/gary-payton-flower.png', (select name from products where slug = 'gary-payton-flower'), 0);

-- blueberry-banana
delete from product_images where product_id = (select id from products where slug = 'blueberry-banana') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'blueberry-banana'), '/products/flower/blueberry-banana.png', (select name from products where slug = 'blueberry-banana'), 0);

-- white-truffle
delete from product_images where product_id = (select id from products where slug = 'white-truffle') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'white-truffle'), '/products/flower/white-truffle.png', (select name from products where slug = 'white-truffle'), 0);

-- gary-payton-fat-boy-cartridge-1g
delete from product_images where product_id = (select id from products where slug = 'gary-payton-fat-boy-cartridge-1g') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'gary-payton-fat-boy-cartridge-1g'), '/products/vapes/gary-payton-fat-boy-cartridge-1g.png', (select name from products where slug = 'gary-payton-fat-boy-cartridge-1g'), 0);

-- white-runtz-1g-pre-rolls-5pk-10pk
delete from product_images where product_id = (select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), '/products/pre-rolls/white-runtz-1g-pre-rolls-5pk-10pk.png', (select name from products where slug = 'white-runtz-1g-pre-rolls-5pk-10pk'), 0);

-- space-runtz-ounce-special
delete from product_images where product_id = (select id from products where slug = 'space-runtz-ounce-special') and display_order = 0;
insert into product_images (product_id, url, alt_text, display_order)
values ((select id from products where slug = 'space-runtz-ounce-special'), '/products/flower/space-runtz-ounce-special.png', (select name from products where slug = 'space-runtz-ounce-special'), 0);

-- =====================================================================
-- SAFETY CLEANUP — only needed if you already ran an earlier copy of
-- seed-products-batch3.sql before this fix. Harmless to run even if you
-- haven't — it just won't find anything to delete.
--
-- The original seed-products-batch3.sql had a bug: it updated batch1's
-- 6 Jeeter Juice products with real pricing (correct) AND ALSO inserted
-- those same 6 flavors again under different names ("Ice Cream Cake Live
-- Resin Disposable Straw" etc), creating duplicate listings. This deletes
-- the 6 duplicates. Cascades automatically clean up their variants/
-- terpenes/cannabinoids (see schema.sql's ON DELETE CASCADE).
-- =====================================================================

delete from products where name in (
  'Ice Cream Cake Live Resin Disposable Straw',
  'Papaya #5 Live Resin Disposable Straw',
  'Do-Si-Lato Live Resin Disposable Straw',
  'Wedding Cake Live Resin Disposable Straw',
  'Papaya Live Resin Disposable Straw',
  'Ice Cream Banana Live Resin Disposable Straw'
)
and brand_id = (select id from brands where slug = 'jeeter');

delete from products where name = 'Gelato #33 (Larry Bird)'
and brand_id = (select id from brands where slug = 'jungle-boys');

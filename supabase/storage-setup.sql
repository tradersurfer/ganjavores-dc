-- =====================================================================
-- STORAGE SETUP — run this once against your Supabase project.
-- Creates a public bucket for product/brand images uploaded through the
-- admin panel, plus policies so only authenticated admins can write to
-- it (anyone can read, since these are public product photos).
-- =====================================================================

insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

create policy "public read product images"
  on storage.objects for select
  using (bucket_id = 'product-images');

create policy "admins can upload product images"
  on storage.objects for insert
  with check (
    bucket_id = 'product-images'
    and exists (select 1 from admin_profiles where id = auth.uid())
  );

create policy "admins can update product images"
  on storage.objects for update
  using (
    bucket_id = 'product-images'
    and exists (select 1 from admin_profiles where id = auth.uid())
  );

create policy "admins can delete product images"
  on storage.objects for delete
  using (
    bucket_id = 'product-images'
    and exists (select 1 from admin_profiles where id = auth.uid())
  );

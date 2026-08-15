-- =====================================================================
-- ADDITIVE MIGRATION — contact form submissions (/contact page).
-- Not part of the original schema.sql; run this once alongside it.
-- =====================================================================

create table if not exists contact_messages (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  email text not null,
  phone text,
  subject text,
  message text not null,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

alter table contact_messages enable row level security;

create policy "public can submit contact messages"
  on contact_messages for insert with check (true);

create policy "admins can read contact messages"
  on contact_messages for select using (
    exists (select 1 from admin_profiles where id = auth.uid())
  );

create policy "admins can update contact messages"
  on contact_messages for update using (
    exists (select 1 from admin_profiles where id = auth.uid())
  );

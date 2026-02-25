-- BrideSide Database Schema
-- Run this in: Supabase Dashboard → SQL Editor → New Query

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- ============================================================
-- USERS (extends Supabase auth.users)
-- ============================================================
create table public.users (
  id uuid references auth.users(id) on delete cascade primary key,
  email text not null,
  full_name text,
  role text check (role in ('bride', 'planner')),
  avatar_url text,
  onboarding_complete boolean default false,
  created_at timestamptz default now()
);

-- Row Level Security
alter table public.users enable row level security;

create policy "Users can view their own profile"
  on public.users for select using (auth.uid() = id);

create policy "Users can update their own profile"
  on public.users for update using (auth.uid() = id);

create policy "Users can insert their own profile"
  on public.users for insert with check (auth.uid() = id);

-- ============================================================
-- WEDDINGS
-- ============================================================
create table public.weddings (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  couple_name text not null,
  wedding_date date,
  venue text,
  estimated_guests integer,
  color_palette jsonb default '[]',
  theme text,
  website_slug text unique,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.weddings enable row level security;

create policy "Users can manage their own weddings"
  on public.weddings for all using (auth.uid() = user_id);

-- ============================================================
-- MOODBOARDS
-- ============================================================
create table public.moodboards (
  id uuid default uuid_generate_v4() primary key,
  wedding_id uuid references public.weddings(id) on delete cascade not null,
  title text not null,
  style_tags text[] default '{}',
  images jsonb default '[]',
  ai_prompt text,
  created_at timestamptz default now()
);

alter table public.moodboards enable row level security;

create policy "Users can manage moodboards for their weddings"
  on public.moodboards for all
  using (
    wedding_id in (
      select id from public.weddings where user_id = auth.uid()
    )
  );

-- ============================================================
-- GUESTS
-- ============================================================
create table public.guests (
  id uuid default uuid_generate_v4() primary key,
  wedding_id uuid references public.weddings(id) on delete cascade not null,
  name text not null,
  email text,
  phone text,
  "group" text,
  invite_sent boolean default false,
  rsvp_status text default 'pending' check (rsvp_status in ('pending', 'attending', 'declined')),
  meal_preference text,
  plus_one boolean default false,
  notes text,
  created_at timestamptz default now()
);

alter table public.guests enable row level security;

create policy "Users can manage guests for their weddings"
  on public.guests for all
  using (
    wedding_id in (
      select id from public.weddings where user_id = auth.uid()
    )
  );

-- ============================================================
-- INVITATIONS
-- ============================================================
create table public.invitations (
  id uuid default uuid_generate_v4() primary key,
  wedding_id uuid references public.weddings(id) on delete cascade not null,
  template_id text,
  subject text,
  message text,
  rsvp_token text unique default encode(gen_random_bytes(24), 'hex'),
  sent_at timestamptz,
  created_at timestamptz default now()
);

alter table public.invitations enable row level security;

create policy "Users can manage invitations for their weddings"
  on public.invitations for all
  using (
    wedding_id in (
      select id from public.weddings where user_id = auth.uid()
    )
  );

-- ============================================================
-- VENDORS (Coming next)
-- ============================================================
create table public.vendors (
  id uuid default uuid_generate_v4() primary key,
  wedding_id uuid references public.weddings(id) on delete cascade not null,
  category text,
  name text not null,
  contact text,
  price numeric(10,2),
  status text default 'considering' check (status in ('booked', 'contacted', 'considering')),
  notes text,
  created_at timestamptz default now()
);

alter table public.vendors enable row level security;

create policy "Users can manage vendors for their weddings"
  on public.vendors for all
  using (
    wedding_id in (
      select id from public.weddings where user_id = auth.uid()
    )
  );

-- ============================================================
-- BUDGET ITEMS (Coming next)
-- ============================================================
create table public.budget_items (
  id uuid default uuid_generate_v4() primary key,
  wedding_id uuid references public.weddings(id) on delete cascade not null,
  category text,
  description text,
  estimated numeric(10,2),
  actual numeric(10,2),
  paid boolean default false,
  created_at timestamptz default now()
);

alter table public.budget_items enable row level security;

create policy "Users can manage budget items for their weddings"
  on public.budget_items for all
  using (
    wedding_id in (
      select id from public.weddings where user_id = auth.uid()
    )
  );

-- ============================================================
-- Auto-update updated_at trigger
-- ============================================================
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger weddings_updated_at
  before update on public.weddings
  for each row execute function update_updated_at();

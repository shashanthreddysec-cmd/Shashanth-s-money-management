create table if not exists public.money_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"version":2,"opening":{"bank":0,"lite":0,"cash":0},"tx":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.money_data enable row level security;

create policy "Users can read their own money data"
  on public.money_data for select using (auth.uid() = user_id);
create policy "Users can insert their own money data"
  on public.money_data for insert with check (auth.uid() = user_id);
create policy "Users can update their own money data"
  on public.money_data for update using (auth.uid() = user_id);

create or replace function public.touch_money_data_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;

drop trigger if exists money_data_updated_at on public.money_data;
create trigger money_data_updated_at before update on public.money_data
for each row execute function public.touch_money_data_updated_at();

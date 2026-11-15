create table if not exists public.money_data (
  user_id uuid primary key,
  payload jsonb not null default '{"version":2,"opening":{"bank":0,"lite":0,"cash":0},"tx":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.money_data enable row level security;

alter table public.money_data drop constraint if exists money_data_user_id_fkey;
do $$
declare policy_name text;
begin
  for policy_name in
    select policyname from pg_policies where schemaname = 'public' and tablename = 'money_data'
  loop
    execute format('drop policy if exists %I on public.money_data', policy_name);
  end loop;
end $$;
drop policy if exists "Users can read their own money data" on public.money_data;
drop policy if exists "Users can insert their own money data" on public.money_data;
drop policy if exists "Users can update their own money data" on public.money_data;
drop policy if exists "Public sync read" on public.money_data;
drop policy if exists "Public sync insert" on public.money_data;
drop policy if exists "Public sync update" on public.money_data;
create policy "Public sync read" on public.money_data for select using (true);
create policy "Public sync insert" on public.money_data for insert with check (true);
create policy "Public sync update" on public.money_data for update using (true) with check (true);

create or replace function public.touch_money_data_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;

drop trigger if exists money_data_updated_at on public.money_data;
create trigger money_data_updated_at before update on public.money_data
for each row execute function public.touch_money_data_updated_at();

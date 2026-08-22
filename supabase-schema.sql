create table if not exists public.budget_state (
  id text primary key,
  state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.budget_state enable row level security;

drop policy if exists "Public can read budget state" on public.budget_state;
create policy "Public can read budget state"
  on public.budget_state for select
  to anon
  using (id = 'family');

drop policy if exists "Public can write budget state" on public.budget_state;
create policy "Public can write budget state"
  on public.budget_state for insert
  to anon
  with check (id = 'family');

drop policy if exists "Public can update budget state" on public.budget_state;
create policy "Public can update budget state"
  on public.budget_state for update
  to anon
  using (id = 'family')
  with check (id = 'family');

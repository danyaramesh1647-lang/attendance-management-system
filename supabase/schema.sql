-- =====================================================================
-- Cloud-Based Attendance Management System
-- Supabase PostgreSQL Schema
-- Corrected + Security Hardened Version
-- =====================================================================

create extension if not exists "pgcrypto";

-- =====================================================================
-- PROFILES
-- =====================================================================

create table if not exists public.profiles (
    id uuid primary key references auth.users(id) on delete cascade,
    full_name text not null,
    email text not null unique,
    role text not null default 'student'
        check (role in ('admin', 'student')),
    created_at timestamptz not null default now()
);

-- =====================================================================
-- STUDENTS
-- =====================================================================

create table if not exists public.students (
    id uuid primary key default gen_random_uuid(),
    profile_id uuid unique references public.profiles(id) on delete set null,
    register_number text not null unique,
    full_name text not null,
    email text not null unique,
    department text not null,
    year integer not null check (year between 1 and 5),
    section text not null,
    created_at timestamptz not null default now()
);

-- =====================================================================
-- ATTENDANCE
-- =====================================================================

create table if not exists public.attendance (
    id uuid primary key default gen_random_uuid(),
    student_id uuid not null references public.students(id) on delete cascade,
    attendance_date date not null,
    status text not null check (status in ('Present', 'Absent')),
    marked_by uuid references public.profiles(id) on delete set null,
    created_at timestamptz not null default now(),

    constraint uq_attendance_student_date
        unique (student_id, attendance_date)
);

-- =====================================================================
-- INDEXES
-- =====================================================================

create index if not exists idx_attendance_student_id
    on public.attendance (student_id);

create index if not exists idx_attendance_date
    on public.attendance (attendance_date);

create index if not exists idx_students_department
    on public.students (department);

create index if not exists idx_students_year_section
    on public.students (year, section);

create index if not exists idx_profiles_role
    on public.profiles (role);

-- =====================================================================
-- ADMIN CHECK FUNCTION
-- =====================================================================

create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
    select exists (
        select 1
        from public.profiles
        where id = auth.uid()
          and role = 'admin'
    );
$$;

-- =====================================================================
-- CURRENT USER ROLE FUNCTION
-- Used to prevent students from changing their own role.
-- =====================================================================

create or replace function public.current_user_role()
returns text
language sql
security definer
set search_path = public
stable
as $$
    select role
    from public.profiles
    where id = auth.uid();
$$;

-- =====================================================================
-- NEW AUTH USER -> PROFILE
-- IMPORTANT:
-- New users ALWAYS start as students.
-- The role supplied in signup metadata is ignored.
-- This prevents someone from registering themselves as admin.
-- =====================================================================

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    insert into public.profiles (
        id,
        full_name,
        email,
        role
    )
    values (
        new.id,
        coalesce(
            new.raw_user_meta_data->>'full_name',
            split_part(new.email, '@', 1)
        ),
        new.email,
        'student'
    )
    on conflict (id) do nothing;

    return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users
for each row
execute function public.handle_new_user();

-- =====================================================================
-- AUTOMATIC STUDENT PROFILE LINKING
-- =====================================================================

create or replace function public.link_student_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    if new.role = 'student' then
        update public.students
        set profile_id = new.id
        where email = new.email
          and profile_id is null;
    end if;

    return new;
end;
$$;

drop trigger if exists on_profile_created_link_student on public.profiles;

create trigger on_profile_created_link_student
after insert on public.profiles
for each row
execute function public.link_student_profile();

-- =====================================================================
-- ENABLE ROW LEVEL SECURITY
-- =====================================================================

alter table public.profiles enable row level security;
alter table public.students enable row level security;
alter table public.attendance enable row level security;

-- =====================================================================
-- PROFILES POLICIES
-- =====================================================================

drop policy if exists "profiles_select_own" on public.profiles;

create policy "profiles_select_own"
on public.profiles
for select
using (
    id = auth.uid()
);

drop policy if exists "profiles_select_admin" on public.profiles;

create policy "profiles_select_admin"
on public.profiles
for select
using (
    public.is_admin()
);

-- Students can update their own profile,
-- BUT they cannot change their role.

drop policy if exists "profiles_update_own" on public.profiles;

create policy "profiles_update_own"
on public.profiles
for update
using (
    id = auth.uid()
)
with check (
    id = auth.uid()
    and role = public.current_user_role()
);

-- Admins can update profiles, including roles.

drop policy if exists "profiles_update_admin" on public.profiles;

create policy "profiles_update_admin"
on public.profiles
for update
using (
    public.is_admin()
)
with check (
    public.is_admin()
);

-- =====================================================================
-- STUDENT POLICIES
-- =====================================================================

drop policy if exists "students_all_admin" on public.students;

create policy "students_all_admin"
on public.students
for all
using (
    public.is_admin()
)
with check (
    public.is_admin()
);

drop policy if exists "students_select_own" on public.students;

create policy "students_select_own"
on public.students
for select
using (
    profile_id = auth.uid()
);

-- =====================================================================
-- ATTENDANCE POLICIES
-- =====================================================================

drop policy if exists "attendance_all_admin" on public.attendance;

create policy "attendance_all_admin"
on public.attendance
for all
using (
    public.is_admin()
)
with check (
    public.is_admin()
);

drop policy if exists "attendance_select_own" on public.attendance;

create policy "attendance_select_own"
on public.attendance
for select
using (
    exists (
        select 1
        from public.students s
        where s.id = attendance.student_id
          and s.profile_id = auth.uid()
    )
);

-- =====================================================================
-- GRANTS
-- =====================================================================

grant usage on schema public to authenticated;

grant select, insert, update, delete
on public.profiles
to authenticated;

grant select, insert, update, delete
on public.students
to authenticated;

grant select, insert, update, delete
on public.attendance
to authenticated;

-- =====================================================================
-- SAMPLE STUDENTS
-- =====================================================================

insert into public.students (
    register_number,
    full_name,
    email,
    department,
    year,
    section
)
values
    (
        'CSE2023001',
        'Aarav Sharma',
        'aarav.sharma@example.edu',
        'Computer Science',
        2,
        'A'
    ),
    (
        'CSE2023002',
        'Diya Patel',
        'diya.patel@example.edu',
        'Computer Science',
        2,
        'A'
    ),
    (
        'ECE2023001',
        'Rohan Mehta',
        'rohan.mehta@example.edu',
        'Electronics',
        2,
        'B'
    ),
    (
        'ECE2023002',
        'Ananya Iyer',
        'ananya.iyer@example.edu',
        'Electronics',
        2,
        'B'
    ),
    (
        'MECH2023001',
        'Vikram Singh',
        'vikram.singh@example.edu',
        'Mechanical',
        3,
        'A'
    )
on conflict (register_number) do nothing;

-- =====================================================================
-- FACULTY ADMIN SETUP
--
-- After creating the faculty user in Supabase Authentication,
-- run:
--
-- update public.profiles
-- set role = 'admin'
-- where email = 'faculty@example.com';
--
-- IMPORTANT:
-- Do this only for the faculty account.
--
-- Student accounts are automatically linked to matching student
-- records by email.
-- =====================================================================
-- ============================================================================
-- apto | ERP & POS Comercial (Artículos de Cuero)
-- Script de Migración PostgreSQL / Supabase (Base de Datos Centralizada)
-- ============================================================================

-- 1. Habilitar extensión UUID
create extension if not exists "uuid-ossp";

-- 2. TABLA: users (Usuarios y Roles)
create table if not exists public.users (
    id text primary key default uuid_generate_v4()::text,
    name text not null,
    email text unique not null,
    password text not null,
    role text not null check (role in ('admin', 'vendedor')),
    is_master boolean default false,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. TABLA: products (Inventario y Taller)
create table if not exists public.products (
    id text primary key default uuid_generate_v4()::text,
    sku text unique not null,
    name text not null,
    category text not null check (category in ('ropa', 'carteras', 'billeteras', 'maletines')),
    subcategory text,
    material text not null,
    color text,
    cost numeric(12,2) not null default 0.00,
    price numeric(12,2) not null default 0.00,
    stock integer not null default 0,
    sizes jsonb, -- Para ropa: {"XS": 0, "S": 2, "M": 5, "L": 4, "XL": 2, "XXL": 0}
    description text,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. TABLA: clients (Registro Centralizado de Clientes)
create table if not exists public.clients (
    id text primary key default uuid_generate_v4()::text,
    nit_ci text unique not null,
    complement text default '',
    business_name text not null,
    email text default '',
    phone text default '',
    total_purchases numeric(14,2) default 0.00,
    purchase_count integer default 0,
    last_purchase_date timestamp with time zone,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 5. TABLA: sales (Facturas SIAT y Registro de Comandas)
create table if not exists public.sales (
    id text primary key default uuid_generate_v4()::text,
    invoice_number bigint unique not null,
    cuf text not null,
    control_code text not null,
    date timestamp with time zone default timezone('utc'::text, now()) not null,
    customer jsonb not null, -- { "nitCi": "...", "complement": "...", "businessName": "...", "email": "..." }
    items jsonb not null, -- Array de productos vendidos con tallas, costos y precios
    subtotal numeric(14,2) not null,
    discount numeric(14,2) default 0.00,
    total numeric(14,2) not null,
    tax_base numeric(14,2) not null,
    iva_tax numeric(14,2) not null,
    payment_method text not null, -- 'Efectivo', 'QR Simple', 'Tarjeta'
    amount_paid numeric(14,2) not null,
    change numeric(14,2) default 0.00,
    seller_name text default 'Vendedor',
    seller_email text default '',
    status text not null default 'V' check (status in ('V', 'A')), -- 'V' = Válida, 'A' = Anulada
    sin_legend_general text,
    sin_legend_specific text,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ============================================================================
-- 6. HABILITAR REALTIME (Sincronización en tiempo real para todos los dispositivos)
-- ============================================================================
alter publication supabase_realtime add table public.users;
alter publication supabase_realtime add table public.products;
alter publication supabase_realtime add table public.sales;
alter publication supabase_realtime add table public.clients;

-- ============================================================================
-- 7. SEGURIDAD Y POLÍTICAS RLS (Row Level Security)
-- ============================================================================
alter table public.users enable row level security;
alter table public.products enable row level security;
alter table public.sales enable row level security;
alter table public.clients enable row level security;

-- Políticas de lectura y escritura para acceso público/anon (API de Supabase)
create policy "Acceso público lectura/escritura users" on public.users for all using (true) with check (true);
create policy "Acceso público lectura/escritura products" on public.products for all using (true) with check (true);
create policy "Acceso público lectura/escritura sales" on public.sales for all using (true) with check (true);
create policy "Acceso público lectura/escritura clients" on public.clients for all using (true) with check (true);

-- ============================================================================
-- 8. DATOS SEMILLA INICIALES (ADMINISTRADOR INALTERABLE & CATÁLOGO)
-- ============================================================================
insert into public.users (id, name, email, password, role, is_master)
values 
    ('usr-admin-master', 'Ian - Administrador Principal', 'ian@gmail.com', 'ADM123', 'admin', true),
    ('usr-vendedor-1', 'Carlos Mendoza (Ventas)', 'carlos.mendoza@apto.bo', 'VEN123', 'vendedor', false)
on conflict (email) do update 
set role = 'admin', is_master = true;

insert into public.clients (id, nit_ci, complement, business_name, email, total_purchases, purchase_count)
values
    ('cli-1', '4892102019', '', 'MARÍA ELENA MAMANI ROJAS', 'elena.mamani@gmail.com', 440.00, 1),
    ('cli-2', '1023849021', '1A', 'JUAN CARLOS FLORES CHÁVEZ', 'jcflores@yahoo.es', 900.00, 1),
    ('cli-3', '7829104', '', 'ANDREA ZEBALLOS PAREDES', 'andrea.zeballos@outlook.com', 735.00, 1)
on conflict (nit_ci) do nothing;

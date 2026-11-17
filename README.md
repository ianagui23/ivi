# apto | ERP & POS Comercial (Artículos de Cuero)

Sistema integral de gestión comercial, taller de marroquinería, punto de venta ágil (POS), control financiero de rentabilidad y facturación electrónica adaptada al **SIAT de Impuestos Nacionales de Bolivia (SIN)**, optimizado para la microempresa de artículos de cuero **"apto"**.

---

## 🔒 1. Seguridad y Autenticación Estricta

El sistema cuenta con una doble capa de autenticación y protección de datos:

### A. Frase Clave Corporativa (Al Cargar el Sistema)
- Al ingresar a la aplicación, se requiere obligatoriamente la frase clave corporativa:
  ```text
  APTO_BOLIVIA
  ```
- No existen botones de acceso rápido ni bypass. Si la frase es incorrecta, el sistema no permite avanzar.

### B. Cuentas de Acceso y Gestión de Usuarios
- **Administrador Principal Inicial e Inalterable** (Protegido contra eliminación o degradación de rol):
  - **Correo:** `ian@gmail.com`
  - **Contraseña:** `ADM123`
  - **Rol:** `Administrador` (Control absoluto)

- **Cuenta de Vendedor de Demostración** (Secundaria):
  - **Correo:** `carlos.mendoza@apto.bo`
  - **Contraseña:** `VEN123`
  - **Rol:** `Vendedor` (POS con escritura, otros módulos en modo lectura)

- **Administración de Personal (Exclusivo para el Administrador):**
  - Botón de gestión en la barra superior (`Icono Usuario +`).
  - Creación de nuevos usuarios asignando rol de **Administrador** o **Vendedor**.
  - Opción de cambio de contraseñas de cuentas secundarias.
  - Eliminación de cuentas secundarias (la cuenta principal `ian@gmail.com` se encuentra blindada permanentemente).

---

## 👥 2. Restricción de Roles y Permisos

| Módulo / Capacidad | Rol Vendedor | Rol Administrador |
| :--- | :---: | :---: |
| **Punto de Venta (POS)** | ✅ Escritura, Cobro y Emisión de Facturas | ✅ Escritura, Cobro y Emisión de Facturas |
| **Inventario (Mercadería y Taller)** | 👁️ **Solo Lectura** (Consulta de stock y catálogo) | ✏️ **Control Total** (Crear, Editar, Eliminar y Ajustar) |
| **Panel Financiero** | 👁️ **Solo Lectura** (Consulta de métricas) | ✏️ **Control Total** (Métricas, Costos y Desglose) |
| **Impuestos SIAT (Libro RCV)** | 👁️ **Solo Lectura** (Ver facturas y reimprimir) | ✏️ **Control Total** (Ver, Reimprimir y **Anular Facturas**) |
| **Gestión de Usuarios** | ❌ Sin acceso | ✏️ **Control Total** (Altas, Bajas y Cambio de Claves) |

---

## 💾 3. Persistencia de Datos (LocalStorage)

El sistema sincroniza automáticamente todo el estado de la aplicación en el almacenamiento local del navegador:
- `apto_users`: Cuentas de usuarios y contraseñas.
- `apto_products`: Catálogo de artículos de cuero, costos de taller, precios y stock por tallas.
- `apto_sales`: Historial de ventas, facturas emitidas, códigos CUF, QR y estados.

---

## 🧰 4. Módulo de Inventario y Taller (Crear y Editar)

Formularios completos y adaptativos según la categoría:
1. **Ropa** (*chalina, poncho, ruana, guantes, polaina, gorro, chully, suéter*):
   - Campos: Código SKU, Nombre, Material (ej. *Cuero vacuno*, *Cuero y tejido mixto*), Color, Costo de Taller (Bs.), Precio de Venta (Bs.) y **Control de Stock Independiente por Talla (XS, S, M, L, XL, XXL)** con cálculo automático del stock general.
2. **Carteras**:
   - Campos: SKU, Nombre, Subcategoría (*Tote, Bandolera, Clutch, etc.*), Material, Color, Costo de Taller, Precio de Venta y Stock.
3. **Billeteras y Accesorios** (*Billetera varón/mujer, Monedero, Tarjetero, Neceser, Cinturón, Lapicero, Porta lentes, Estuche*):
   - Campos: SKU, Nombre, Subcategoría, Material, Color, Costo de Taller, Precio de Venta y Stock.
4. **Maletines** (*Ejecutivo, Portafolio, Duffle de viaje, Porta laptop*):
   - Campos: SKU, Nombre, Subcategoría, Material, Costo de Taller, Precio de Venta y Stock.

---

## 🛒 5. Punto de Venta (POS) y Métodos de Pago

- **Comanda Lateral**:
  - Botones de métodos de pago siempre visibles:
    - **Efectivo:** Calculadora automática de cambio / vuelto en Bolivianos (Bs.).
    - **QR Simple:** Generador y visor interactivo de código QR de pago bancario interoperable.
    - **Tarjeta:** Terminal de tarjeta de débito/crédito.
  - Carrito interactivo con control de cantidades y stock remanente en tiempo real.
  - Selector de tallas (XS-XXL) obligatorio al seleccionar prendas de vestir.
  - Formulario de datos fiscales SIAT (NIT/CI, Complemento, Razón Social y Correo).
  - Emisión de Factura Digital simulada con CUF, Código de Control, IVA 13% incluido y visor para impresión en **Ticket (80mm)** o **Hoja Carta (A4)**.

---

## 📊 6. Panel Financiero Detallado

- **Métricas Globales**:
  - **Ingresos Brutos Totales** (Bs.)
  - **Costo de Taller Acumulado (COGS)** (Bs.)
  - **Ganancia Bruta Real** = $\text{Ingresos} - \text{Costo de Taller}$
  - **Margen Bruto Porcentual Promedio**
  - **Ticket Promedio** y volumen de ventas
- **Sub-vistas Analíticas**:
  1. **Resumen General:** Gráfica comparativa mensual de barras entre Ventas, Costos y Utilidad.
  2. **Ventas Agrupadas por Día:** Tabla con fecha, cantidad de ventas, artículos vendidos, ingresos brutos, costo de taller y ganancia diaria.
  3. **Ventas Agrupadas por Mes:** Consolidado mensual de facturación y margen.
  4. **Rentabilidad por Producto:** Tabla detallada que expone el costo de taller unitario, precio de venta, **diferencia numérica en Bs. y porcentual %**, total de ingresos, costo acumulado y ganancia bruta generada por cada artículo de cuero.


---

## 🚀 7. Subir a GitHub y Despliegue en la Nube

### A. Subir a GitHub
1. Crea un repositorio nuevo en [github.com/new](https://github.com/new) (ej. `apto-erp`).
2. Sube los archivos:
   - **Opción Web (Sin terminal)**: En GitHub, haz clic en **"uploading an existing file"**, arrastra los archivos de este directorio y confirma el commit.
   - **Opción Automática con Script**: Ejecuta `subir_a_github.bat`, pega la URL de tu repositorio y el script inicializará Git y subirá todo automáticamente.
   - **Opción Línea de Comandos**:
     ```bash
     git init
     git add .
     git commit -m "feat: apto ERP & POS v2.0 Cloud - Articulos de Cuero"
     git branch -M main
     git remote add origin https://github.com/TU_USUARIO/apto-erp.git
     git push -u origin main
     ```

### B. Despliegue Automático con HTTPS
Una vez subido a GitHub, puedes vincular el repositorio en **Vercel** o **Render** con un solo clic para tener tu enlace público permanente con HTTPS y PWA para teléfonos móviles.

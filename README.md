# TRD - RifaLibre: Plataforma de Gestión de Rifas Solidarias

## 1. Visión General del Proyecto
**RifaLibre** es una aplicación móvil desarrollada en Flutter diseñada para formalizar, transparentar y automatizar el ecosistema de rifas en Venezuela. El enfoque principal es facilitar la recaudación de fondos para causas benéficas, médicas y comunitarias, eliminando la gestión manual en cuadernos y automatizando el marketing en redes sociales.

---

## 2. Modelo de Negocio (Monetización)
Para garantizar la sostenibilidad en el contexto venezolano, se proponen tres pilares:

1.  **Comisión por Transacción (Modelo Solidario):** Un cobro del 2% al 5% sobre el total recaudado en rifas de alto valor, o una tarifa fija por ticket vendido ($0.10 - $0.25).
2.  **SaaS Premium para Organizadores:** Suscripción mensual para "Riferos" profesionales que incluye:
    *   Estadísticas avanzadas de ventas.
    *   Exportación de bases de datos de clientes (leads).
    *   Personalización de marca en el tablero de números.
3.  **Publicidad Local (Marketplace):** Espacios publicitarios dentro del tablero de números (web view) para negocios locales que quieran patrocinar la causa.

---

## 3. Arquitectura Técnica Sugerida
*   **Frontend:** Flutter (Android/iOS) + Flutter Web (para el visor de números del comprador).
*   **Backend:** Supabase (Auth, PostgreSQL, Real-time, Storage).
*   **Edge Functions:** Deno (TypeScript) para la generación dinámica de imágenes y validación de resultados.
*   **Integraciones:** API de WhatsApp (Twilio o proveedores locales no oficiales) para bots de consulta.

---

## 4. Requerimientos Funcionales

### 4.1. Módulo del Organizador (App Móvil)
*   **Creación de Rifa:** Definir nombre, meta, precio por ticket, fecha de sorteo y reglas.
*   **Gestión de Números:** Tablero interactivo para marcar números como "Vendidos", "Apartados" (pendientes de pago) o "Disponibles".
*   **Validación de Pagos:** Panel de aprobación para capturas de Pago Móvil, Zelle o Binance subidas por los usuarios.
*   **Sorteo Automatizado:**
    *   Opción A: Basado en Loterías Nacionales (ej. Triple Zulia, Chance).
    *   Opción B: Generador aleatorio interno certificado por la app.

### 4.2. Módulo del Comprador (Web View - Sin Instalación)
*   **Visualización en Tiempo Real:** Link único para ver qué números quedan.
*   **Reserva de Cupos:** Seleccionar número, ingresar datos básicos (Nombre/Teléfono) y subir captura de pago.
*   **Comprobante Digital:** Generación de un ticket digital con QR de validación.

### 4.3. Integración con Redes Sociales (Social Engine)
*   **Story Generator:** Botón para generar una imagen 1080x1920 con:
    *   Título de la rifa.
    *   Barra de progreso visual (% vendido).
    *   Grilla de los últimos 10 números disponibles.
*   **Auto-Update Status:** Notificaciones push que sugieren al organizador compartir un nuevo avance cada vez que se vende un 10% adicional.

---

## 5. Diseño de Base de Datos (Esquema Inicial)

### Tabla: `raffles`
| Campo | Tipo | Descripción |
| :--- | :--- | :--- |
| `id` | uuid | PK |
| `creator_id` | uuid | FK -> users |
| `title` | string | Título de la causa |
| `ticket_price` | decimal | Precio en USD/BS |
| `total_numbers` | int | Cantidad (100, 1000, etc) |
| `status` | enum | open, closed, drawn |
| `draw_type` | string | Lotería o Interno |

### Tabla: `tickets`
| Campo | Tipo | Descripción |
| :--- | :--- | :--- |
| `id` | uuid | PK |
| `raffle_id` | uuid | FK -> raffles |
| `number` | int | El número elegido |
| `buyer_name` | string | Nombre del comprador |
| `payment_status` | enum | pending, approved, rejected |
| `payment_proof_url`| string | Link a la captura en Storage |

---

## 6. Roadmap de Desarrollo (MVP)

### Fase 1: Core & Backend (Semanas 1-3)
*   Configuración de Supabase (Auth & Database).
*   CRUD de rifas y lógica de reserva de números.
*   Dashboard básico del organizador en Flutter.

### Fase 2: Experiencia del Comprador (Semanas 4-5)
*   Despliegue de Flutter Web para el tablero de selección.
*   Sistema de carga de comprobantes de pago.

### Fase 3: Social & Automation (Semanas 6-8)
*   Implementación de la librería de generación de imágenes (Social Engine).
*   Integración de notificaciones para hitos de venta.
*   Pruebas de estrés con 1000+ números.

---

## 7. Consideraciones Legales y de Seguridad
*   **RLS (Row Level Security):** Solo el creador puede ver las capturas de pago.
*   **Términos y Condiciones:** Cláusula de deslinde de responsabilidad sobre la entrega del premio por parte del organizador (la app es solo el gestor).
*   **Protección de Datos:** Encriptación de números de teléfono de los compradores.

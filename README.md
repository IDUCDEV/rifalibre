# 🚀 PLAN DE EJECUCIÓN ULTRA-DETALLADO

## RifaLibre: Gestión de Rifas + Premium + Sistema de Publicidad

---

## 1. ARQUITECTURA TÉCNICA (CLEAN ESTRATÉGICO)

### 1.1 Estructura de Capas (Regla de Dependencia Estricta)

```
lib/
├── core/                          # Elementos Transversales
│   ├── error/
│   │   ├── failures.dart          # Either<Failure, Success>
│   │   └── exceptions.dart        # Excepciones personalizadas
│   ├── network/
│   │   ├── network_info.dart     # Check de conexión
│   │   └── dio_client.dart       # Cliente HTTP con interceptors
│   ├── usecases/
│   │   └── usecase.dart           # Clase abstracta base
│   ├── constants/
│   │   └── app_constants.dart    # URLs, Keys, Configs
│   └── di/
│       └── injection_container.dart  # GetIt - Inyección de dependencias
│
├── features/
│   ├── auth/                     # ⭐ DEL TRD ORIGINAL
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── sign_in.dart
│   │   │       ├── sign_up.dart
│   │   │       └── sign_out.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   └── auth_event.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       └── widgets/
│   │           └── auth_button.dart
│   ├── profile/                     # ⭐ PERFIL + NAVIGATION DRAWER
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── profile_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── profile_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_profile.dart
│   │   │       ├── update_profile.dart
│   │   │       ├── upload_avatar.dart
│   │   │       └── get_user_stats.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── profile_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── profile_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── profile_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── profile_bloc.dart
│   │       ├── pages/
│   │       │   ├── profile_page.dart
│   │       │   ├── edit_profile_page.dart
│   │       │   └── settings_page.dart
│   │       └── widgets/
│   │           ├── app_drawer.dart
│   │           ├── profile_header.dart
│   │           └── profile_menu_item.dart
│   │
│   ├── raffles/                   # ⭐ CORE: GESTIÓN DE RIFAS
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── raffle_entity.dart
│   │   │   │   ├── ticket_entity.dart
│   │   │   │   └── payment_proof_entity.dart
│   │   │   ├── repositories/
│   │   │   │   ├── raffle_repository.dart
│   │   │   │   └── ticket_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_raffle.dart
│   │   │       ├── get_my_raffles.dart
│   │   │       ├── get_raffle_by_id.dart
│   │   │       ├── update_raffle.dart
│   │   │       ├── delete_raffle.dart
│   │   │       ├── get_available_tickets.dart
│   │   │       ├── reserve_ticket.dart
│   │   │       ├── approve_payment.dart
│   │   │       ├── reject_payment.dart
│   │   │       ├── perform_draw.dart
│   │   │       └── validate_ticket.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── raffle_model.dart
│   │   │   │   ├── ticket_model.dart
│   │   │   │   └── payment_proof_model.dart
│   │   │   ├── datasources/
│   │   │   │   ├── raffle_remote_datasource.dart
│   │   │   │   ├── ticket_remote_datasource.dart
│   │   │   │   └── payment_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       ├── raffle_repository_impl.dart
│   │   │       └── ticket_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── raffle_bloc.dart
│   │       │   ├── ticket_bloc.dart
│   │       │   ├── payment_bloc.dart
│   │       │   └── draw_bloc.dart
│   │       ├── pages/
│   │       │   ├── dashboard_page.dart
│   │       │   ├── create_raffle_page.dart
│   │       │   ├── raffle_detail_page.dart
│   │       │   ├── ticket_board_page.dart
│   │       │   ├── payment_approval_page.dart
│   │       │   └── draw_result_page.dart
│   │       └── widgets/
│   │           ├── raffle_card.dart
│   │           ├── ticket_grid.dart
│   │           ├── ticket_item.dart
│   │           ├── payment_proof_card.dart
│   │           ├── draw_selector.dart
│   │           └── raffle_form.dart
│   │
│   ├── buyer/                     # ⭐ MÓDULO COMPRADOR (WEB VIEW)
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── buyer_ticket_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── buyer_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_raffle_for_buyer.dart
│   │   │       ├── select_ticket.dart
│   │   │       └── submit_payment.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── buyer_ticket_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── buyer_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── buyer_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── buyer_bloc.dart
│   │       ├── pages/
│   │       │   ├── buyer_ticket_page.dart
│   │       │   ├── buyer_payment_page.dart
│   │       │   └── buyer_qr_page.dart
│   │       └── widgets/
│   │           ├── ticket_selector.dart
│   │           ├── payment_upload.dart
│   │           └── qr_ticket.dart
│   │
│   ├── social/                    # ⭐ SOCIAL ENGINE
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       ├── generate_story_image.dart
│   │   │       └── get_raffle_progress.dart
│   │   ├── data/
│   │   │   └── services/
│   │   │       └── image_generator_service.dart
│   │   └── presentation/
│   │       └── widgets/
│   │           └── share_button.dart
│   │
│   ├── subscription/             # ⭐ PREMIUM
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── subscription_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── subscription_repository.dart
│   │   │   └── usecases/
│   │   │       ├── check_subscription_status.dart
│   │   │       ├── check_raffle_limit.dart
│   │   │       ├── upgrade_to_premium.dart
│   │   │       └── verify_payment.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── subscription_model.dart
│   │   │   ├── datasources/
│   │   │   │   ├── subscription_remote_datasource.dart
│   │   │   │   └── payment_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── subscription_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── subscription_bloc.dart
│   │       ├── pages/
│   │       │   ├── premium_page.dart
│   │       │   └── payment_methods_page.dart
│   │       └── widgets/
│   │           ├── premium_badge.dart
│   │           ├── subscription_plan_card.dart
│   │           └── premium_limit_modal.dart
│   │
│   └── advertising/              # ⭐ PUBLICIDAD
│       ├── domain/
│       │   ├── entities/
│       │   │   └── advertisement_entity.dart
│       │   ├── repositories/
│       │   │   └── advertisement_repository.dart
│       │   └── usecases/
│       │       ├── get_active_ads.dart
│       │       ├── track_ad_impression.dart
│       │       └── get_raffle_ads.dart
│       ├── data/
│       │   ├── models/
│       │   │   └── advertisement_model.dart
│       │   ├── datasources/
│       │   │   └── ad_remote_datasource.dart
│       │   └── repositories/
│       │       └── advertisement_repository_impl.dart
│       └── presentation/
│           ├── bloc/
│           │   └── advertising_bloc.dart
│           ├── widgets/
│           │   ├── ad_banner.dart
│           │   ├── ad_interstitial.dart
│           │   └── native_ad_widget.dart
│           └── pages/
│               └── ad_management_page.dart
│   
│
└── web_view/                     # ⭐ WEB VIEW DEL COMPRADOR
    ├── index.html
    ├── styles.css
    ├── app.js
    └── ads_injector.js
```

---

## 2. BASE DE DATOS (SUPABASE)

### Tablas Principales

```sql
-- USUARIOS (extiende auth.users)
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  full_name TEXT,
  phone TEXT,
  avatar_url TEXT,
  is_premium BOOLEAN DEFAULT false,
  subscription_type TEXT, -- 'free', 'monthly', 'yearly'
  subscription_end_date TIMESTAMP,
  preferred_currency TEXT DEFAULT 'USD',
  preferred_language TEXT DEFAULT 'es',
  notifications_enabled BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- CONFIGURACIÓN DE NOTIFICACIONES POR USUARIO
CREATE TABLE notification_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id),
  notify_new_sale BOOLEAN DEFAULT true,
  notify_payment_approved BOOLEAN DEFAULT true,
  notify_payment_rejected BOOLEAN DEFAULT true,
  notify_draw_result BOOLEAN DEFAULT true,
  notify_raffle_completed BOOLEAN DEFAULT true,
  notify_weekly_summary BOOLEAN DEFAULT false,
  notify_marketing BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- RIFAS
CREATE TABLE raffles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_id UUID REFERENCES profiles(id),
  title TEXT NOT NULL,
  description TEXT,
  ticket_price DECIMAL NOT NULL,
  currency TEXT DEFAULT 'USD', -- 'USD', 'BS', 'USDT'
  total_numbers INT NOT NULL,
  
  -- IMÁGENES (opcionales)
  beneficiary_image_url TEXT,  -- Foto del beneficiario
  prize_image_url TEXT,       -- Foto del premio
  
  prize_description TEXT,
  draw_type TEXT NOT NULL, -- 'lottery', 'internal'
  lottery_source TEXT, -- 'triple_zulia', 'chance', etc.
  draw_date TIMESTAMP,
  status TEXT DEFAULT 'open', -- 'open', 'closed', 'drawn'
  show_ads BOOLEAN DEFAULT true,
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- TICKETS
CREATE TABLE tickets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  raffle_id UUID REFERENCES raffles(id),
  number INT NOT NULL,
  buyer_name TEXT,
  buyer_phone TEXT,
  buyer_email TEXT,
  status TEXT DEFAULT 'available', -- 'available', 'reserved', 'sold'
  payment_status TEXT DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
  payment_proof_url TEXT,
  payment_method TEXT, -- 'pagomovil', 'zelle', 'binance'
  payment_reference TEXT,
  payment_amount DECIMAL,
  sold_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- SUSCRIPCIONES PREMIUM
CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id),
  plan_type TEXT NOT NULL, -- 'monthly', 'yearly'
  amount DECIMAL NOT NULL,
  currency TEXT DEFAULT 'USD',
  payment_method TEXT,
  payment_reference TEXT,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  is_active BOOLEAN DEFAULT true,
  auto_renew BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW()
);

-- MÉTODOS DE PAGO
CREATE TABLE payment_methods (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL, -- 'Binance', 'Pago Móvil', 'Kontigo'
  type TEXT NOT NULL, -- 'binance', 'pagomovil', 'kontigo'
  is_active BOOLEAN DEFAULT true,
  instructions TEXT,
  qr_code_url TEXT,
  wallet_address TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- PUBLICIDAD
CREATE TABLE advertisements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  image_url TEXT NOT NULL,
  target_url TEXT,
  position TEXT NOT NULL, -- 'webview_banner', 'app_banner', 'interstitial'
  is_active BOOLEAN DEFAULT true,
  starts_at TIMESTAMP,
  ends_at TIMESTAMP,
  clicks_count INT DEFAULT 0,
  impressions_count INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

-- SOCIAL POSTS (para tracking)
CREATE TABLE social_posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  raffle_id UUID REFERENCES raffles(id),
  post_type TEXT NOT NULL, -- 'story', 'post'
  media_url TEXT,
  engagement INT DEFAULT 0,
  posted_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Funciones y Triggers

```sql
-- Función: Contar rifas activas del usuario
CREATE OR REPLACE FUNCTION count_active_raffles(user_id UUID)
RETURNS INT AS $$
  SELECT COUNT(*)::INT FROM raffles
  WHERE creator_id = user_id 
  AND status IN ('open', 'closed');
$$ LANGUAGE sql;

-- Función: Verificar si puede crear rifa
CREATE OR REPLACE FUNCTION can_create_raffle(user_id UUID)
RETURNS BOOLEAN AS $$
  DECLARE
    is_premium BOOLEAN;
    raffle_count INT;
  BEGIN
    SELECT p.is_premium INTO is_premium FROM profiles p WHERE p.id = user_id;
    
    IF is_premium = true THEN
      RETURN true;
    END IF;
    
    SELECT count_active_raffles(user_id) INTO raffle_count;
    RETURN raffle_count < 1;
  END;
$$ LANGUAGE plpgsql;

-- Trigger: Actualizar status de rifa
CREATE OR REPLACE FUNCTION update_raffle_status()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.draw_date < NOW() AND NEW.status = 'open' THEN
    NEW.status := 'closed';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER raffle_status_trigger
  BEFORE UPDATE ON raffles
  FOR EACH ROW
  EXECUTE FUNCTION update_raffle_status();
```

---

## 3. UI/UX & DESIGN SYSTEM

### 3.1 Paleta de Colores Funcional

| Propósito | Color | Hex | Uso |
|-----------|-------|-----|-----|
| Primary | Azul Venezuela | `#1E3A8A` | Botones principales, headers |
| Secondary | Verde Bono | `#10B981` | Éxito, pagos aprobados, premium |
| Accent | Dorado Premium | `#F59E0B` | Badge premium, estrellas |
| Error | Rojo Alerta | `#EF4444` | Errores, pagos rechazados |
| Warning | Naranja Pendiente | `#F97316` | Estados pendientes |
| Background | Blanco | `#FFFFFF` | Fondo principal |
| Surface | Gris Claro | `#F3F4F6` | Tarjetas, containers |
| Available | Verde Claro | `#D1FAE5` | Tickets disponibles |
| Reserved | Amarillo | `#FEF3C7` | Tickets apartados |
| Sold | Rojo Claro | `#FEE2E2` | Tickets vendidos |

### 3.2 Jerarquía Tipográfica

| Estilo | Font | Tamaño | Peso | Uso |
|--------|------|--------|------|-----|
| Headline Large | Poppins | 28sp | 700 | Títulos principales |
| Headline Medium | Poppins | 24sp | 600 | Subtítulos |
| Title Large | Poppins | 20sp | 600 | Tarjetas |
| Title Medium | Poppins | 16sp | 500 | Labels |
| Body Large | Inter | 16sp | 400 | Contenido principal |
| Body Medium | Inter | 14sp | 400 | Descripciones |
| Label Large | Inter | 14sp | 500 | Botones |
| Caption | Inter | 12sp | 400 | Metadata |
| Ticket Number | Poppins | 14sp | 600 | Números en tablero |

### 3.3 Micro-animaciones

| Elemento | Animación | Duración | Trigger |
|----------|-----------|----------|---------|
| Ticket disponible | Escala 1.0 → 1.05 | 150ms | Hover |
| Ticket vendido | Opacidad fade 50% | 200ms | Cambio status |
| Botón crear rifa | Scale + shadow | 200ms | On tap |
| Badge Premium | Brillo dorado | 300ms | Al obtener |
| QR generar | Fade in | 400ms | Generado |
| Payment approved | Check scale | 600ms | Aprobado |
| Error shake | Horizontal ±10px | 300ms | Validación fallida |

---

## 4. PRODUCT BACKLOG & QA

### MÓDULO RIFAS - HISTORIAS DE USUARIO

---

### Historia 1: Crear una Rifa

**Como** organizador,
**Quiero** crear una rifa definiendo título, precio, cantidad de números y fecha de sorteo,
**Para** iniciar una campaña de recaudación.

#### Criterios de Aceptación (Given/When/Then)

```
GIVEN: Usuario logueado en dashboard
WHEN:Hace clic en "Crear Rifa"
THEN: Se muestra formulario con campos:
  - Título (required, max 100 chars)
  - Descripción (optional, max 500 chars)
  - Precio del ticket (required, decimal)
  - Moneda (USD/BS/USDT)
  - Cantidad de números (required, 10-10000)
  - Descripción del premio (required)
  - Tipo de sorteo (Lotería / Interno)
  - Si Lotería: seleccionar fuente (Triple Zulia, Chance, etc)
  - Si Interno: fecha y hora del sorteo

GIVEN: Usuario completa el formulario correctamente
WHEN:Hace clic en "Crear Rifa"
THEN: 
  - Se crea la rifa en estado "open"
  - Se generan automáticamente todos los tickets disponibles
  - Se muestra en el dashboard
  - Se genera link para compartir (webview)

GIVEN: Usuario free con 1 rifa activa
WHEN: Intenta crear otra rifa
THEN: Se muestra modal "Límite alcanzado" con upgrade a premium
```

---

### Historia 2: Tablero de Números (Gestión de Tickets)

**Como** organizador,
**Quiero** ver y gestionar todos los números de mi rifa,
**Para** controlar ventas y apartados.

#### Criterios de Aceptación

```
GIVEN: Organizador en detalle de rifa
WHEN: Accede al "Tablero de Números"
THEN: Muestra grilla de todos los tickets con colores:
  - Verde: Disponibles
  - Amarillo: Apartados (reservados)
  - Rojo: Vendidos

GIVEN: Organizador toca un ticket reservado
THEN: Muestra popup con:
  - Nombre del comprador
  - Teléfono
  - Captura de pago (si existe)
  - Estado (pending/approved/rejected)
  - Botones: Aprobar / Rechazar

GIVEN: Organizador toca un ticket disponible
THEN: Permite:
  - Apartar manualmente (ingresa nombre/teléfono)
  - Bloquear número (no disponible)

GIVEN: Ticket tiene pago pendiente
WHEN: Organizador revisa captura
THEN: Puede:
  - Aprobar → ticket pasa a "sold", se notifica al comprador
  - Rechazar → ticket pasa a "available", se notifica al comprador
```

---

### Historia 3: Validación de Pagos

**Como** organizador,
**Quiero** aprobar o rechazar los pagos de los compradores,
**Para** confirmar ventas legítimas.

#### Criterios de Aceptación

```
GIVEN: Hay tickets con payment_status = 'pending'
WHEN: Organizador va a "Pagos Pendientes"
THEN: Muestra lista de pagos con:
  - Número de ticket
  - Nombre del comprador
  - Método de pago (Pago Móvil, Zelle, Binance)
  - Referencia del pago
  - Captura de pantalla
  - Monto

GIVEN: Organizador revisa captura de Pago Móvil
WHEN: Verifica que el monto y referencia son correctos
THEN: Hace clic en "Aprobado"
THEN: 
  - payment_status = 'approved'
  - ticket.status = 'sold'
  - Se envía notificación al comprador
  - Se actualiza el tablero

GIVEN: Organizador detecta problema con el pago
WHEN: Hace clic en "Rechazar"
THEN: 
  - payment_status = 'rejected'
  - Se solicita理由 (opcional)
  - Ticket vuelve a 'available'
  - Se notifica al comprador
```

---

### Historia 4: Realizar Sorteo

**Como** organizador,
**Quiero** realizar el sorteo de mi rifa,
**Para** determinar al ganador.

#### Criterios de Aceptación

```
GIVEN: Rifaconstatus = 'closed' y tickets vendidos > 0
WHEN: Organizador hace clic en "Realizar Sorteo"
THEN: Se muestra opciones según tipo:

  TIPO = Lotería:
  - Se muestra input para ingresar resultado oficial
  - Se calcula el número ganador según lógica:
    -riple Zulia: últimos 3 dígitos del premio
    - Chance: último dígito del chance
  - Se muestra winner

  TIPO = Interno:
  - Se muestra "Generador Aleatorio Certificado"
  - Se realiza selección random entre tickets vendidos
  - Se muestra animación de "rueda de la fortuna"
  - Se revela el winner

GIVEN: Sorteo realizado exitosamente
THEN: 
  - raffle.status = 'drawn'
  - Se muestra screen de resultado con:
    - Número ganador
    - Datos del ganador
    - Botón para compartir resultado
  - Se notifica al ganador
```

---

### Historia 5: Comprador - Seleccionar Número

**Como** comprador,
**Quiero** seleccionar un número disponible,
**Para** participar en la rifa.

#### Criterios de Aceptación

```
GIVEN: Comprador accede al link de la rifa (WebView)
WHEN: Se carga el tablero
THEN: Muestra:
  - Título y descripción de la rifa
  - Precio del ticket
  - Grilla de números disponibles (verde)
  - Números vendidos (gris/rojo, no clickeables)
  - Mi número seleccionado (resaltado)

GIVEN: Comprador toca un número disponible
THEN: 
  - Se marca como seleccionado
  - Se muestra precio total
  - Botón "Continuar"

GIVEN: Comprador hace clic en "Continuar"
THEN: Se muestra formulario:
  - Nombre completo (required)
  - Teléfono (required)
  - Email (optional)
  - Método de pago (Pago Móvil, Zelle, Binance)
  - Botón "Subir comprobante"

GIVEN: Comprador sube captura de pago
WHEN:Hace clic en "Confirmar"
THEN: 
  - Se crea ticket con status 'reserved'
  - Se muestra comprobante digital con QR
  - Se envía confirmación al organizador
```

---

### Historia 6: Comprador - Comprobante Digital

**Como** comprador,
**Quiero** obtener mi ticket digital con QR,
**Para** tener evidencia de mi participación.

#### Criterios de Aceptación

```
GIVEN: Comprador completó el proceso de compra
WHEN: Se muestra la página de éxito
THEN: Muestra:
  - "¡ickets reservado exitosamente!"
  - Número del ticket
  - QR code único (contiene: raffle_id, ticket_id, buyer_phone)
  - Datos de la rifa
  - Estado: "Pendiente de aprobación"

GIVEN: Organizador aprueba el pago
WHEN: Comprador accede al link del comprobante
THEN: Se actualiza el estado a:
  - "Aprobado" ✓
  - Se muestra mensaje de felicitación

GIVEN: Organizador rechaza el pago
WHEN: Comprador accede al comprobante
THEN: 
  - Se muestra estado "Rechazado"
  - Se muestra razón si existe
  - Botón "Contactar al organizador"
```

---

### MÓDULO PREMIUM - HISTORIAS

---

### Historia 7: Limitar Rifas para Gratuitos

**Como** usuario free,
**Quiero** crear máximo 1 rifa activa,
**Para** que la plataforma sea sostenible.

```
GIVEN: Usuario free con 0 rifas
WHEN: Crea una rifa
THEN: Se crea normalmente

GIVEN: Usuario free con 1 rifa activa (status: open/closed)
WHEN: Intenta crear otra rifa
THEN: Se muestra modal:
  - Título: "Límite alcanzado"
  - Texto: "Solo puedes tener 1 rifa activa. ¡Haz upgrade a Premium!"
  - Botón: "Ver planes Premium"

GIVEN: Usuario free con rifa status = 'drawn'
WHEN: Intenta crear rifa
THEN: Se permite (rifa concluida no cuenta)
```

---

### Historia 8: Upgrade a Premium

**Como** usuario free,
**Quiero** pagar suscripción premium,
**Para** crear rifas ilimitadas y quitar anuncios.

```
GIVEN: Usuario en página de Premium
WHEN: Ve los planes
THEN: Muestra:
  - Free: 1 rifa, con ads
  - Mensual: $5/mes, ilimitadas, sin ads
  - Anual: $50/año (ahorro 17%), ilimitadas, sin ads

GIVEN: Usuario selecciona plan
WHEN: Hace clic en "Pagar"
THEN: Muestra métodos:
  - Binance (QR USDT)
  - Pago Móvil (datos de cuenta)
  - Kontigo (integración)

GIVEN: Usuario realiza pago
WHEN: Sistema detecta transacción O admin aprueba
THEN: 
  - is_premium = true
  - subscription_type = tipo
  - end_date = fecha + 30/365 días
  - Se muestra éxito
  - Usuario puede crear rifas ilimitadas
```

---

### MÓDULO PUBLICIDAD - HISTORIAS

---

### Historia 9: Publicidad en WebView (Comprador)

**Como** comprador,
**Quiero** ver anuncios en el tablero,
**Para** sostener la plataforma gratuita.

```
GIVEN: Comprador entra a WebView de rifa de organizador FREE
WHEN: Se carga el tablero
THEN: Se muestra banner AdMob en footer

GIVEN: Comprador entra a WebView de rifa de organizador PREMIUM
WHEN: Se carga el tablero
THEN: NO se muestra ningún anuncio

GIVEN: AdMob falla en cargar
WHEN: Termina de cargar la página
THEN: Se muestra espacio vacío (no rompe layout)
```

---

### Historia 10: Publicidad en App (Usuario Free)

**Como** usuario free,
**Quiero** ver anuncios en la app,
**Para** usar la app gratuitamente.

```
GIVEN: Usuario free en lista de rifas
WHEN: Hace scroll
THEN: Cada 5 items muestra banner AdMob

GIVEN: Usuario premium
WHEN: Usa la app
THEN: NO se muestra ningún anuncio en ninguna pantalla
```

---

### MÓDULO PERFIL - HISTORIAS

---

### Historia 11: Visualizar Perfil

**Como** usuario,
**Quiero** ver mi información de perfil,
**Para** conocer mis datos y estado de cuenta.

```
GIVEN: Usuario logueado
WHEN: Abre el drawer y toca "Mi Perfil"
THEN: Muestra:
  - Avatar (foto o inicial)
  - Nombre completo
  - Teléfono
  - Estado Premium (si aplica)
  - Rifas creadas total
  - Rifas activas

GIVEN: Usuario toca su avatar
WHEN: Está en la página de perfil
THEN: Permite:
  - Ver avatar en tamaño grande
  - Cambiar avatar (cámara/galería)
```

---

### Historia 12: Editar Perfil

**Como** usuario,
**Quiero** actualizar mi información,
**Para** mantener mis datos actualizados.

```
GIVEN: Usuario en página de perfil
WHEN: Toca botón "Editar"
THEN: Muestra formulario con:
  - Nombre completo (editable)
  - Teléfono (editable)
  - Avatar (puede cambiar)
  - Botones: Guardar / Cancelar

GIVEN: Usuario modifica datos y toca "Guardar"
WHEN: Valida que teléfono sea válido
THEN: 
  - Se actualiza en BD
  - Se muestra snackbar "Perfil actualizado"
  - Regresa a página de perfil

GIVEN: Usuario toca "Cancelar"
THEN: Descarta cambios y regresa a perfil
```

---

### Historia 13: Configuración de Notificaciones

**Como** usuario,
**Quiero** configurar qué notificaciones recibo,
**Para** controlar la comunicación.

```
GIVEN: Usuario accede a Settings
WHEN: Toca "Notificaciones"
THEN: Muestra toggles para:
  - Nueva venta realizada
  - Pago aprobado
  - Pago rechazado
  - Resultado del sorteo
  - Rifa completada
  - Resumen semanal
  - Comunicaciones de marketing

GIVEN: Usuario activa/desactiva una opción
WHEN: Toca el toggle
THEN: Se guarda inmediatamente y muestra feedback
```

---

### Historia 14: Navigation Drawer

**Como** usuario,
**Quiero** acceder a todas las secciones desde un menú lateral,
**Para** navegar fácilmente por la app.

```
GIVEN: Usuario en cualquier página de la app
WHEN: Toca el ícono de menú (hamburguesa)
THEN: Se abre el drawer con:
  - Header: Avatar + Nombre + Badge Premium (si aplica)
  - Items:
    - Mis Rifas (icono tickets)
    - Crear Rifa (icono plus)
    - Premium (icono corona) - si es free
    - Mi Perfil (icono persona)
    - Configuración (icono engranaje)
    - Cerrar Sesión (icono logout)

GIVEN: Usuario toca un item del drawer
WHEN: Selecciona una opción
THEN: 
  - Se cierra el drawer
  - Navega a la página correspondiente
  - El item seleccionado queda resaltado
```

---

### Historia 15: Preferencias de Moneda e Idioma

**Como** usuario,
**Quiero** configurar mi moneda e idioma preferidos,
**Para** ver los precios en mi preferencia.

```
GIVEN: Usuario en Settings
WHEN: Toca "Preferencias"
THEN: Muestra:
  - Selector de idioma: Español / Inglés
  - Selector de moneda preferida: USD / BS / USDT

GIVEN: Usuario selecciona una opción
WHEN: Cambia moneda o idioma
THEN: 
  - Se guarda en perfil
  - La app muestra precios en esa moneda
  - Los textos cambian al idioma seleccionado
```

---

## 5. ROADMAP DE EJECUCIÓN (BACKLOG TÉCNICO)

### Sprint 1: Setup + Auth + Gestión de Rifas Core (Semana 1-2)

**Objetivo:** Configurar proyecto, auth, y CRUD completo de rifas

**Dominio:**
- [ ] Definir `RaffleEntity` (title, price, totalNumbers, beneficiaryImageUrl, prizeImageUrl, status, drawType, etc.)
- [ ] Definir `TicketEntity` (number, status, buyerInfo, paymentStatus)
- [ ] Definir `PaymentProofEntity`
- [ ] Definir `ProfileEntity` (fullName, phone, avatarUrl, isPremium, etc.)
- [ ] Crear `RaffleRepository` interface
- [ ] Crear `TicketRepository` interface
- [ ] Crear `ProfileRepository` interface
- [ ] Implementar `CreateRaffle` UseCase
- [ ] Implementar `GetMyRaffles` UseCase
- [ ] Implementar `GetRaffleById` UseCase
- [ ] Implementar `UpdateRaffle` UseCase
- [ ] Implementar `DeleteRaffle` UseCase
- [ ] Implementar `GetProfile` UseCase
- [ ] Implementar `UpdateProfile` UseCase
- [ ] Implementar `UploadAvatar` UseCase
- [ ] Implementar `GetUserStats` UseCase

**Data:**
- [ ] Crear tablas en Supabase: profiles, raffles, tickets
- [ ] Crear tabla notification_settings
- [ ] Configurar RLS: users solo ven sus rifas
- [ ] Implementar `RaffleRemoteDataSource`
- [ ] Implementar `TicketRemoteDataSource`
- [ ] Implementar `ProfileRemoteDataSource`
- [ ] Implementar generación automática de tickets al crear rifa

**Presentation:**
- [ ] Crear `RaffleBloc` (estados: Initial, Loading, Loaded, Error)
- [ ] Implementar `DashboardPage` (lista de rifas)
- [ ] Implementar `CreateRafflePage` (formulario)
- [ ] Implementar `RaffleCard` widget
- [ ] Implementar skeleton loaders
- [ ] Implementar Navigation Drawer con menu items
- [ ] Implementar `ProfilePage` (ver perfil)
- [ ] Implementar `EditProfilePage` (editar perfil)
- [ ] Implementar `SettingsPage` (configuración)
- [ ] Implementar `AppDrawer` widget

**Dependencias:** Ninguna

---

### Sprint 2: Tablero de Números + Validación de Pagos (Semana 3-4)

**Objetivo:** Gestión visual de tickets y flujo de aprobación

**Dominio:**
- [ ] Implementar `GetAvailableTickets` UseCase
- [ ] Implementar `ReserveTicket` UseCase
- [ ] Implementar `ApprovePayment` UseCase
- [ ] Implementar `RejectPayment` UseCase

**Data:**
- [ ] Crear tabla payment_proofs
- [ ] Implementar upload de imágenes de rifa a Storage (beneficiary, prize)
- [ ] Implementar lógica de estados de ticket

**Presentation:**
- [ ] Implementar `TicketBoardPage` (grilla interactiva)
- [ ] Implementar `TicketGrid` widget (responsive)
- [ ] Implementar `TicketItem` (estados: available/reserved/sold)
- [ ] Implementar `PaymentApprovalPage` (lista de pagos)
- [ ] Implementar `PaymentProofCard` (captura + approve/reject)
- [ ] Implementar filtros: todos, pendientes, aprobados, rechazados

**Dependencias:** Sprint 1 completo

---

### Sprint 3: Sorteo + WebView Comprador (Semana 5-6)

**Objetivo:** Lógica de sorteo y experiencia del comprador

**Dominio:**
- [ ] Implementar `PerformDraw` UseCase
- [ ] Implementar `ValidateTicket` UseCase
- [ ] Crear lógica de Lotería vs Generador interno
- [ ] Implementar `GetRaffleForBuyer` UseCase (webview)
- [ ] Implementar `SelectTicket` UseCase

**Data:**
- [ ] Crear Edge Function `draw-winner`
- [ ] Crear Edge Function `generate-story-image` (para social)
- [ ] Configurar Storage para imágenes de rifas
- [ ] Implementar WebView template (HTML/CSS/JS)

**Presentation:**
- [ ] Implementar `DrawResultPage` (mostrar winner)
- [ ] Implementar `DrawSelector` widget (lotería/interno)
- [ ] Implementar WebView: ticket selector
- [ ] Implementar WebView: formulario de compra
- [ ] Implementar WebView: comprobante con QR
- [ ] Implementar `ShareButton` para stories

**Dependencias:** Sprint 2 completo

---

### Sprint 4: Premium + Límite de Rifas (Semana 7-8)

**Objetivo:** Sistema de suscripciones y restricciones

**Dominio:**
- [ ] Definir `SubscriptionEntity`
- [ ] Implementar `CheckRaffleLimit` UseCase
- [ ] Implementar `CheckSubscriptionStatus` UseCase
- [ ] Implementar `UpgradeToPremium` UseCase

**Data:**
- [ ] Crear tabla subscriptions
- [ ] Crear tabla payment_methods
- [ ] Implementar `SubscriptionRemoteDataSource`
- [ ] Crear función Supabase `can_create_raffle()`

**Presentation:**
- [ ] Crear `SubscriptionBloc`
- [ ] Implementar `PremiumPage` (3 planes)
- [ ] Implementar `SubscriptionPlanCard` widget
- [ ] Implementar `PremiumBadge` widget
- [ ] Modificar Dashboard: mostrar/ocultar botón crear según límite
- [ ] Implementar `PremiumLimitModal` (cuando intenta crear 2da rifa free)

**Dependencias:** Sprint 1-3

---

### Sprint 5: Pagos Automatizados (Semana 9-10)

**Objetivo:** Integración con Binance, Pago Móvil, Kontigo

**Dominio:**
- [ ] Implementar `VerifyPayment` UseCase
- [ ] Implementar `TrackAdImpression` UseCase
- [ ] Definir `PaymentMethodEntity`

**Data:**
- [ ] Crear Edge Function `verify-binance-payment`
- [ ] Crear Edge Function `verify-pagomovil-payment`
- [ ] Crear Edge Function `verify-kontigo-payment`
- [ ] Crear tabla payment_verification (logs)
- [ ] Implementar webhooks para Binance

**Presentation:**
- [ ] Implementar `PaymentMethodsPage`
- [ ] Implementar `PaymentMethodSelector` (Binance, Pago Móvil, Kontigo)
- [ ] Implementar `QRPaymentDisplay` (para Binance)
- [ ] Implementar `PaymentUploadWidget` (captura screenshot)
- [ ] Implementar flujo de verificación manual

**Dependencias:** Sprint 4 completo

---

### Sprint 6: Publicidad WebView + App (Semana 11-12)

**Objetivo:** Sistema de anuncios completo

**Dominio:**
- [ ] Implementar `GetActiveAds` UseCase
- [ ] Implementar `GetRaffleAds` UseCase
- [ ] Definir lógica "organizador es premium?"

**Data:**
- [ ] Crear tabla advertisements
- [ ] Configurar AdMob para Flutter Web
- [ ] Configurar AdMob para Flutter Mobile
- [ ] Implementar AdMob Banners injection en WebView

**Presentation:**
- [ ] Crear `AdvertisingBloc`
- [ ] Implementar `AdBannerWidget` (reusable)
- [ ] Modificar WebView template para incluir ads
- [ ] Modificar app: mostrar ads solo a users free
- [ ] Implementar AdInterceptor (bloquea si premium)
- [ ] Agregar ads a: RaffleList, RaffleDetail
- [ ] NO agregar a: CreateRaffle, Payment screens

**Dependencias:** Sprint 4 + 5

---

### Sprint 7: Social Engine + Panel Admin (Semana 13-14)

**Objetivo:** Generación de contenido para redes y administración

**Dominio:**
- [ ] Implementar `GenerateStoryImage` UseCase
- [ ] Implementar `GetRaffleProgress` UseCase

**Data:**
- [ ] Crear Edge Function `generate-stories`
- [ ] Crear Edge Function `get_ads_analytics`
- [ ] Crear tabla social_posts
- [ ] Crear Edge Function `toggle_ad`

**Presentation:**
- [ ] Implementar Story Generator (1080x1920)
- [ ] Implementar Progress Bar (% vendido)
- [ ] Implementar grid últimos 10 números disponibles
- [ ] Implementar Admin Dashboard (ads)
- [ ] Implementar Analytics widgets
- [ ] Implementar Ad Management CRUD
- [ ] Implementar notification settings para hitos (10%, 25%, 50%, 75%)

**Testing:**
- [ ] Test: Crear rifa genera tickets automáticamente
- [ ] Test: Aprobar pago cambia status ticket a sold
- [ ] Test: Sorteo lotería calcula winner correcto
- [ ] Test: Usuario free no puede crear 2da rifa
- [ ] Test: WebView muestra ads según organizador
- [ ] Test: User premium no ve ads en app
- [ ] Test: QR genera correctamente

**Dependencias:** Sprint 6 completo

---

## 6. EDGE FUNCTIONS (SUPABASE)

| Function | Input | Output | Descripción |
|----------|-------|--------|-------------|
| `draw-winner` | raffle_id, draw_type, lottery_result | ticket_id | Ejecuta el sorteo |
| `verify-binance-payment` | tx_hash, user_id | subscription_id | Valida pago USDT |
| `verify-pagomovil-payment` | referencia, monto | subscription_id | Valida pago móvil |
| `verify-kontigo-payment` | transaction_id | subscription_id | Valida pago Kontigo |
| `generate-stories` | raffle_id | image_url | Genera imagen para story |
| `get-ads-analytics` | date_range | stats_json | Métricas de ads |
| `toggle-ad` | ad_id, status | success | Activa/desactiva ad |
| `send-notification` | user_id, message | success | Envía push notification |

---

## 7. DEFINICIÓN DE "READY TO CODE"

### Technical Ready ✅

- [x] Contratos de repositorios definidos (Raffle, Ticket, Subscription, Advertisement)
- [x] Entities con Equatable
- [x] UseCases con Either<Failure, Entity>
- [x] Tipos de datos para Venezuela (BS, USD, USDT)
- [x] Funciones SQL para límite de rifas
- [x] Esquema de tablas completo

### UI/UX Ready ✅

- [x] Estados de carga (shimmer)
- [x] Estados de error (snackbar + retry)
- [x] Estados vacíos (empty states)
- [x] Design System definido (colores, tipografía)
- [x] Micro-animaciones especificadas
- [x] Estados del tablero de tickets (available/reserved/sold)

### Business Ready ✅

- [x] Regla de 1 rifa para free implementable
- [x] Flujo completo de creación de rifa
- [x] Sistema de aprobación de pagos
- [x] Lógica de sorteo (lotería + interno)
- [x] WebView del comprador completo
- [x] Flujo premium completo
- [x] Sistema de ads para WebView y App
- [x] Métodos de pago para Venezuela
- [x] Criterios de aceptación QA para todas las historias

---

## 8. RESUMEN EJECUTIVO

| Métrica | Valor |
|---------|-------|
| Total Sprints | 7 |
| Duración Estimada | 14 semanas |
| Features Core | 15+ |
| Pantallas Nuevas | 15+ |
| Edge Functions | 8+ |
| Test Cases | 25+ |
| Tablas BD | 11 |
| WebView Templates | 3 |
| Historias de Usuario | 15 |

---

## 9. PRÓXIMOS PASOS

1. **Confirmar este plan** para proceder a implementación
2. **Iniciar Sprint 1:** Setup proyecto + Auth + CRUD Rifas
3. **Configurar Supabase:** Crear proyecto y ejecutar schema SQL

¿Iniciamos con el Sprint 1?

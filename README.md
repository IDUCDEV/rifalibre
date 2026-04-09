# RifaLibre - Plan de Ejecución Actualizado

> **Versión:** 2.0  
> **Fecha:** Abril 2026  
> **Estado:** Lista para implementación

---

## 📖 Guía de Lectura del Proyecto

| Orden | Archivo | Pregunta que responde | Contenido clave |
|-------|---------|----------------------|-----------------|
| 1 | `ROADMAP.md` | ¿Qué vamos a hacer y en qué orden? | Fases, semanas, tareas |
| 2 | `README.md` | ¿Qué es el producto? | Features, modelo negocio |
| 3 | `SPEC.md` | ¿Cómo lo vamos a hacer técnicamente? | Stack, arquitectura |
| 4 | `database_schema.sql` | ¿Cómo guardamos los datos? | Tablas, funciones, RLS |
| 5 | `web_view/` | ¿Cómo funciona la vista del comprador? | HTML + CSS + JS |
| 6 | `pubspec.yaml` | ¿Con qué dependencias? | 25+ librerías |
| 7 | `.gitignore` | ¿Qué ignoramos? | Archivos exclude |

### 🎯 Para comenzar desarrollo:
1. Crear cuenta Supabase → ejecutar SQL
2. Crear proyecto Flutter
3. Seguir ROADMAP.md (Sprint 1)

---

## 1. Resumen Ejecutivo

RifaLibre es una plataforma para crear y gestionar rifas automáticamente en Venezuela. Permite al organizador crear rifas, compartir una URL pública donde los compradores seleccionan números y contactan por WhatsApp, y generar imágenes para stories de redes sociales.

### Modelo de Monetización

| Plan | Precio | Incluye |
|------|--------|---------|
| **Gratis** | $0 | 1 rifa activa, con ads, limitación de features |
| **Pro** | $3-5/mes | Rifas ilimitadas, sin ads, estadísticas, stories ilimitados |
| **Agencia** | $8-12/mes | Múltiples usuarios, reportes avanzados, API |

### Diferenciadores vs Competencia

- **URL + WhatsApp directo** - El comprador selecciona y contacta sin注册 obligatoria
- **Generador de Stories automático** - Imágenes listas para WhatsApp/Telegram
- **Pensado para Venezuela** - Bs, USD, USDT, Pago Móvil, Zelle, Binance

---

## 2. Features del Producto

### 2.1 Core: Gestión de Rifas

- [ ] Crear rifa (título, descripción, precio, cantidad números, premio)
- [ ] Tipos de sorteo: Lotería (Triple Zulia, Chance, etc.) o Interno
- [ ] Tablero visual de tickets (verde=disponible, amarillo=apartado, rojo=vendido)
- [ ] Aprobar/rechazar pagos de compradores
- [ ] Historial de rifas (activas, cerradas, sorteadas)

### 2.2 URL Pública + WhatsApp (PRIORIDAD 1)

```
Estructura URL: rifalibre.app/r/{raffle_id}

Flujo del comprador:
1. Accede a la URL → ve el tablero de números
2. Toca un número disponible → se marca como seleccionado
3. Hace clic en "Comprar por WhatsApp"
4. Se abre WhatsApp con mensaje predefinido:
   "Hola, quiero apartar el #25 de la rifa 'iPhone 15 Pro' ($10)"
5. El organizador recibe el mensaje y marca el ticket como "apartado"
```

- [ ] WebView responsive (funciona en móvil y escritorio)
- [ ] Selector visual de números
- [ ] Botón WhatsApp con texto predefinido
- [ ] Mostrar precio, descripción del premio, progreso de ventas

### 2.3 Generador de Imágenes para Stories (PRIORIDAD 2)

```
Casos de generación automática:
- Cada vez que se vende/aparta un ticket
- Al alcanzar 25%, 50%, 75%, 100% de ventas
- Manual: botón "Generar Story" en el detalle de rifa

Especificación técnica:
- Formato: 1080x1920 (9:16)
- Incluye: título rifa, precio, progreso visual, URL, calls-to-action
- Exporta: lista para subir a WhatsApp/Telegram/Instagram
```

- [ ] Template de imagen profesional
- [ ] Datos dinámicos (progreso, números vendidos)
- [ ] Opción de descargar o compartir directamente
- [ ] Integración con gallery del teléfono

### 2.4 Sistema de Pagos (Venezuela)

- [ ] Pago Móvil (datos de cuenta del organizador)
- [ ] Zelle (datos del organizador)
- [ ] Binance/USDT (QR code)
- [ ] Registro manual de pago por el comprador
- [ ] Validación por el organizador

### 2.5 Premium

- [ ] Limitar a 1 rifa para usuarios gratuitos
- [ ] Planes de suscripción (mensual/anual)
- [ ] Sin anuncios para premium
- [ ] Estadísticas de ventas
- [ ] Soporte prioritario

### 2.6 Sistema de Publicidad

```
┌─────────────────────────────────────────────────────────────────┐
│  ESTRATEGIA: MULTI-PROVEEDOR CON FALLBACK                       │
├─────────────────────────────────────────────────────────────────┤
│  Principal: AdMob → Backup: AppLovin → Fallback: Espacio vacío │
└─────────────────────────────────────────────────────────────────┘
```

#### 2.6.1 Proveedores de Publicidad

| Proveedor | Uso | Ventaja para Venezuela |
|-----------|-----|----------------------|
| **AdMob (Google)** | Principal | Más conocido, fill rate alto |
| **AppLovin MAX** | Backup | Mejor pago en Latam, menos restricciones |
| **ironSource** | Opcional | Buena integración Flutter |

#### 2.6.2 Publicidad en App (Organizador Free)

```
Ubicaciones:
- Dashboard: Banner en lista de rifas (cada 5 items)
- Raffle Detail: Banner en pie de página
- Splash: Interstitial opcional (una vez por sesión)

No mostrar en:
- Create Raffle (evitar fricción)
- Payment Approval (no interrumpir gestión)
- Perfil / Settings
```

#### 2.6.3 Publicidad en WebView (Comprador)

```
┌────────────────────────────────────────────┐
│  [Contenido de la Rifa]                    │
│                                            │
│  [Ticket Grid]                             │
│                                            │
│                                            │
│  ┌──────────────────────────────────────┐  │
│  │  [AdMob/AppLovin Banner 320x50]    │  │
│  └──────────────────────────────────────┘  │
└────────────────────────────────────────────┘

Reglas:
- Si organizer.is_premium = false → mostrar ads
- Si organizer.is_premium = true → NO mostrar ads
- Si AdMob falla → intentar AppLovin
- Si todo falla → mostrar espacio vacío
```

#### 2.6.4 Toggle por Rifa

```sql
-- En tabla raffles
show_ads BOOLEAN DEFAULT true

-- El organizador puede:
- Desactivar si tiene sus propios anuncios
- Mantener activo para ayudar a la plataforma
```

#### 2.6.5 Lógica de Display

```
IF user.is_premium = true THEN
    NO mostrar ads en app
ELSE
    IF ad_load_failed THEN
        try AppLovin
    ELSE
        mostrar AdMob
    END
END

-- Para WebView
IF raffle.creator.is_premium = true OR raffle.show_ads = false THEN
    NO mostrar ads en webview
ELSE
    mostrar ads
END
```

#### 2.6.6 Configuración de IDs

```env
# AdMob (principal)
ADMOB_APP_ID=ca-app-pub-xxxxx
ADMOB_BANNER_APP=ca-app-pub-xxxxx/xxx
ADMOB_BANNER_WEBVIEW=ca-app-pub-xxxxx/yyy
ADMOB_INTERSTITIAL=ca-app-pub-xxxxx/zzz

# AppLovin (backup)
APPLOVIN_SDK_KEY=xxxxx
APPLOVIN_BANNER_ID=xxxxx
APPLOVIN_INTERSTITIAL_ID=xxxxx
```

#### 2.6.7 Métricas Proyectadas

| Métrica | Valor Estimado |
|---------|----------------|
| RPM (Revenue per 1000 impressions) | $1-3 USD |
| CTR (Click through rate) | 2-5% |
| Fill rate (Venezuela) | 70-90% |
| Ingreso promedio/user free/mes | $0.50-2 USD |

#### 2.6.8 Fallback Strategy

```
1. Intentar cargar AdMob
2. Si falla después de 5 segundos → fallback
3. Intentar AppLovin
4. Si falla → mostrar espacio vacío (no rompe layout)
5. Loggear evento para analytics
```

---

## 3. Stack Tecnológico

### Frontend

| Tecnología | Uso |
|------------|-----|
| **Flutter** | App móvil (iOS/Android) + Web |
| **Flutter Web** | WebView pública para compradores |
| **Dart** | Lenguaje |

### Backend

| Tecnología | Uso |
|------------|-----|
| **Supabase** | Base de datos + Auth + Storage + Edge Functions |
| **PostgreSQL** | Base de datos relacional |
| **Edge Functions** | Lógica del lado del servidor |

### Servicios Externos

| Servicio | Uso |
|----------|-----|
| **AdMob** | Publicidad en versión gratuita |
| **WhatsApp API** | Mensajes directa (opcional, no requerido) |
| **Cloudflare** | CDN y dominio |

---

## 4. Arquitectura Técnica

### Estructura de Proyecto

```
lib/
├── main.dart
├── app.dart
│
├── core/                    # Elementos transversales
│   ├── constants/           # URLs, colores, configuraciones
│   ├── errors/             # Fallos y excepciones
│   ├── network/            # Cliente HTTP
│   ├── usecases/           # Caso de uso base
│   └── di/                 # Inyección de dependencias (GetIt)
│
├── features/
│   ├── auth/               # Autenticación
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── raffles/            # Gestión de rifas (organizador)
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── buyer/              # WebView del comprador
│   │   └── web_view/       # Archivos HTML/CSS/JS
│   │
│   ├── social/             # Generador de stories
│   │   └── data/
│   │       └── services/
│   │
│   └── subscription/      # Premium
│
└── web_view/               # WebView público
    ├── index.html
    ├── styles.css
    ├── app.js
    └── assets/
```

### Patrón de Arquitectura

```
┌─────────────────────────────────────────────────────┐
│                    PRESENTATION                      │
│         (Pages, Widgets, BLoC/Cubit)                │
└─────────────────────────────────────────────────────┘
                         ↓ ↑
┌─────────────────────────────────────────────────────┐
│                      DOMAIN                          │
│      (Entities, UseCases, Repository Interfaces)    │
└─────────────────────────────────────────────────────┘
                         ↓ ↑
┌─────────────────────────────────────────────────────┐
│                       DATA                           │
│  (Models, DataSources, Repository Implementations) │
└─────────────────────────────────────────────────────┘
```

---

## 5. Modelo de Datos (Supabase)

### Tablas Principales

```sql
-- Perfiles de usuario
CREATE TABLE profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id),
  full_name TEXT,
  phone TEXT,
  avatar_url TEXT,
  is_premium BOOLEAN DEFAULT false,
  subscription_type TEXT DEFAULT 'free',
  subscription_end_date TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Rifas
CREATE TABLE raffles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  creator_id UUID REFERENCES profiles(id),
  slug TEXT UNIQUE,                    -- URL amigable (ej: iphone-15-pro)
  title TEXT NOT NULL,
  description TEXT,
  prize_description TEXT,
  prize_image_url TEXT,
  beneficiary_image_url TEXT,
  ticket_price DECIMAL NOT NULL,
  currency TEXT DEFAULT 'USD',         -- USD, BS, USDT
  total_numbers INT NOT NULL,
  draw_type TEXT NOT NULL,             -- 'lottery', 'internal'
  lottery_source TEXT,                 -- 'triple_zulia', 'chance'
  draw_date TIMESTAMP,
  status TEXT DEFAULT 'open',         -- 'open', 'closed', 'drawn'
  whatsapp_phone TEXT,                -- Teléfono del organizador
  show_ads BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Tickets/Números
CREATE TABLE tickets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  raffle_id UUID REFERENCES raffles(id),
  number INT NOT NULL,
  buyer_name TEXT,
  buyer_phone TEXT,
  buyer_whatsapp TEXT,
  status TEXT DEFAULT 'available',    -- 'available', 'reserved', 'sold'
  payment_status TEXT DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
  payment_method TEXT,                 -- 'pagomovil', 'zelle', 'binance'
  payment_proof_url TEXT,
  payment_reference TEXT,
  payment_amount DECIMAL,
  reserved_at TIMESTAMP,
  sold_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Métodos de pago del organizador
CREATE TABLE payment_methods (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id),
  type TEXT NOT NULL,                 -- 'pagomovil', 'zelle', 'binance'
  name TEXT NOT NULL,
  account_info TEXT,                  -- Datos de la cuenta
  qr_code_url TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Suscripciones
CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id),
  plan_type TEXT NOT NULL,            -- 'monthly', 'yearly'
  amount DECIMAL NOT NULL,
  currency TEXT DEFAULT 'USD',
  payment_method TEXT,
  payment_reference TEXT,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Stories generados
CREATE TABLE generated_stories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  raffle_id UUID REFERENCES raffles(id),
  image_url TEXT,
  trigger_type TEXT,                  -- 'manual', 'sale', 'milestone'
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Funciones y Triggers

```sql
-- Contar rifas activas del usuario
CREATE OR REPLACE FUNCTION count_active_raffles(user_id UUID)
RETURNS INT AS $$
  SELECT COUNT(*)::INT FROM raffles
  WHERE creator_id = user_id 
  AND status IN ('open', 'closed');
$$ LANGUAGE sql;

-- Verificar si puede crear rifa
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

-- Generar slug automático
CREATE OR REPLACE FUNCTION generate_raffle_slug(title TEXT)
RETURNS TEXT AS $$
  DECLARE
    slug TEXT;
    counter INT := 0;
  BEGIN
    slug := lower(regexp_replace(title, '[^a-z0-9]+', '-', 'g'));
    
    LOOP
      counter := counter + 1;
      IF counter = 1 THEN
        RETURN slug;
      END IF;
    END LOOP;
  END;
$$ LANGUAGE plpgsql;
```

---

## 6. Flujo de Usuario

### Flujo del Organizador

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Registro   │ → │   Dashboard │ → │ Crear Rifa  │
└─────────────┘    └─────────────┘    └─────────────┘
                                           │
                                           ↓
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Aprobar    │ ← │  Tablero de  │ ← │  Detalle de │
│   Pagos     │    │   Tickets   │    │    Rifa     │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Flujo del Comprador

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   URL de    │ → │  Seleccionar│ → │ Comprar por │
│    Rifa     │    │   Número    │    │  WhatsApp   │
└─────────────┘    └─────────────┘    └─────────────┘
                         ↓
                   ┌─────────────┐
                   │  Contacta al │
                   │  organizador │
                   └─────────────┘
```

---

## 7. Pantallas de la App (Organizador)

### 1. Pantalla de Inicio / Dashboard
- Lista de rifas (activas, cerradas, sorteadas)
- Estado de cada rifa (números vendidos, fecha)
- Botón flotante "Crear Rifa"
- Drawer lateral con navegación

### 2. Crear Rifa
- Formulario: título, descripción, precio, números, premio
- Selector: tipo de sorteo (lotería/interno)
- Configuración: WhatsApp para recibir mensajes
- Preview de la URL pública

### 3. Detalle de Rifa
- Información de la rifa
- Progreso de ventas (%)
- Link para compartir (botón copiar)
- Botón "Generar Story"
- Botón "Realizar Sorteo"

### 4. Tablero de Números
- Grilla de números con colores
- Al tocar: modal con detalles del comprador
- Opciones: aprobar/rechazar pago

### 5. Perfil y Settings
- Información del usuario
- Estado de suscripción
- Configuración de notificaciones

---

## 8. Pantallas del WebView (Comprador)

### 1. Vista de la Rifa (Pública)
```
┌─────────────────────────────────────┐
│  🏆 iPhone 15 Pro Max               │
│  ─────────────────                  │
│  💰 $10 USD                         │
│                                     │
│  📊 45/100 vendidos                 │
│  ████████░░░░░░░ 45%                │
│                                     │
│  ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐         │
│  │00│ │01│ │02│ │03│ │04│  ...   │
│  └──┘ └──┘ └──┘ └──┘ └──┘         │
│  (verde=disponible, rojo=vendido) │
│                                     │
│  [NÚMERO SELECCIONADO: 25]          │
│                                     │
│  ┌─────────────────────────────┐   │
│  │  💬 Comprar por WhatsApp    │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

### 2. Mensaje de WhatsApp
```
Hola, quiero apartar el #25 de la rifa 
'iPhone 15 Pro Max' ($10 USD)

Precio total: $10
```

---

## 9. Generador de Stories

### Template de Imagen (1080x1920)

```
┌─────────────────────────────────────┐
│                                     │
│        RIFA ACTIVA 🎰              │
│        ═══════════════════         │
│                                     │
│        iPhone 15 Pro Max           │
│        ─────────────────           │
│                                     │
│           💰 $10 USD               │
│                                     │
│   ████████████████░░░░░░░  65%      │
│        65 de 100 vendidos          │
│                                     │
│         👉 ¡Aparta el tuyo!        │
│                                     │
│        🔗 rifalibre.app/r/iphone   │
│                                     │
│            #RifaLibre              │
└─────────────────────────────────────┘
```

### Especificaciones
- Fondo: degradado azul/verde
- Tipografía: Poppins (bold para títulos)
- Elementos: emoji, progress bar, QR code opcional
- CTA: "Aparta ahora" o "Compra aquí"

---

## 10. Roadmap de Implementación

### Sprint 1: Setup + Auth (Semana 1-2)
- [ ] Crear proyecto Flutter
- [ ] Configurar Supabase
- [ ] Implementar autenticación
- [ ] Estructura de carpetas Clean Architecture

### Sprint 2: CRUD Rifas + WebView (Semana 3-4)
- [ ] Crear/editar/eliminar rifas
- [ ] WebView público con selección de números
- [ ] Integración WhatsApp

### Sprint 3: Tablero de Tickets + Pagos (Semana 5-6)
- [ ] Grilla visual de números
- [ ] Aprobar/rechazar pagos
- [ ] Registro de métodos de pago

### Sprint 4: Stories + Notifications (Semana 7-8)
- [ ] Generador de imágenes
- [ ] Automatización por hitos
- [ ] Notificaciones push

### Sprint 5: Premium + Monetización (Semana 9-10)
- [ ] Sistema de suscripciones
- [ ] Limitar usuarios free (1 rifa)
- [ ] Publicidad (AdMob + AppLovin fallback)
- [ ] Toggle show_ads por rifa

### Sprint 6: Testing + Lanzamiento (Semana 11-12)
- [ ] Pruebas de usuario
- [ ] Bug fixes
- [ ] Landing page
- [ ] Lanzamiento beta

---

## 11. Métricas de Éxito

| Métrica | Target |
|---------|--------|
| Usuarios registrados | 1000 en 3 meses |
| Rifas creadas | 500 en 3 meses |
| Conversión a Premium | 5% de usuarios |
| Tasa de compra completada | >70% |
| Stories generados | 1000+ |

---

## 12. Notas Importantes

1. **URL pública primero**: Usar Flutter Web para el WebView del comprador. Más fácil de compartir y no requiere instalación.

2. **WhatsApp sin API**: El comprador abre WhatsApp Web/App manualmente. No necesitamos API de WhatsApp.

3. **Validación manual de pagos**: El organizador revisa las capturas. Más simple que integrar verificación automática.

4. **Dominio**: Necesitarás un dominio (ej: rifalibre.app o rifalibre.com.ve). Cloudflare + Vercel/Netlify para hosting.

---

## 13. Próximos Pasos

1. **Confirmar plan** - ¿Algo que ajustar?
2. **Crear cuenta Supabase** - Configurar proyecto
3. **Iniciar Sprint 1** - Setup + Auth
4. **Domain** - Comprar dominio (opcional por ahora)

¿Iniciamos con el Sprint 1?
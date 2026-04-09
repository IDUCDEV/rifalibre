# RifaLibre - Roadmap de Ejecución

> **Versión:** 1.0  
> **Fecha:** Abril 2026

---

## Resumen de Archivos Generados

| # | Archivo | Descripción |
|---|---------|-------------|
| 1 | `README.md` | Plan actualizado con features URL+WhatsApp y Stories |
| 2 | `database_schema.sql` | Schema completo de Supabase (tablas, funciones, RLS) |
| 3 | `SPEC.md` | Especificación técnica (stack, colores, arquitectura) |
| 4 | `web_view/index.html` | Template HTML del WebView público |
| 5 | `web_view/styles.css` | Estilos CSS del WebView |
| 6 | `web_view/app.js` | Lógica JavaScript del WebView |
| 7 | `ROADMAP.md` | Este archivo - planificación detallada |

---

## Roadmap de Implementación

### Fase 0: Preparación (Semana 0)

| Task | Responsable | Entregable |
|------|-------------|------------|
| Crear cuenta Supabase | Usuario | Proyecto creado |
| Configurar proyecto Flutter | Usuario | Repo local |
| Comprar dominio (opcional) | Usuario | Dominio adquirido |

---

### Fase 1: Setup + Auth (Semanas 1-2)

```
Semana 1: Setup Técnico
├── [ ] Crear proyecto Flutter
├── [ ] Configurar pubspec.yaml con dependencias
├── [ ] Configurar Supabase (crear proyecto)
├── [ ] Ejecutar database_schema.sql
├── [ ] Configurar autenticación Supabase
└── [ ] Estructura de carpetas Clean Architecture

Semana 2: Auth Básico
├── [ ] Implementar Login (email/password)
├── [ ] Implementar Register
├── [ ] Implementar Logout
├── [ ] Crear Profile entity y modelo
├── [ ] Crear Auth repository
├── [ ] Crear Auth BLoC
└── [ ] UI: Login Page, Register Page
```

**Entregable final:** Usuario puede registrarse e iniciar sesión

---

### Fase 2: CRUD Rifas + WebView (Semanas 3-4)

```
Semana 3: Gestión de Rifas
├── [ ] Crear Raffle entity y modelo
├── [ ] Crear Raffle repository
├── [ ] Implementar use cases:
│   ├── CreateRaffle
│   ├── GetMyRaffles
│   ├── GetRaffleById
│   ├── UpdateRaffle
│   └── DeleteRaffle
├── [ ] Crear RaffleBloc
└── [ ] UI: Dashboard Page, RaffleCard

Semana 4: WebView Público
├── [ ] Crear Ticket entity
├── [ ] Endpoint API: get raffle by slug
├── [ ] Endpoint API: get tickets by raffle
├── [ ] Deploy web_view a hosting (Vercel/Netlify)
├── [ ] Configurar dominio
└── [ ] Testing WebView con datos reales
```

**Entregable final:** Organizador crea rifas y compradores pueden ver/seleccionar números desde URL pública

---

### Fase 3: Tablero de Tickets + Pagos (Semanas 5-6)

```
Semana 5: Tablero de Números
├── [ ] UI: Ticket Board (grilla visual)
├── [ ] Implementar filtros (disponible/apartado/vendido)
├── [ ] Modal de detalle de ticket
├── [ ] Funcionalidad: Apartar número manualmente
├── [ ] Funcionalidad: Bloquear número
└── [ ] UI: Raffle Detail Page (actualizada)

Semana 6: Validación de Pagos
├── [ ] PaymentMethod entity
├── [ ] UI: PaymentMethods Page (agregar métodos)
├── [ ] UI: Approval Page (lista de pagos)
├── [ ] Aprobar pago → ticket.status = 'sold'
├── [ ] Rechazar pago → ticket.status = 'available'
├── [ ] Notificaciones (opcional: email/push)
└── [ ] Flujo completo de venta verificada
```

**Entregable final:** Organizador gestiona tickets y valida pagos

---

### Fase 4: Stories + Social (Semanas 7-8)

```
Semana 7: Generador de Stories
├── [ ] Widget template para story (1080x1920)
├── [ ] Implementar captura de widget como imagen
├── [ ] Subir imagen a Supabase Storage
├── [ ] Guardar registro en generated_stories table
├── [ ] UI: Botón "Generar Story" en Raffle Detail
└── [ ] Compartir a galería/WhatsApp

Semana 8: Automatización de Stories
├── [ ] Trigger: al vender/apartar ticket
├── [ ] Trigger: hitos (25%, 50%, 75%, 100%)
├── [ ] Guardar historial de stories generados
├── [ ] UI: Galería de stories generados
└── [ ] Testing y polish
```

**Entregable final:** Organizador genera imágenes profesionales para compartir en redes

---

### Fase 5: Premium + Monetización (Semanas 9-10)

```
Semana 9: Sistema de Suscripciones
├── [ ] Subscription entity
├── [ ] UI: Premium Page (planes y precios)
├── [ ] Funcionalidad: Verificar límite de rifas
├── [ ] Funcionalidad: can_create_raffle() -> false si free + 1 rifa
├── [ ] UI: Modal "Límite alcanzado" para users free
└── [ ] Guardar suscripción en tabla subscriptions

Semana 10: Métodos de Pago
├── [ ] UI: Payment methods (Pago Móvil, Zelle, Binance)
├── [ ] Integrar verificación manual de pagos
├── [ ] Configurar QR de Binance
├── [ ] Sistema de aprobación manual por admin (MVP)
└── [ ] Testing flujos de pago
```

**Entregable final:** Modelo de monetización activo

---

### Fase 6: Publicidad + Polish (Semanas 11-12)

```
Semana 11: Publicidad
├── [ ] Configurar AdMob
├── [ ] Crear AdBanner widget
├── [ ] Mostrar ads solo a usuarios free
├── [ ] Integrar AdMob en WebView (compradores de users free)
├── [ ] NO mostrar ads a usuarios premium
└── [ ] UI: Toggle show_ads en raffle

Semana 12: Testing + Lanzamiento
├── [ ] Pruebas de integración completas
├── [ ] Bug fixes
├── [ ] Landing page para usuarios
├── [ ] Configurar App Store / Play Store
├── [ ] Soft launch (beta)
├── [ ] Recopilar feedback
└── [ ] Iterar basado en feedback
```

**Entregable final:** App lista para producción

---

## Dependencias Entre Fases

```
Fase 1 (Setup) ─────► Fase 2 (CRUD + WebView)
       │                          │
       │                          ▼
       │                   Fase 3 (Tickets + Pagos)
       │                          │
       ▼                          ▼
Fase 4 (Stories) ◄───► Fase 5 (Premium)
       │                          │
       └────────► Fase 6 ◄────────┘
```

---

## Checklist de Inicio Sprint 1

- [ ] Crear cuenta Supabase (supabase.com)
- [ ] Crear proyecto Flutter (`flutter create rifalibre`)
- [ ] Instalar VS Code / Android Studio
- [ ] Clonar este repositorio en tu máquina
- [ ] Ejecutar `flutter pub get` para verificar dependencias
- [ ] Ejecutar schema SQL en Supabase

---

## Contacto y Soporte

Si tienes dudas sobre:
- Configuración de Supabase
- Estructura del proyecto
- Alguna funcionalidad específica
- Deployment

Puedo ayudarte a resolverlo. ¿Iniciamos con el Sprint 1?
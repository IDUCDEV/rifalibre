# RifaLibre - Technical Specification

> **Versión:** 1.0  
> **Fecha:** Abril 2026

---

## 1. Stack Tecnológico

### Frontend

| Tecnología | Versión | Uso |
|------------|---------|-----|
| **Flutter** | 3.x | Framework principal |
| **Dart** | 3.x | Lenguaje |
| **flutter_bloc** | ^8.x | State management |
| **get_it** | ^7.x | Inyección de dependencias |
| **dio** | ^5.x | HTTP client |
| **cached_network_image** | ^3.x | Imágenes |
| **share_plus** | ^7.x | Compartir |
| **screenshot** | ^2.x | Generar imágenes |
| **qr_flutter** | ^4.x | Generar QR codes |
| **flutter_html** | ^3.x | Render HTML |
| **url_launcher** | ^6.x | Abrir URLs |
| **image_picker** | ^1.x | Selección de imágenes |
| **firebase_messaging** | ^14.x | Push notifications (opcional) |
| **google_mobile_ads** | ^3.x | AdMob |

### Backend

| Servicio | Uso |
|----------|-----|
| **Supabase** | DB + Auth + Storage + Edge Functions |
| **PostgreSQL** | Base de datos |
| **Edge Functions** | Lógica serverless |

### Herramientas de Desarrollo

| Herramienta | Uso |
|-------------|-----|
| **Flutter** | SDK |
| **VS Code** | Editor |
| **Postman/Insomnia** | API testing |
| **TablePlus** | DB client |

---

## 2. Paleta de Colores

### Colores del Diseño

| Nombre | Hex | RGB | Uso |
|--------|-----|-----|-----|
| **Primary** | #1E3A8A | 30, 58, 138 | Botones principales, headers |
| **Primary Dark** | #172554 | 23, 37, 84 | Estados pressed |
| **Secondary** | #10B981 | 16, 185, 129 | Éxito, pagos aprobados |
| **Secondary Light** | #D1FAE5 | 209, 250, 229 | Fondo success |
| **Accent** | #F59E0B | 245, 158, 11 | Premium, estrellas |
| **Accent Light** | #FEF3C7 | 254, 243, 199 | Fondo warning |
| **Error** | #EF4444 | 239, 68, 68 | Errores, pagos rechazados |
| **Error Light** | #FEE2E2 | 254, 226, 226 | Fondo error |
| **Warning** | #F97316 | 249, 115, 22 | Estados pendientes |
| **Warning Light** | #FFEDD5 | 255, 237, 213 | Fondo warning |
| **Background** | #F8FAFC | 248, 250, 252 | Fondo general |
| **Surface** | #FFFFFF | 255, 255, 255 | Tarjetas |
| **Surface Variant** | #F1F5F9 | 241, 245, 249 | Fondos alternativos |
| **On Primary** | #FFFFFF | 255, 255, 255 | Texto sobre primary |
| **On Background** | #1E293B | 30, 41, 59 | Texto principal |
| **On Surface Variant** | #64748B | 100, 116, 139 | Texto secundario |
| **Outline** | #E2E8F0 | 226, 232, 240 | Bordes |
| **Outline Variant** | #CBD5E1 | 203, 213, 225 | Bordes oscuros |

### Colores de Estados de Tickets

| Estado | Color | Hex | Background |
|--------|-------|-----|------------|
| **Disponible** | Verde | #10B981 | #D1FAE5 |
| **Apartado** | Amarillo | #F59E0B | #FEF3C7 |
| **Vendido** | Rojo | #EF4444 | #FEE2E2 |
| **Bloqueado** | Gris | #94A3B8 | #F1F5F9 |

### Colores para Monedas

| Moneda | Color | Hex |
|--------|-------|-----|
| **USD** | Verde | #10B981 |
| **BS** | Azul | #3B82F6 |
| **USDT** | Verde | #26A17B |

---

## 3. Tipografía

### Familia de Fuentes

| Uso | Fuente | Peso |
|-----|--------|------|
| **Títulos** | Poppins | 600, 700 |
| **Body** | Inter | 400, 500 |
| **Números tickets** | Poppins | 600 |
| **Monto** | Inter | 700 |

### Tamaños

| Estilo | Tamaño | Weight | Line Height |
|--------|--------|--------|-------------|
| **Display Large** | 32sp | 700 | 40sp |
| **Headline Large** | 28sp | 700 | 36sp |
| **Headline Medium** | 24sp | 600 | 32sp |
| **Title Large** | 20sp | 600 | 28sp |
| **Title Medium** | 16sp | 500 | 24sp |
| **Body Large** | 16sp | 400 | 24sp |
| **Body Medium** | 14sp | 400 | 20sp |
| **Label Large** | 14sp | 500 | 20sp |
| **Label Medium** | 12sp | 500 | 16sp |
| **Caption** | 12sp | 400 | 16sp |

---

## 4. Espaciado (8pt Grid)

| Nombre | Valor |
|--------|-------|
| **xs** | 4px |
| **sm** | 8px |
| **md** | 16px |
| **lg** | 24px |
| **xl** | 32px |
| **xxl** | 48px |

### Radios de Borde

| Nombre | Valor | Uso |
|--------|-------|-----|
| **xs** | 4px | Chips, badges |
| **sm** | 8px | Botones pequeños |
| **md** | 12px | Cards, inputs |
| **lg** | 16px | Modales |
| **full** | 9999px | Avatars, FAB |

---

## 5. Estructura de Carpetas

```
lib/
├── main.dart                    # Entry point
├── app.dart                     # App configuration
├── injection_container.dart     # GetIt setup
│
├── core/                        # Transversales
│   ├── constants/
│   │   ├── app_colors.dart       # Colores
│   │   ├── app_spacing.dart     # Espaciados
│   │   ├── app_strings.dart     # Strings
│   │   └── app_urls.dart        # URLs externas
│   │
│   ├── errors/
│   │   ├── failures.dart        # Clases de fallo
│   │   └── exceptions.dart      # Excepciones
│   │
│   ├── network/
│   │   ├── network_info.dart    # Check conexión
│   │   └── dio_client.dart      # Cliente HTTP
│   │
│   ├── usecases/
│   │   └── usecase.dart         # Clase base
│   │
│   └── utils/
│       ├── extensions.dart      # Extensiones útiles
│       ├── validators.dart      # Validadores
│       └── formatters.dart      # Formateadores
│
├── features/
│   ├── auth/                    # Autenticación
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── sign_in.dart
│   │   │       ├── sign_up.dart
│   │   │       └── sign_out.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       └── widgets/
│   │           └── auth_button.dart
│   │
│   ├── raffles/                 # Gestión rifas
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── raffle_remote_datasource.dart
│   │   │   │   └── ticket_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── raffle_model.dart
│   │   │   │   └── ticket_model.dart
│   │   │   └── repositories/
│   │   │       └── raffle_repository_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── raffle_entity.dart
│   │   │   │   ├── ticket_entity.dart
│   │   │   │   └── payment_method_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── raffle_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_raffle.dart
│   │   │       ├── get_my_raffles.dart
│   │   │       ├── get_raffle_by_id.dart
│   │   │       ├── update_raffle.dart
│   │   │       ├── delete_raffle.dart
│   │   │       ├── reserve_ticket.dart
│   │   │       ├── approve_payment.dart
│   │   │       └── reject_payment.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── raffle_bloc.dart
│   │       │   └── ticket_bloc.dart
│   │       ├── pages/
│   │       │   ├── dashboard_page.dart
│   │       │   ├── create_raffle_page.dart
│   │       │   ├── raffle_detail_page.dart
│   │       │   ├── ticket_board_page.dart
│   │       │   └── draw_page.dart
│   │       └── widgets/
│   │           ├── raffle_card.dart
│   │           ├── ticket_grid.dart
│   │           ├── ticket_item.dart
│   │           └── raffle_form.dart
│   │
│   ├── buyer/                   # WebView comprador
│   │   └── web_view/
│   │       ├── index.html
│   │       ├── styles.css
│   │       └── app.js
│   │
│   ├── social/                  # Generador stories
│   │   ├── data/
│   │   │   └── services/
│   │   │       └── story_generator_service.dart
│   │   └── presentation/
│   │       └── widgets/
│   │           └── story_preview.dart
│   │
│   └── subscription/            # Premium
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── shared/                      # Widgets compartidos
│   ├── widgets/
│   │   ├── app_button.dart
│   │   ├── app_text_field.dart
│   │   ├── app_card.dart
│   │   ├── loading_indicator.dart
│   │   ├── error_view.dart
│   │   └── empty_state.dart
│   │
│   └── theme/
│       ├── app_theme.dart
│       └── text_styles.dart
│
└── web_view/                   # WebView público
    ├── index.html
    ├── styles.css
    ├── app.js
    └── assets/
```

---

## 6. Componentes Reusables

### AppButton

```dart
// Variantes
AppButton(
  label: 'Crear Rifa',
  onPressed: () {},
  variant: AppButtonVariant.primary,  // primary, secondary, outline, text
  size: AppButtonSize.large,            // small, medium, large
  isLoading: false,
  icon: Icons.add,
)

// Estados
// - Default: color según variante
// - Pressed: opacity 0.8
// - Disabled: opacity 0.5
// - Loading: Spinner center
```

### AppTextField

```dart
AppTextField(
  label: 'Título de la rifa',
  hint: 'Ej: iPhone 15 Pro Max',
  controller: _titleController,
  validator: (value) => value.isEmpty ? 'Required' : null,
  keyboardType: TextInputType.text,
  maxLines: 2,
)
```

### RaffleCard

```dart
RaffleCard(
  raffle: raffleEntity,
  onTap: () => navigateToDetail(raffle.id),
  onShare: () => shareUrl(raffle.slug),
)
```

### TicketItem

```dart
TicketItem(
  number: 25,
  status: TicketStatus.available,  // available, reserved, sold, blocked
  onTap: () => handleTap(),
)
```

---

## 7. Navegación

### Rutas

| Ruta | Pantalla | Descripción |
|------|----------|-------------|
| `/` | Splash | Pantalla de carga |
| `/login` | Login | Iniciar sesión |
| `/register` | Register | Registrarse |
| `/dashboard` | Dashboard | Lista de rifas |
| `/raffle/create` | CreateRaffle | Crear rifa |
| `/raffle/:id` | RaffleDetail | Detalle rifa |
| `/raffle/:id/tickets` | TicketBoard | Tablero números |
| `/raffle/:id/draw` | Draw | Realizar sorteo |
| `/profile` | Profile | Perfil usuario |
| `/settings` | Settings | Configuración |
| `/premium` | Premium | Planes premium |
| `/r/:slug` | (WebView) | Vista pública |

### Navegador

- **go_router** para navegación declarativa
- Middleware de autenticación
- Deep linking para `/r/:slug`

---

## 8. Manejo de Estados

### BLoC Pattern

```
Event → BLoC → State
```

**Ejemplo: RaffleBloc**

```dart
// Events
abstract class RaffleEvent {}
class LoadRaffles extends RaffleEvent {}
class CreateRaffle extends RaffleEvent { ... }
class UpdateRaffle extends RaffleEvent { ... }
class DeleteRaffle extends RaffleEvent { ... }

// States
abstract class RaffleState {}
class RaffleInitial extends RaffleState {}
class RaffleLoading extends RaffleState {}
class RaffleLoaded extends RaffleState { List<RaffleEntity> raffles; }
class RaffleError extends RaffleState { String message; }
class RaffleCreated extends RaffleState { RaffleEntity raffle; }
```

### Estados UI Genéricos

| Estado | Descripción | Widget |
|--------|-------------|--------|
| **Initial** | Antes de cargar | - |
| **Loading** | Cargando datos | Shimmer/Spinner |
| **Loaded** | Datos cargados | Content |
| **Empty** | Sin datos | EmptyState widget |
| **Error** | Error | ErrorView con retry |
| **Success** | Operación exitosa | Snackbar |

---

## 9. Manejo de Errores

### Capas

```
UI → BLoC → UseCase → Repository → DataSource
```

### Tipos de Errores

```dart
// failures.dart
abstract class Failure {
  final String message;
  final int? code;
}

class ServerFailure extends Failure { ... }
class NetworkFailure extends Failure { ... }
class CacheFailure extends Failure { ... }
class ValidationFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
```

### Manejo en UI

```dart
// En el BLoC
emit(RaffleError(failure.message));

// En la página
if (state is RaffleError) {
  return ErrorView(
    message: state.message,
    onRetry: () => context.read<RaffleBloc>().add(LoadRaffles()),
  );
}
```

---

## 10. WebView Público (Comprador)

### index.html Structure

```html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rifa - {title}</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <div id="app">
    <!-- Header -->
    <header class="raffle-header">
      <h1>{raffle.title}</h1>
      <p class="prize">{raffle.prize_description}</p>
      <div class="price">{price} {currency}</div>
    </header>
    
    <!-- Progress -->
    <div class="progress-section">
      <div class="progress-bar">
        <div class="progress-fill" style="width: {percentage}%"></div>
      </div>
      <p class="progress-text">{sold}/{total} vendidos</p>
    </div>
    
    <!-- Ticket Grid -->
    <div class="ticket-grid" id="ticketGrid">
      <!-- Generated via JS -->
    </div>
    
    <!-- Selected Ticket -->
    <div class="selected-ticket" id="selectedTicket" style="display: none">
      <p>Número seleccionado: <strong>{number}</strong></p>
      <button class="whatsapp-btn" id="whatsappBtn">
        💬 Comprar por WhatsApp
      </button>
    </div>
  </div>
  
  <script src="app.js"></script>
</body>
</html>
```

### app.js Logic

```javascript
// Cargar rifa por slug
async function loadRaffle(slug) {
  const response = await fetch(`${API_URL}/raffles/${slug}`);
  const raffle = await response.json();
  renderRaffle(raffle);
}

// Renderizar grid de tickets
function renderTicketGrid(tickets) {
  tickets.forEach(ticket => {
    const el = document.createElement('div');
    el.className = `ticket ${ticket.status}`;
    el.textContent = ticket.number;
    el.onclick = () => selectTicket(ticket);
    grid.appendChild(el);
  });
}

// Seleccionar ticket
function selectTicket(ticket) {
  selectedTicket = ticket;
  document.getElementById('selectedTicket').style.display = 'block';
  updateWhatsAppLink();
}

// Generar link WhatsApp
function updateWhatsAppLink() {
  const phone = raffle.whatsapp_phone;
  const text = `Hola, quiero apartar el #${selectedTicket.number} de la rifa '${raffle.title}' (${raffle.ticket_price} ${raffle.currency})`;
  const url = `https://wa.me/${phone}?text=${encodeURIComponent(text)}`;
  document.getElementById('whatsappBtn').onclick = () => window.open(url, '_blank');
}
```

---

## 11. Generador de Stories

### Flujo

```dart
// 1. Capturar widget como imagen
final imageBytes = await screenshotController.capture(
  pixelRatio: 3.0,
);

// 2. Guardar en storage
final imageUrl = await storage.uploadImage(
  path: 'stories/${raffle.id}/${timestamp}.png',
  data: imageBytes,
);

// 3. Guardar registro en DB
await storyRepository.createStory(
  raffleId: raffle.id,
  imageUrl: imageUrl,
  triggerType: 'manual', // o 'sale', 'milestone_50', etc.
);

// 4. Compartir
await sharePlus.share(imagePath);
```

### Widget Template

```dart
class StoryWidget extends StatelessWidget {
  final String title;
  final String prize;
  final String price;
  final String currency;
  final int total;
  final int sold;
  final String url;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      height: 1920,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF10B981)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('RIFA ACTIVA', style: ...),
          Text(title, style: ...),
          Text('$price $currency', style: ...),
          // Progress bar
          // Call to action
          // URL
        ],
      ),
    );
  }
}
```

---

## 12. Edge Functions (Supabase)

### Functions Necesarias

| Function | Input | Output | Descripción |
|----------|-------|--------|-------------|
| `create-checkout-session` | plan_id | url | Crear sesión de pago |
| `verify-payment` | reference, method | status | Verificar pago |
| `draw-winner` | raffle_id, type | winner | Ejecutar sorteo |
| `generate-story` | raffle_id | image_url | Generar imagen |

---

## 13. Configuración de Entorno

### .env.example

```env
# Supabase
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJ...

# AdMob
ADMOB_APP_ID=ca-app-pub-xxxxx
ADMOB_BANNER_ID=ca-app-pub-xxxxx
ADMOB_INTERSTITIAL_ID=ca-app-pub-xxxxx

# URLs
WEB_VIEW_URL=https://rifalibre.app/r
API_URL=https://xxxxx.supabase.co
```

---

## 14. Testing Strategy

### Unit Tests
- UseCases
- Repositories (mock)
- BLoCs (mock dependencies)

### Widget Tests
- Componentes reusables
- Pages individuales

### Integration Tests
- Flujos completos (crear rifa, comprar ticket)
- Navigation

---

## 15. Deployment

### App Móvil
- **Android**: Google Play Console
- **iOS**: App Store Connect

### WebView
- **Vercel** o **Netlify** para hosting estático
- **Cloudflare** para CDN y dominio

### Backend
- **Supabase** (gestionado)
- Edge Functions via Supabase CLI
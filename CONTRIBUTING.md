# RifaLibre

Plataforma para crear y gestionar rifas automáticamente en Venezuela.

## Estado del Proyecto

**Fase:** Planificación completada ✓  
**Próximo paso:** Iniciar implementación del Sprint 1

## Estructura del Proyecto

```
rifalibre/
├── README.md              # Plan de ejecución completo
├── SPEC.md                # Especificación técnica
├── database_schema.sql    # Schema de base de datos (Supabase)
├── ROADMAP.md             # Roadmap de implementación
├── pubspec.yaml           # Dependencias Flutter
├── web_view/              # WebView público (comprador)
│   ├── index.html
│   ├── styles.css
│   └── app.js
└── (src/)                 # Código Flutter (por crear)
```

## Primeros Pasos

1. **Crear cuenta Supabase** - https://supabase.com
2. **Ejecutar database_schema.sql** en el panel de SQL de Supabase
3. **Crear proyecto Flutter** - `flutter create rifalibre`
4. **Agregar dependencias** - copiar pubspec.yaml
5. **Iniciar implementación** - ver ROADMAP.md

## Documentación

- [README.md](README.md) - Plan completo del producto
- [SPEC.md](SPEC.md) - Especificación técnica detallada
- [database_schema.sql](database_schema.sql) - Schema de base de datos
- [ROADMAP.md](ROADMAP.md) - Roadmap de implementación

## Features Implementadas en el Plan

- ✓ Crear y gestionar rifas
- ✓ URL pública para compradores (WebView)
- ✓ Compra por WhatsApp directo
- ✓ Tablero visual de números
- ✓ Sistema de pagos (Pago Móvil, Zelle, Binance)
- ✓ Generador de imágenes para Stories
- ✓ Sistema Premium/Suscripciones
- ✓ Publicidad (AdMob)

## License

MIT License
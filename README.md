# El Dorado — Frontend Coding Interview

> Prueba técnica completada · Flutter · Clean Architecture · BLoC/Cubit

---

## Descripción del reto original

Implementar una mini calculadora de intercambio de divisas que muestre cuánto recibirá el usuario al cambiar una cantidad de una moneda a otra (FIAT ↔ CRYPTO), consumiendo el API público de recomendaciones de El Dorado.

---

## Lo que se entregó

Se diseñó y construyó una **SuperApp P2P de intercambio de criptomonedas** completa, con cuatro pantallas principales, flujos de navegación real y persistencia local — todo bajo los principios de arquitectura escalable y un sistema de diseño editorial propio.

### Pantallas principales

| Ruta | Pantalla | Descripción |
|---|---|---|
| `/` | **Home** | Calculadora de intercambio en vivo con tasas dinámicas desde el API |
| `/wallet` | **Wallet** | Gestión de activos y métodos de pago del usuario |
| `/activity` | **Activity** | Historial de transacciones agrupado por fecha |
| `/settings` | **Settings** | Perfil, temas y gestión de cuentas bancarias |
| `/p2p/offers` | **P2P — Ofertas** | Listado de traders para completar un cambio |
| `/p2p/transaction` | **P2P — Transacción** | Confirmación y ejecución de una operación P2P |
| `/settings/personal-info` | **Información Personal** | Edición y persistencia del perfil del usuario |
| `/settings/bank-accounts` | **Cuentas Bancarias** | CRUD completo con soporte para cuenta predeterminada |

---

## Arquitectura

El proyecto sigue una **Clean Architecture** dividida en dos capas principales:

```
lib/
├── domain/                    # Reglas de negocio puras
│   ├── models/                # Entidades (OfferModel, CurrencyModel, BankAccountModel…)
│   ├── repositories/          # Contratos / interfaces
│   ├── usecases/              # Casos de uso (uno por acción de negocio)
│   └── di/                    # Contenedor de inyección de dependencias (get_it)
│
└── infrastructure/            # Implementaciones concretas
    ├── data/
    │   └── cubits/            # Estado de la UI (ThemeCubit, CurrencyCubit, WalletCubit…)
    ├── network/
    │   └── datasources/       # Clientes HTTP (Dio) y datasources locales (Hive)
    ├── repositories_impl/     # Implementaciones de los contratos del dominio
    ├── storage/               # Inicialización y helpers de Hive CE
    ├── router/                # go_router: rutas, ShellRoute y AppShell
    └── ui/
        ├── theme/             # Dos sistemas de diseño compilados como ThemeData
        ├── screens/           # Páginas completas (Home, Wallet, Activity, Settings, P2P)
        └── widgets/
            ├── atoms/         # Primitivos visuales (botones, badges, avatars…)
            ├── molecules/     # Composiciones simples (SectionHeader, CurrencyRow…)
            └── organisms/     # Bloques complejos (ExchangeCard, WealthCard, OfferCard…)
```

### Gestión de estado

Cada dominio funcional tiene su propio **Cubit** registrado globalmente a través de `get_it`:

| Cubit | Responsabilidad |
|---|---|
| `ThemeCubit` | Variante activa del design system (4 opciones) |
| `CurrencyCubit` | Carga y caché de pares FIAT/CRYPTO desde el API |
| `PaymentMethodCubit` | Métodos de pago disponibles |
| `HomeCubit` | Estado de la calculadora de intercambio |
| `WalletCubit` | Activos y saldo del usuario |
| `ActivityCubit` | Historial de transacciones |
| `TradersCubit` | Listado de traders P2P |
| `BankAccountCubit` | CRUD de cuentas bancarias con persistencia Hive |

---

## Sistemas de diseño

El proyecto incluye **dos design systems** intercambiables en tiempo de ejecución:

### 🌟 Golden Standard (Light/Dark)
Paleta inspirada en el branding de El Dorado: fondos Soft Cyan, acentos en El Dorado Gold `#FFB400`. Tipografía **Manrope** para headlines + **Inter** para datos. Ideal para la calculadora de cambio.

### ⚡ Electric Alchemist (Light/Dark)
Sistema editorial de alto contraste: superficie base `#131313`, acentos en Vibrant Yellow `#EFFF00`. Tipografía **Space Grotesk** + **Inter**. Glassmorfismo, tonal layering y sin bordes de 1px.

Ambos themes se seleccionan desde `Settings → Tema`.

---

## Stack técnico

| Categoría | Librería / Herramienta |
|---|---|
| UI Framework | Flutter 3 + Material 3 |
| Navegación | `go_router ^17` — ShellRoute + rutas anidadas |
| Estado | `flutter_bloc ^9` · `bloc ^9` — Cubit pattern |
| Tipografías | `google_fonts ^8` — Manrope, Space Grotesk, Inter |
| HTTP client | `dio ^5` |
| Persistencia local | `hive_ce ^2` + `path_provider` |
| DI Container | `get_it ^9` |
| Igualdad de modelos | `equatable ^2` |
| Aritmética decimal | `decimal ^3` |
| Análisis estático | `flutter_lints ^6` |

---

## API de El Dorado

```
GET https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations
```

| Parámetro | Tipo | Descripción |
|---|---|---|
| `type` | `int` | `0` = CRYPTO→FIAT · `1` = FIAT→CRYPTO |
| `cryptoCurrencyId` | `string` | ID de la moneda crypto (ej. `USDT`) |
| `fiatCurrencyId` | `string` | ID de la moneda fiat (ej. `VES`) |
| `amount` | `number` | Cantidad a cambiar |
| `amountCurrencyId` | `string` | Moneda en la que se expresa el `amount` |

**Campo clave en la respuesta:** `data.byPrice.fiatToCryptoExchangeRate`

---

## Cómo ejecutar el proyecto

```bash
# 1. Clonar el repositorio
git clone <url-del-fork>

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar en modo debug
flutter run

# 4. (Opcional) Ejecutar en un dispositivo/emulador específico
flutter run -d <device-id>
```

> Requiere Flutter SDK `^3.11.4` y Dart SDK `^3.11.4`.

---

## Decisiones técnicas destacadas

- **Atomic Design en widgets**: cada componente visual sigue la jerarquía atoms → molecules → organisms, garantizando reusabilidad y separación de responsabilidades.
- **Sin bordes de 1px para división**: el sistema de diseño prohíbe separadores de línea; la jerarquía se expresa exclusivamente mediante diferencias de color en las superficies (tonal layering).
- **Persistencia con Hive CE**: cuentas bancarias e información personal se persisten localmente de forma reactiva, conectadas al Cubit correspondiente.
- **Tasa de cambio con `decimal`**: toda la aritmética monetaria usa el tipo `Decimal` para evitar errores de punto flotante IEEE 754.
- **Dos design systems compilados**: los cuatro `ThemeData` se generan en tiempo de compilación a partir de tokens semánticos; el cambio de tema se aplica con animación suave de 300 ms.

---

_Prueba técnica desarrollada por **[Tu Nombre]** · Abril 2026_

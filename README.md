# El Dorado — Frontend Coding Interview

> Prueba técnica completada · Flutter · Clean Architecture · BLoC/Cubit

---

## Descripción del reto original

Implementar una mini calculadora de intercambio de divisas que muestre cuánto recibirá el usuario al cambiar una cantidad de una moneda a otra (FIAT ↔ CRYPTO), consumiendo el API público de recomendaciones de El Dorado.

---

## Lo que se entregó

Se diseñó y construyó una **SuperApp P2P de intercambio de criptomonedas** completa, con cuatro pantallas principales, flujos de navegación real y persistencia local — todo bajo los principios de arquitectura escalable y un sistema de diseño editorial propio.

### Pantallas principales

| Ruta                      | Pantalla                 | Descripción                                                         |
| ------------------------- | ------------------------ | ------------------------------------------------------------------- |
| `/`                       | **Home**                 | Calculadora de intercambio en vivo con tasas dinámicas desde el API |
| `/wallet`                 | **Wallet**               | Gestión de activos y métodos de pago del usuario                    |
| `/activity`               | **Activity**             | Historial de transacciones agrupado por fecha                       |
| `/settings`               | **Settings**             | Perfil, temas y gestión de cuentas bancarias                        |
| `/p2p/offers`             | **P2P — Ofertas**        | Listado de traders para completar un cambio                         |
| `/p2p/transaction`        | **P2P — Transacción**    | Confirmación y ejecución de una operación P2P                       |
| `/settings/personal-info` | **Información Personal** | Edición y persistencia del perfil del usuario                       |
| `/settings/bank-accounts` | **Cuentas Bancarias**    | CRUD completo con soporte para cuenta predeterminada                |

---

## Arquitectura

El proyecto implementa **Clean Architecture** en dos capas estrictas (`domain` e `infrastructure`), con separación completa de responsabilidades entre reglas de negocio, estado de UI e implementaciones concretas.

```
lib/
│   main.dart                                  ← Entry point: DI + Hive + MultiBlocProvider
│
├── domain/                                    🏛️  CAPA DE DOMINIO (sin dependencias de Flutter)
│   ├── di/
│   │       injection_container.dart           ← Registro global de dependencias (get_it)
│   │
│   ├── models/                                ← Entidades puras del negocio
│   │       recommendation_response.dart       ← DTO del API de recomendaciones
│   │
│   ├── repositories/                          ← Contratos (interfaces abstractas)
│   │
│   └── usecases/                              ← Un caso de uso por acción de negocio
│           calculate_conversion.dart          ← Aritmética con Decimal (sin IEEE 754)
│           get_recommendations.dart           ← Consulta al API público de El Dorado
│
└── infrastructure/                            ⚙️  CAPA DE INFRAESTRUCTURA
    │
    ├── data/
    │   ├── blocs/
    │   │   └── exchange/                      ← BLoC completo (events + states) para el intercambio
    │   │
    │   └── cubits/                            ← Estado de UI por dominio funcional
    │       ├── bank_account/
    │       │       bank_account_cubit.dart    ← CRUD + estado predeterminado (Hive CE)
    │       ├── theme/
    │       │       theme_cubit.dart           ← Selector de design system (4 variantes)
    │
    ├── network/
    │   │   dio_client.dart                    ← Cliente HTTP base (Dio + interceptores)
    │   └── datasources/
    │
    ├── repositories_impl/                     ← Implementaciones de los contratos del dominio
    │
    ├── router/
    │       app_router.dart                    ← GoRouter: rutas, parámetros y ShellRoute
    │       app_shell.dart                     ← Shell persistente con NavigationBar
    │
    ├── storage/
    │       hive_storage.dart                  ← Init de Hive CE + registro de adaptadores
    │
    └── ui/
        ├── screens/                           ← Páginas completas (una por ruta)
        │
        ├── theme/                             ← Sistema de theming doble (4 ThemeData)
        │       registry.dart                  ← Extensión AppThemeVariantX → pair()
        │       tokens.dart                    ← Design tokens semánticos compartidos
        │
        └── widgets/                           ← Atomic Design: 3 niveles de composición
            │   widgets.dart                   ← Barrel export único
            ├── atoms/                         ← Primitivos visuales indivisibles (23 widgets)
            ├── molecules/                     ← Composiciones de 2+ átomos (20 widgets)
            └── organisms/                     ← Secciones complejas y auto-suficientes (17 widgets)
                    exchange_card.dart          ← Calculadora principal de intercambio
                    wealth_card.dart            ← Tarjeta de saldo glassmórfica
```

### Gestión de estado

El proyecto combina **BLoC** (para flujos con eventos explícitos) y **Cubit** (para estado más simple), todos registrados globalmente vía `get_it`:

| Clase                | Tipo  | Responsabilidad                                                               |
| -------------------- | ----- | ----------------------------------------------------------------------------- |
| `ExchangeBloc`       | BLoC  | Flujo de intercambio con eventos (`AmountChanged`, `CurrencySwapped`…)        |
| `ThemeCubit`         | Cubit | Variante activa del design system (4 opciones: Golden/Alchemist × Light/Dark) |
| `CurrencyCubit`      | Cubit | Carga y caché de pares FIAT/CRYPTO desde el API                               |
| `PaymentMethodCubit` | Cubit | Métodos de pago disponibles globalmente                                       |
| `HomeCubit`          | Cubit | Estado de la pantalla principal                                               |
| `WalletCubit`        | Cubit | Activos y saldo del usuario                                                   |
| `ActivityCubit`      | Cubit | Historial de transacciones agrupado                                           |
| `TradersCubit`       | Cubit | Listado de traders P2P                                                        |
| `BankAccountCubit`   | Cubit | CRUD de cuentas bancarias + cuenta predeterminada (Hive CE)                   |
| `ProfileCubit`       | Cubit | Lectura y escritura del perfil del usuario (Hive CE)                          |

---

## Atomic Design — Gestión de Widgets

La capa de UI sigue estrictamente la metodología **Atomic Design**, dividiendo todos los widgets en tres niveles de composición. Ningún screen contiene lógica de layout inline; todo está delegado a componentes especializados.

```
widgets/
├── atoms/        ← Unidad mínima, sin dependencias de otros widgets propios
├── molecules/    ← Componen 2+ átomos con una responsabilidad concreta
└── organisms/    ← Secciones completas, auto-suficientes, conectadas al BLoC/Cubit
```

### Reglas de composición

| Nivel        | Puede depender de               | No puede depender de  | Ejemplos                                                    |
| ------------ | ------------------------------- | --------------------- | ----------------------------------------------------------- |
| **Atom**     | Flutter SDK únicamente          | Moléculas, organismos | `PrimaryButton`, `StatusDot`, `CurrencyPill`, `TrendBadge`  |
| **Molecule** | Átomos + Flutter SDK            | Organismos            | `CurrencyRow`, `SectionHeader`, `SellerInfo`, `SwapDivider` |
| **Organism** | Moléculas + Átomos + BLoC/Cubit | –                     | `ExchangeCard`, `WealthCard`, `OfferCard`, `ActivityFeed`   |

### ¿Por qué este enfoque?

- **`widgets.dart`** funciona como barrel export único: los screens solo hacen `import '../widgets/widgets.dart'`.
- Modificar un átomo (ej. cambiar el radio de `PrimaryButton`) se propaga automáticamente a todas las moléculas y organismos que lo usan.
- Cada nivel tiene una única razón para cambiar, aplicando el **Single Responsibility Principle** a nivel de widget.

---

## Solicitudes Remotas — Dio + Datasources

Las llamadas HTTP se centralizan en una arquitectura de **datasource + repository**, separando la lógica de red de la lógica de negocio.

### Flujo de una solicitud

```
Screen / Cubit
    └─► UseCase (dominio)
            └─► Repository (contrato abstracto)
                    └─► RepositoryImpl (infraestructura)
                            └─► Datasource (red o local)
                                    └─► DioClient (HTTP base)
                                            └─► API de El Dorado
```

### `DioClient` — Cliente HTTP base

`infrastructure/network/dio_client.dart` centraliza toda la configuración de Dio:

- `BaseOptions` con `baseUrl` y `connectTimeout` / `receiveTimeout`
- **Interceptores** para logging de requests/responses en modo debug
- Manejo uniforme de `DioException` → errores del dominio

### Datasources implementados

| Datasource                         | Tipo      | Descripción                                                           |
| ---------------------------------- | --------- | --------------------------------------------------------------------- |
| `recommendation_remote_datasource` | 🌐 Remote | Consulta el endpoint `/recommendations` (tasa de cambio + ofertantes) |
| `currency_remote_datasource`       | 🌐 Remote | Obtiene el catálogo FIAT/CRYPTO desde `/currencies`                   |
| `payment_method_remote_datasource` | 🌐 Remote | Lista de métodos de pago disponibles                                  |
| `activity_mock_remote_datasource`  | 🎭 Mock   | Datos simulados de historial de transacciones                         |
| `wallet_mock_remote_datasource`    | 🎭 Mock   | Saldo y activos del usuario (simulados)                               |
| `bank_account_local_datasource`    | 💾 Local  | CRUD de cuentas bancarias sobre Hive CE                               |
| `profile_local_datasource_impl`    | 💾 Local  | Lectura/escritura del perfil del usuario en Hive CE                   |

> Los datasources `mock` están preparados para ser reemplazados por implementaciones reales sin tocar el dominio ni los Cubits, gracias a la inversión de dependencias.

---

## Gestión de Temas — Dual Design System

El proyecto implementa **dos sistemas de diseño completos**, cada uno con variante clara y oscura, para un total de **4 `ThemeData`** que se intercambian en tiempo de ejecución.

### Estructura del sistema de temas

```
ui/theme/
├── tokens.dart                    ← Design tokens semánticos compartidos (colores, tipografías, espaciado)
├── theme_factory.dart             ← Interfaz AbstractFactory que cada sistema implementa
├── golden_standard_factory.dart   ← Crea GS Light + GS Dark
├── golden_standard_light.dart
├── golden_standard_dark.dart
├── electric_alchemist_factory.dart ← Crea EA Light + EA Dark
├── electric_alchemist_light.dart
├── electric_alchemist_dark.dart
├── app_theme.dart                 ← Enum AppThemeVariant (goldenLight, goldenDark, alchemistDark, alchemistLight)
└── registry.dart                  ← Extensión AppThemeVariantX: pair() → (ThemeData, ThemeData)
```

### Cómo funciona el cambio de tema

1. El usuario selecciona un tema en `Settings → Tema` (`ThemePickerBottomSheet`).
2. `ThemeCubit` actualiza el `AppThemeVariant` activo y lo persiste en `SharedPreferences`.
3. `ElDoradoApp` escucha el `ThemeCubit` con `BlocBuilder`.
4. `variant.pair()` resuelve el par `(ThemeData light, ThemeData dark)` correspondiente.
5. `MaterialApp.router` aplica el cambio con animación de **300 ms** (`Curves.easeInOut`).

### Tabla de variantes

| `AppThemeVariant` | Design System      | Modo     | Paleta base           | Tipografía display |
| ----------------- | ------------------ | -------- | --------------------- | ------------------ |
| `goldenLight`     | Golden Standard    | ☀️ Light | Soft Cyan + `#FFB400` | Manrope            |
| `goldenDark`      | Golden Standard    | 🌙 Dark  | Deep Navy + `#FFB400` | Manrope            |
| `alchemistLight`  | Electric Alchemist | ☀️ Light | Blanco + `#EFFF00`    | Space Grotesk      |
| `alchemistDark`   | Electric Alchemist | 🌙 Dark  | `#131313` + `#EFFF00` | Space Grotesk      |

---

## Persistencia Local — Hive CE

Los datos que deben sobrevivir entre sesiones se persisten localmente usando **Hive CE** (`hive_ce ^2`), una base de datos NoSQL orientada a objetos, extremadamente rápida para Flutter.

### Inicialización

`HiveStorage.init()` en `main()` (antes de `runApp`) inicializa Hive, establece el directorio de almacenamiento (`path_provider`) y registra todos los adaptadores de tipo.

### Datos persistidos

| Entidad                                             | Box de Hive     | Operaciones                                                   |
| --------------------------------------------------- | --------------- | ------------------------------------------------------------- |
| **Cuentas bancarias** (`BankAccountModel`)          | `bank_accounts` | Crear, leer, actualizar, eliminar, marcar como predeterminada |
| **Perfil del usuario** (`PersonalInformationModel`) | `profile`       | Leer y guardar (upsert)                                       |
| **Tema seleccionado** (`AppThemeVariant`)           | `settings`      | Leer y guardar                                                |

### Flujo de persistencia (ejemplo: cuenta bancaria)

```
UI (BankAccountsScreen)
    └─► BankAccountCubit.add(account)
            └─► AddBankAccountUseCase(repo)
                    └─► BankAccountRepositoryImpl
                            └─► BankAccountLocalDatasource
                                    └─► Hive Box<BankAccountModel>.put(key, model)
```

El Cubit emite un nuevo estado después de cada operación, actualizando la UI de forma reactiva sin necesidad de refrescar manualmente.

---

## Documentación del API — `API.md`

Durante la fase de exploración del API se creó el archivo [`API.md`](./API.md), una **referencia técnica completa** generada **exclusivamente a partir de 52 llamadas reales con `curl.exe`** en Windows 11 PowerShell.

> [!NOTE]
> En PowerShell, `curl` es alias de `Invoke-WebRequest`. Se usó `curl.exe` en todos los casos para invocar el binario real de curl y obtener respuestas precisas.

### Qué cubre `API.md`

| Sección                                 | Descripción                                         |
| --------------------------------------- | --------------------------------------------------- |
| Quick Reference                         | Ejemplo mínimo funcional                            |
| Endpoint de Monedas `/currencies`       | Estructura del catálogo FIAT/CRYPTO                 |
| Headers de respuesta                    | CORS, Content-Type, `X-Cache`                       |
| Query Parameters                        | Tabla de parámetros requeridos y opcionales         |
| Estado por par de moneda                | Liquidez real de VES, COP, BRL, PEN, USD            |
| Comportamiento de `amountCurrencyId`    | Casos edge y comportamientos inesperados            |
| Catálogo de errores de validación       | 11 causas de error con mensajes exactos             |
| Estructura completa del response        | Todos los campos con tipos y observaciones          |
| Sistema de Scores (`mmScore`/`mtScore`) | Tiers NO_TIER, SILVER, GOLD y métricas individuales |
| Métodos de pago observados              | 16 métodos con IDs exactos por país                 |
| Campo clave `fiatToCryptoExchangeRate`  | Fórmulas de conversión CRYPTO↔FIAT                  |
| 52 llamadas documentadas                | Tabla de todos los requests con resultado           |
| Notas Flutter/Dart                      | Snippets de parsing del response en Dart            |
| Notas JS/Python                         | Snippets equivalentes para otras plataformas        |
| Árbol de decisión (Mermaid)             | Flowchart para manejar los 3 casos de respuesta     |
| Preguntas frecuentes (FAQ)              | 8 preguntas clave con respuesta documentada         |
| Ejemplos reales de respuesta            | JSON completo de llamadas exitosas reales           |

### Hallazgos clave del proceso de testing

- El HTTP Status es **siempre `200 OK`** — los errores se detectan por el body JSON, no por el código HTTP.
- `fiatToCryptoExchangeRate` es un **`String`**, no un `number` (evita pérdida de precisión IEEE 754).
- `VES` (Bolívar Venezolano) **no tiene liquidez** en ningún escenario probado.
- Solo `TATUM-TRON-USDT` es el `cryptoCurrencyId` válido (BTC, ETH retornan error).
- `amount` y `amountCurrencyId` son técnicamente opcionales (el servidor no los valida como requeridos).
- No existe caché en CloudFront para este endpoint — las tasas son siempre en tiempo real.

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

| Categoría           | Librería / Herramienta                            |
| ------------------- | ------------------------------------------------- |
| UI Framework        | Flutter 3 + Material 3                            |
| Navegación          | `go_router ^17` — ShellRoute + rutas anidadas     |
| Estado              | `flutter_bloc ^9` · `bloc ^9` — Cubit pattern     |
| Tipografías         | `google_fonts ^8` — Manrope, Space Grotesk, Inter |
| HTTP client         | `dio ^5`                                          |
| Persistencia local  | `hive_ce ^2` + `path_provider`                    |
| DI Container        | `get_it ^9`                                       |
| Igualdad de modelos | `equatable ^2`                                    |
| Aritmética decimal  | `decimal ^3`                                      |
| Análisis estático   | `flutter_lints ^6`                                |

---

## API de El Dorado

```
GET https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations
```

| Parámetro          | Tipo     | Descripción                             |
| ------------------ | -------- | --------------------------------------- |
| `type`             | `int`    | `0` = CRYPTO→FIAT · `1` = FIAT→CRYPTO   |
| `cryptoCurrencyId` | `string` | ID de la moneda crypto (ej. `USDT`)     |
| `fiatCurrencyId`   | `string` | ID de la moneda fiat (ej. `VES`)        |
| `amount`           | `number` | Cantidad a cambiar                      |
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

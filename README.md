# El Dorado — Frontend Coding Interview

> Prueba técnica completada · Flutter · Clean Architecture · BLoC/Cubit

---

## Descripción del reto original

Implementar una mini calculadora de intercambio de divisas que muestre cuánto recibirá el usuario al cambiar una cantidad de una moneda a otra (FIAT ↔ CRYPTO), consumiendo el API público de recomendaciones de El Dorado.

---

## Lo que se entregó

<table width="100%">
<tr>
<td width="350" valign="top" align="center">
<img src="./demo.gif" alt="El Dorado App Demo" width="350" />
</td>
<td valign="top">

<p>Se diseñó y construyó una <strong>SuperApp P2P de intercambio de criptomonedas</strong> completa, con cuatro pantallas principales, flujos de navegación real y persistencia local — todo bajo los principios de arquitectura escalable y un sistema de diseño editorial propio.</p>

<h3>Pantallas principales</h3>

<table>
<thead>
<tr>
<th>Ruta</th>
<th>Pantalla</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>/</code></td>
<td><strong>Home</strong></td>
<td>Calculadora de intercambio en vivo con tasas dinámicas desde el API</td>
</tr>
<tr>
<td><code>/wallet</code></td>
<td><strong>Wallet</strong></td>
<td>Gestión de activos y métodos de pago del usuario</td>
</tr>
<tr>
<td><code>/activity</code></td>
<td><strong>Activity</strong></td>
<td>Historial de transacciones agrupado por fecha</td>
</tr>
<tr>
<td><code>/settings</code></td>
<td><strong>Settings</strong></td>
<td>Perfil, temas y gestión de cuentas bancarias</td>
</tr>
<tr>
<td><code>/p2p/offers</code></td>
<td><strong>P2P — Ofertas</strong></td>
<td>Listado de traders para completar un cambio</td>
</tr>
<tr>
<td><code>/p2p/transaction</code></td>
<td><strong>P2P — Transacción</strong></td>
<td>Confirmación y ejecución de una operación P2P</td>
</tr>
<tr>
<td><code>/settings/personal-info</code></td>
<td><strong>Información Personal</strong></td>
<td>Edición y persistencia del perfil del usuario</td>
</tr>
<tr>
<td><code>/settings/bank-accounts</code></td>
<td><strong>Cuentas Bancarias</strong></td>
<td>CRUD completo con soporte para cuenta predeterminada</td>
</tr>
</tbody>
</table>

<hr />

<h4>Gestión de estado</h4>

<p>El proyecto combina <strong>BLoC</strong> (para flujos con eventos explícitos) y <strong>Cubit</strong> (para estado más simple), todos registrados globalmente vía <code>get_it</code>:</p>

<table>
<thead>
<tr>
<th>Clase</th>
<th>Tipo</th>
<th>Responsabilidad</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>ExchangeBloc</code></td>
<td>BLoC</td>
<td>Flujo de intercambio con eventos (<code>AmountChanged</code>, <code>CurrencySwapped</code>…)</td>
</tr>
<tr>
<td><code>ThemeCubit</code></td>
<td>Cubit</td>
<td>Variante activa del design system (4 opciones: Golden/Alchemist × Light/Dark)</td>
</tr>
<tr>
<td><code>CurrencyCubit</code></td>
<td>Cubit</td>
<td>Carga y caché de pares FIAT/CRYPTO desde el API</td>
</tr>
<tr>
<td><code>PaymentMethodCubit</code></td>
<td>Cubit</td>
<td>Métodos de pago disponibles globalmente</td>
</tr>
<tr>
<td><code>HomeCubit</code></td>
<td>Cubit</td>
<td>Estado de la pantalla principal</td>
</tr>
<tr>
<td><code>WalletCubit</code></td>
<td>Cubit</td>
<td>Activos y saldo del usuario</td>
</tr>
<tr>
<td><code>ActivityCubit</code></td>
<td>Cubit</td>
<td>Historial de transacciones agrupado</td>
</tr>
<tr>
<td><code>TradersCubit</code></td>
<td>Cubit</td>
<td>Listado de traders P2P</td>
</tr>
<tr>
<td><code>BankAccountCubit</code></td>
<td>Cubit</td>
<td>CRUD de cuentas bancarias + cuenta predeterminada (Hive CE)</td>
</tr>
<tr>
<td><code>ProfileCubit</code></td>
<td>Cubit</td>
<td>Lectura y escritura del perfil del usuario (Hive CE)</td>
</tr>
</tbody>
</table>

</td>
</tr>
</table>

<h3>Arquitectura</h3>

<p>El proyecto implementa <strong>Clean Architecture</strong> en dos capas estrictas (<code>domain</code> e <code>infrastructure</code>), con separación completa de responsabilidades entre reglas de negocio, estado de UI e implementaciones concretas.</p>

<pre><code>lib/
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
                    wealth_card.dart            ← Tarjeta de saldo glassmórfica</code></pre>

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

_Prueba técnica desarrollada por **Michell Excellent Marin** · Abril 2026_

---

## 👨‍💻 About the Author & Developer Profile

<table width="100%" style="border-collapse: collapse; border: none;">
<tr>
<td width="30%" valign="top">
<div align="center">
<a href="https://github.com/Miyo-Excellent">
<img src="https://avatars.githubusercontent.com/Miyo-Excellent" width="150" height="150" style="border-radius: 50%; border: 3px solid #FFB400; object-fit: cover; display: block;" alt="Michell Excellent Marin"/>
</a>
<br/>
<h2>Michell Excellent Marin</h2>
<p><b>Senior Full-Stack Developer</b></p>
<br/>
<a href="https://github.com/Miyo-Excellent"><img src="https://img.shields.io/badge/GitHub-Miyo--Excellent-181717?style=flat-square&logo=github" alt="GitHub"></a>
<br/><br/>
<a href="https://www.linkedin.com/in/michellexcellent/"><img src="https://img.shields.io/badge/LinkedIn-michellexcellent-0A66C2?style=flat-square&logo=linkedin" alt="LinkedIn"></a>
</div>
<hr/>
<h3>📫 Contacto</h3>
<ul style="list-style-type: none; padding-left: 0; font-size: 13.5px;">
<li>🌍 <b>Colombia</b> (Bogotá)</li>
<li>🏢 Remoto / Relocación</li>
<li>✉️ <a href="mailto:theofficesmichell@gmail.com">Email Directo</a></li>
<li>🗣️ Español e Inglés</li>
</ul>
<hr/>
<h3>🛠️ Tech Stack</h3>
<p style="font-size: 13.5px;"><b>Core:</b><br/>
<img src="https://img.shields.io/badge/-TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white" /> <img src="https://img.shields.io/badge/-JS-F7DF1E?style=flat-square&logo=javascript&logoColor=black" /> <br/><img src="https://img.shields.io/badge/-Kotlin-7F52FF?style=flat-square&logo=kotlin&logoColor=white" /> <img src="https://img.shields.io/badge/-Dart-0175C2?style=flat-square&logo=dart&logoColor=white" /></p>
<p style="font-size: 13.5px;"><b>Frontend & Mobile:</b><br/>
<img src="https://img.shields.io/badge/-React-20232A?style=flat-square&logo=react&logoColor=61DAFB" /> <img src="https://img.shields.io/badge/-Next.js-000000?style=flat-square&logo=Next.js&logoColor=white" /> <img src="https://img.shields.io/badge/-Redux-593D88?style=flat-square&logo=redux&logoColor=white" /> <br/><img src="https://img.shields.io/badge/-Tailwind-38B2AC?style=flat-square&logo=tailwind-css&logoColor=white" /> <img src="https://img.shields.io/badge/-Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" /></p>
<p style="font-size: 13.5px;"><b>Backend & DB:</b><br/>
<img src="https://img.shields.io/badge/-Node.js-339933?style=flat-square&logo=nodedotjs&logoColor=white" /> <img src="https://img.shields.io/badge/-Express-000000?style=flat-square&logo=express&logoColor=white" /> <br/><img src="https://img.shields.io/badge/-PostgreSQL-4169E1?style=flat-square&logo=postgresql&logoColor=white" /></p>
<hr/>
<h3>🎓 Educación</h3>
<ul style="padding-left: 15px; font-size: 13.5px;">
<li style="margin-bottom: 8px;"><b>TSU Informática</b><br/><i>IUNP (2012-2015)</i></li>
<li><b><a href="https://platzi.com/p/theofficesmichell/" target="_blank">Platzi Top Student</a></b><br/><i>12.5k pts, 47 Certs.</i></li>
</ul>

<p style="font-size: 14px;">🏆 <b>Rutas:</b></p>
<ul style="padding-left: 15px; font-size: 13.5px; display: flex; flex-direction: column; gap: 10px;">
<li style="margin-bottom: 8px;"><b>📱 Mobile:</b> iOS & Flutter<br/>
  <div style="margin-top: 3px; display: flex; flex-direction: row; gap: 10px;">
    <a href="https://platzi.com/p/theofficesmichell/curso/1603-flutter-avanzado/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-avanzado-flutter-fb7e966a-b3e0-472c-a390-bbc0489d7812.png" width="22" height="22" title="Flutter Avanzado"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2354-swiftui-apps-ios/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge_desarrollo-aplicaciones-ios-swiftui-b4cad4fd-ba82-4db1-8c50-814cb4418a85.png" width="22" height="22" title="iOS & SwiftUI"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2365-swiftui-especializacion/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badges-swiftui-335abf65-922a-427d-bdf4-a07c7f9db1db.png" width="22" height="22" title="SwiftUI"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2245-kotlin-2021/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-kotlin-eb74bb6e-ee76-4b91-9f17-be3d1da8804d.png" width="22" height="22" title="Kotlin"/></a>
  </div>
</li>
<li style="margin-bottom: 8px;"><b>🌐 Web:</b> JS & React<br/>
  <div style="margin-top: 3px; display: flex; flex-direction: row; gap: 10px;">
    <a href="https://platzi.com/p/theofficesmichell/curso/2467-frontend-developer/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-curso-frontend-developer-825407d1-49b1-4c9b-90c4-eee793720ede.png" width="22" height="22" title="Frontend Developer"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/1642-javascript-profesional/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-profesional-javascript-13538df2-24ce-433f-9aa6-e34eed608e70.png" width="22" height="22" title="JS Profesional"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/1798-javascript-navegador/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-javascript-engine-v8-navegador-de67cba4-0548-4361-9c6a-1a25aa96fa2a.png" width="22" height="22" title="JS Engine V8"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2558-react-native-formularios-almacenamiento/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/practico-react-native-formularios-almacenamiento_badge-dac0684a-0303-41fc-b54a-91f9.png" width="22" height="22" title="React Native"/></a>
  </div>
</li>
<li style="margin-bottom: 8px;"><b>⚙️ Back:</b> Node & Nest<br/>
  <div style="margin-top: 3px; display: flex; flex-direction: row; gap: 10px;">
    <a href="https://platzi.com/p/theofficesmichell/curso/1759-fundamentos-node/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-fundamentos-nodejs-8fd9c0f4-562a-48e9-a85a-3a7db0fa384b.png" width="22" height="22" title="Node.js"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2272-nestjs-2021/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-backend-nestjs-1409a1f0-34ad-495b-8144-14be0c0f0232.png" width="22" height="22" title="NestJS"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2274-nestjs-modular/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-programacionmod-601a4224-0aa1-4738-b545-8050df95f6f7.png" width="22" height="22" title="NestJS Modular"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/1763-npm-js/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-gestion-dependencias-paquetes-npm-f02e4608-c688-4d99-aa6d-293ea6c0be8d.png" width="22" height="22" title="NPM"/></a>
  </div>
</li>
<li><b>🧩 CS:</b> Git & POO<br/>
  <div style="margin-top: 3px; display: flex; flex-direction: row; gap: 10px;">
    <a href="https://platzi.com/p/theofficesmichell/curso/1474-oop/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badges-poo-513deb20-a5bd-40a7-b97a-c36dc772d512.png" width="22" height="22" title="POO"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/1557-git-github/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-github-0b729570-934d-47d8-ba6b-610d7f15e0ec.png" width="22" height="22" title="Git/GitHub"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2218-pensamiento-logico-2020/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-algoritmos-pensamiento-logico-4b7a05c5-470a-41e6-bcd9-4693f4207a03.png" width="22" height="22" title="Algoritmos"/></a>
    <a href="https://platzi.com/p/theofficesmichell/curso/2292-terminal-21/diploma/detalle/" target="_blank"><img src="https://static.platzi.com/media/achievements/badge-terminal-5c5518b5-43d0-4387-b39e-3d85db446c5f.png" width="22" height="22" title="Terminal"/></a>
  </div>
</li>
</ul>
</li>
</ul>
</td>
<td width="70%" valign="top" style="padding-left: 15px;">
<h3>📝 Resumen Profesional</h3>
<p>Ingeniero de Software con <b>+9 años de experiencia comprobada (Sept 2016)</b> construyendo arquitecturas escalables B2B/B2C, fintechs y productos de alto tráfico para mercados en <b>EE.UU., Chile, Panamá, Colombia y Venezuela</b>. Stack consolidado en <b>TypeScript (Next.js/React y Node.js)</b>, ecosistemas móviles robustos (<i>Flutter, Kotlin, Swift</i>) e infraestructura Cloud (<i>AWS, Docker</i>). Defensor estricto del "Clean Code", principios SOLID, Testing (TDD/E2E) y refactorización orientada a la mantenibilidad extrema.</p>
<hr/>
<h3>💼 Experiencia Destacada (12 Posiciones · +9 Años)</h3>

<ul>
<li>
  <b>2026 → Founder & Senior Software Architect</b> en 🇻🇪 <b>Tuloot</b> <i>(🎮 Gaming / Fintech)</i><br/>
  ▸ Plataforma B2C cross-border de recargas automáticas. <b>+10.000 transacciones</b> autónomas, SLA &lt; 5 min. Stack: Next.js, Node.js, Flutter.
  <br/><br/>
</li>
<li>
  <b>2025 – 2026 · Desarrollador de Productos Senior</b> en 🇺🇸 <b>Immigrant Gateway</b> <i>(🏛️ LegalTech / IA)</i><br/>
  ▸ CRM + ERP a medida para agencia de inmigración (+700 clientes). Multi-agente IA (Gemini) con Human-in-the-loop. OCR legal. <b>400% de optimización operativa.</b>
  <br/><br/>
</li>
<li>
  <b>2024 – 2025 · Senior Software Engineer (Frontend & QA)</b> en 🇨🇴 <b>Nivelics SAS → Seguros Bolívar</b> <i>(🛡️ Insurtech)</i><br/>
  ▸ Resolución masiva de deuda técnica, TDD/E2E completo. <b>100% fiabilidad SonarQube</b> (0 bugs, 0 code smells, 0 vulnerabilidades). Stack: React, Angular.
  <br/><br/>
</li>
<li>
  <b>2024 · Senior JavaScript & AWS Developer</b> en 🇨🇴 <b>Delphi One, Inc.</b> <i>(📊 Fintech / Crypto)</i><br/>
  ▸ Plataforma de valoraciones (Equities & Crypto). Frontend JS + infraestructura AWS con zero-downtime.
  <br/><br/>
</li>
<li>
  <b>2022 – 2023 · Sr. Full Stack Developer · Lead Mobile</b> en 🇨🇱 <b>Okane Capital</b> <i>(🪙 Blockchain / Fintech)</i><br/>
  ▸ Lanzamiento v1 de <b>Skipo App</b> (App Store + Google Play). Algoritmia de alto rendimiento para mercados cripto en tiempo real. Mentoría técnica.
  <br/><br/>
</li>
<li>
  <b>2021 – 2022 · Sr. Full Stack Developer</b> en 🇨🇱 <b>TiTaskLatam / Touch</b> <i>(📡 SaaS B2B / Marketing)</i><br/>
  ▸ Touch App v2 desde cero. APIs NestJS para telemetría de miles de captadores en LATAM.
  <br/><br/>
</li>
<li>
  <b>2021 · SR. Full Stack Developer (Web/Mobile)</b> en 🇨🇴 <b>Blossom (HomeCU)</b> <i>(🏦 US Fintech / BaaS)</i><br/>
  ▸ Website Builder Multi-Tenant para cientos de Credit Unions. Arquitectura SaaS White Label con cumplimiento de seguridad financiera US.
  <br/><br/>
</li>
<li>
  <b>2020 – 2021 · Full Stack Engineer</b> en 🇨🇴 <b>CORNERSTONE Blockchain</b> <i>(⛓️ Blockchain / LegalTech)</i><br/>
  ▸ Automatización notarial con Hyperledger Fabric. Billetera cripto nativa en Flutter con pagos QR.
  <br/><br/>
</li>
<li>
  <b>2019 – 2020 · Mobile Tech Lead (React Native)</b> en 🇵🇦 <b>LIV</b> <i>(📱 Marketplace)</i><br/>
  ▸ Liderazgo del área móvil para plataforma de servicios multi-vertical.
  <br/><br/>
</li>
<li>
  <b>2018 – 2019 · Full Stack Developer</b> en 🇨🇴 <b>integ.ro</b> <i>(💻 Software)</i><br/>
  ▸ Desarrollo Full Stack con JavaScript y bases de datos relacionales.
  <br/><br/>
</li>
<li>
  <b>2017 – 2018 · Desarrollador de Software</b> en 🇨🇴 <b>Genia Tecnologia</b> <i>(📲 Mobile / Web)</i><br/>
  ▸ Desarrollo JS, React.js, React Native y Node.js.
</li>
</ul>

<blockquote>
<b>🧭 Hilo conductor:</b> Trayectoria consistente ascendente desde desarrollador junior hasta Founder & Architect, con especialización profunda en <b>Fintech</b> (5 empresas), ecosistemas <b>móviles nativos</b> (Flutter/React Native) y arquitecturas <b>End-to-End</b> para mercados internacionales (🇺🇸🇨🇱🇵🇦🇨🇴🇻🇪).
</blockquote>

<h3>📈 Open Source & Actividad General GitHub</h3>
<ul>
<li><b>+1,986 contribuciones hiper-activas</b> distribuidas orgánicamente en el último año.</li>
<li>Aporte abierto sobre arquitectura base para proyectos reales mediante la creación de <b>96 Repositorios</b> (incluyendo contribuciones notables como <code>React-Architecture-Template</code>, <code>Wigi-Labs-Flutter-Node-Test</code>, <code>Tyba-Test</code>, <code>proyect_legest</code> y <code>Friender_Advance</code>).</li>
</ul>
</td>
</tr>
</table>
  
---

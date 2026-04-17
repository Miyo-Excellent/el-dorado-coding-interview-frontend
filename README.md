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
│   │       bank_account_model.dart
│   │       currency_model.dart
│   │       offer_maker_stats_model.dart
│   │       offer_model.dart
│   │       payment_method_model.dart
│   │       personal_information_model.dart
│   │       recommendation_response.dart       ← DTO del API de recomendaciones
│   │       score_model.dart
│   │
│   ├── repositories/                          ← Contratos (interfaces abstractas)
│   │       activity_repository.dart
│   │       bank_account_repository.dart
│   │       currency_repository.dart
│   │       payment_method_repository.dart
│   │       profile_repository.dart
│   │       recommendation_repository.dart
│   │       wallet_repository.dart
│   │
│   └── usecases/                              ← Un caso de uso por acción de negocio
│           add_bank_account.dart
│           calculate_conversion.dart          ← Aritmética con Decimal (sin IEEE 754)
│           delete_bank_account.dart
│           get_activity_data.dart
│           get_bank_accounts.dart
│           get_currencies.dart
│           get_payment_methods.dart
│           get_profile.dart
│           get_recommendations.dart           ← Consulta al API público de El Dorado
│           get_wallet_data.dart
│           save_profile.dart
│           set_default_bank_account.dart
│           validate_offer_limits.dart
│
└── infrastructure/                            ⚙️  CAPA DE INFRAESTRUCTURA
    │
    ├── data/
    │   ├── blocs/
    │   │   └── exchange/                      ← BLoC completo (events + states) para el intercambio
    │   │           exchange_bloc.dart
    │   │           exchange_event.dart
    │   │           exchange_state.dart
    │   │
    │   └── cubits/                            ← Estado de UI por dominio funcional
    │       ├── activity/
    │       │       activity_cubit.dart
    │       │       activity_state.dart
    │       ├── bank_account/
    │       │       bank_account_cubit.dart    ← CRUD + estado predeterminado (Hive CE)
    │       ├── currency/
    │       │       currency_cubit.dart
    │       │       currency_state.dart
    │       ├── home/
    │       │       home_cubit.dart
    │       │       home_state.dart
    │       ├── payment_method/
    │       │       payment_method_cubit.dart
    │       │       payment_method_state.dart
    │       ├── profile/
    │       │       profile_cubit.dart
    │       ├── theme/
    │       │       theme_cubit.dart           ← Selector de design system (4 variantes)
    │       ├── traders/
    │       │       traders_cubit.dart
    │       │       traders_state.dart
    │       └── wallet/
    │               wallet_cubit.dart
    │               wallet_state.dart
    │
    ├── network/
    │   │   dio_client.dart                    ← Cliente HTTP base (Dio + interceptores)
    │   └── datasources/
    │           activity_mock_remote_datasource.dart
    │           bank_account_local_datasource.dart
    │           currency_remote_datasource.dart
    │           payment_method_remote_datasource.dart
    │           profile_local_datasource.dart
    │           profile_local_datasource_impl.dart
    │           recommendation_remote_datasource.dart
    │           wallet_mock_remote_datasource.dart
    │
    ├── repositories_impl/                     ← Implementaciones de los contratos del dominio
    │       activity_repository_impl.dart
    │       bank_account_repository_impl.dart
    │       currency_repository_impl.dart
    │       payment_method_repository_impl.dart
    │       profile_repository_impl.dart
    │       recommendation_repository_impl.dart
    │       wallet_repository_impl.dart
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
        │   │   activity_screen.dart
        │   │   home_screen.dart
        │   │   settings_screen.dart
        │   │   wallet_screen.dart
        │   ├── p2p/
        │   │       p2p_offer_list_screen.dart
        │   │       p2p_transaction_screen.dart
        │   ├── settings/
        │   │       bank_accounts_screen.dart
        │   │       personal_info_screen.dart
        │   └── wallet/
        │           wallet_deposit_sheet.dart
        │
        ├── theme/                             ← Sistema de theming doble (4 ThemeData)
        │       app_theme.dart
        │       electric_alchemist_dark.dart
        │       electric_alchemist_factory.dart
        │       electric_alchemist_light.dart
        │       golden_standard_dark.dart
        │       golden_standard_factory.dart
        │       golden_standard_light.dart
        │       registry.dart                  ← Extensión AppThemeVariantX → pair()
        │       theme_factory.dart
        │       tokens.dart                    ← Design tokens semánticos compartidos
        │
        └── widgets/                           ← Atomic Design: 3 niveles de composición
            │   widgets.dart                   ← Barrel export único
            ├── atoms/                         ← Primitivos visuales indivisibles (23 widgets)
            │       ambient_glow_background.dart
            │       amount_column.dart
            │       app_label.dart
            │       balance_display.dart
            │       circle_icon_container.dart
            │       currency_avatar.dart
            │       currency_pill.dart
            │       ghost_border_container.dart
            │       golden_icon_button.dart
            │       keypad_button.dart
            │       online_avatar.dart
            │       payment_method_chip.dart
            │       primary_button.dart
            │       rating_row.dart
            │       setting_item_trailing.dart
            │       status_dot.dart
            │       time_status_row.dart
            │       title_subtitle_column.dart
            │       trend_badge.dart
            │       underline_tab.dart
            │       user_avatar_button.dart
            │       verified_avatar.dart
            │       verified_username.dart
            ├── molecules/                     ← Composiciones de 2+ átomos (20 widgets)
            │       activity_title_meta.dart
            │       app_bar_actions.dart
            │       app_bar_logo.dart
            │       asset_amount_column.dart
            │       currency_row.dart
            │       empty_state_card.dart
            │       error_state_card.dart
            │       filter_pill.dart
            │       filter_pills_bar.dart
            │       metric_item.dart
            │       notification_icon_button.dart
            │       offer_tab_bar.dart
            │       profile_name_column.dart
            │       quick_action_button.dart
            │       section_header.dart
            │       section_title_row.dart
            │       seller_info.dart
            │       setting_item.dart
            │       swap_divider.dart
            │       transaction_row.dart
            └── organisms/                     ← Secciones complejas y auto-suficientes (17 widgets)
                    activity_feed.dart
                    activity_group.dart
                    asset_card.dart
                    asset_list.dart
                    currency_picker_bottom_sheet.dart
                    el_dorado_nav_bar.dart
                    el_dorado_sliver_app_bar.dart
                    exchange_card.dart          ← Calculadora principal de intercambio
                    numeric_keypad.dart
                    offer_card.dart
                    quick_actions_bar.dart
                    recent_activity_list.dart
                    settings_body.dart
                    settings_group.dart
                    theme_picker_bottom_sheet.dart
                    user_profile_section.dart
                    wealth_card.dart            ← Tarjeta de saldo glassmórfica
```

### Gestión de estado

El proyecto combina **BLoC** (para flujos con eventos explícitos) y **Cubit** (para estado más simple), todos registrados globalmente vía `get_it`:

| Clase | Tipo | Responsabilidad |
|---|---|---|
| `ExchangeBloc` | BLoC | Flujo de intercambio con eventos (`AmountChanged`, `CurrencySwapped`…) |
| `ThemeCubit` | Cubit | Variante activa del design system (4 opciones: Golden/Alchemist × Light/Dark) |
| `CurrencyCubit` | Cubit | Carga y caché de pares FIAT/CRYPTO desde el API |
| `PaymentMethodCubit` | Cubit | Métodos de pago disponibles globalmente |
| `HomeCubit` | Cubit | Estado de la pantalla principal |
| `WalletCubit` | Cubit | Activos y saldo del usuario |
| `ActivityCubit` | Cubit | Historial de transacciones agrupado |
| `TradersCubit` | Cubit | Listado de traders P2P |
| `BankAccountCubit` | Cubit | CRUD de cuentas bancarias + cuenta predeterminada (Hive CE) |
| `ProfileCubit` | Cubit | Lectura y escritura del perfil del usuario (Hive CE) |

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

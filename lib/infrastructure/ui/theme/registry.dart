import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/theme/theme_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/theme_factory.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/golden_standard_factory.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/electric_alchemist_factory.dart';

// =============================================================================
// THEME REGISTRY + AppThemeVariant extension
// =============================================================================
//
// This file is the bridge between the state layer (AppThemeVariant in
// theme_cubit.dart) and the theme architecture layer (AppThemeFactory).
//
// Dependency flow (no circular imports):
//   theme_cubit.dart      →  no theme imports              ✅
//   registry.dart         →  theme_cubit + factories       ✅
//   *_factory.dart        →  theme_factory only            ✅
//
// Usage in main.dart / BlocBuilder:
//   import 'registry.dart';
//   final (light, dark) = AppThemeRegistry.pair(variant);
//   // or with the extension:
//   final (light, dark) = variant.pair();
//
// =============================================================================

// -----------------------------------------------------------------------------
// § 1 · REGISTRY — AppThemeVariant → AppThemeFactory
// -----------------------------------------------------------------------------

/// Maps every [AppThemeVariant] to its [AppThemeFactory] (Concrete Factory).
///
/// This is the **single point of registration** for all themes.
/// Adding a new theme requires only:
///   1. Create the Concrete Factory in its own file.
///   2. Add a [case] in [factoryFor].
///   — zero changes to [MaterialApp], [ThemeCubit], or any widget.
abstract final class AppThemeRegistry {
  // Const Concrete Factories — allocated once at compile time.
  static const _gsLight = GoldenStandardLightFactory();
  static const _gsDark  = GoldenStandardDarkFactory();
  static const _eaDark  = ElectricAlchemistDarkFactory();
  static const _eaLight = ElectricAlchemistLightFactory();

  /// Returns the [AppThemeFactory] for [variant].
  static AppThemeFactory factoryFor(AppThemeVariant variant) =>
      switch (variant) {
        AppThemeVariant.goldenLight    => _gsLight,
        AppThemeVariant.goldenDark     => _gsDark,
        AppThemeVariant.alchemistDark  => _eaDark,
        AppThemeVariant.alchemistLight => _eaLight,
      };

  /// Builds the [ThemeData] for [variant] through the Template Method pipeline.
  static ThemeData build(AppThemeVariant variant) =>
      factoryFor(variant).build();

  /// Returns the sibling `(light, dark)` [ThemeData] pair for [MaterialApp].
  ///
  /// Automatically resolves the opposite-brightness variant of the same
  /// design system family (e.g. goldenDark → also builds goldenLight).
  ///
  /// Example:
  /// ```dart
  /// final (light, dark) = AppThemeRegistry.pair(variant);
  /// MaterialApp(theme: light, darkTheme: dark, themeMode: variant.themeMode)
  /// ```
  static (ThemeData light, ThemeData dark) pair(AppThemeVariant variant) {
    final AppThemeVariant lightVariant;
    final AppThemeVariant darkVariant;

    switch (variant) {
      case AppThemeVariant.goldenLight:
      case AppThemeVariant.goldenDark:
        lightVariant = AppThemeVariant.goldenLight;
        darkVariant  = AppThemeVariant.goldenDark;
      case AppThemeVariant.alchemistDark:
      case AppThemeVariant.alchemistLight:
        lightVariant = AppThemeVariant.alchemistLight;
        darkVariant  = AppThemeVariant.alchemistDark;
    }

    return (build(lightVariant), build(darkVariant));
  }
}

// -----------------------------------------------------------------------------
// § 2 · EXTENSION — ergonomic API on AppThemeVariant
// -----------------------------------------------------------------------------
//
// Enriches the [AppThemeVariant] enum (defined in theme_cubit.dart) with
// direct access to the theme architecture without touching theme_cubit.dart.
//
// Before (verbose):
//   AppThemeRegistry.pair(variant)
//   AppThemeRegistry.build(variant)
//
// After (ergonomic):
//   variant.pair()
//   variant.build()
//   variant.factory
//
// Available to any file that imports registry.dart.
// -----------------------------------------------------------------------------

extension AppThemeVariantX on AppThemeVariant {
  /// The [AppThemeFactory] (Concrete Factory) for this variant.
  ///
  /// Useful for inspecting token values or rendering theme previews:
  /// ```dart
  /// final colors = variant.factory.createTokens();
  /// print(colors.primary);
  /// ```
  AppThemeFactory get factory => AppThemeRegistry.factoryFor(this);

  /// Builds the [ThemeData] for this variant via the Template Method pipeline.
  ///
  /// Shorthand for `AppThemeRegistry.build(this)`.
  ThemeData build() => AppThemeRegistry.build(this);

  /// Returns the sibling `(light, dark)` [ThemeData] pair for [MaterialApp].
  ///
  /// Shorthand for `AppThemeRegistry.pair(this)`.
  ///
  /// Example in a [BlocBuilder]:
  /// ```dart
  /// builder: (context, variant) {
  ///   final (light, dark) = variant.pair();
  ///   return MaterialApp(
  ///     theme: light,
  ///     darkTheme: dark,
  ///     themeMode: variant.themeMode,
  ///   );
  /// }
  /// ```
  (ThemeData, ThemeData) pair() => AppThemeRegistry.pair(this);
}

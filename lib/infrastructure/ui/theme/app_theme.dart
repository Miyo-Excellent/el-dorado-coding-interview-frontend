// =============================================================================
// APP THEME — Public API barrel + Theme Registry
// =============================================================================
//
// Single import point for the entire El Dorado theme system.
//
// Architecture: Abstract Factory + Template Method
//   • AppThemeFactory      → Abstract Factory (in theme_factory.dart)
//   • AppColorTokens       → Abstract Product — color palettes
//   • AppTypography        → Abstract Product — font pairings
//   • AppComponentStyles   → Abstract Product — component configurations
//   • AppThemeRegistry     → Static registry: AppThemeVariant → AppThemeFactory
//
// Usage (in main.dart / providers):
//   final themeData = AppThemeRegistry.build(variant);
//
// Available variants (AppThemeVariant from theme_cubit.dart):
//   AppThemeVariant.goldenLight    → builds Golden Standard Light
//   AppThemeVariant.goldenDark     → builds Golden Standard Dark
//   AppThemeVariant.alchemistDark  → builds Electric Alchemist Dark
//   AppThemeVariant.alchemistLight → builds Electric Alchemist Light
//
// Backward-compat (legacy call sites):
//   buildGoldenStandardLight()   → same as AppThemeRegistry.build(goldenLight)
//   buildGoldenStandardDark()    → same as AppThemeRegistry.build(goldenDark)
//   buildElectricAlchemistDark() → same as AppThemeRegistry.build(alchemistDark)
//   buildElectricAlchemistLight()→ same as AppThemeRegistry.build(alchemistLight)
//
// =============================================================================

// ─── Shared primitive tokens (spacing, radii, font names) ────────────────────
export 'tokens.dart';

// ─── Architecture contracts + default components ─────────────────────────────
export 'theme_factory.dart';

// ─── Concrete Factories ───────────────────────────────────────────────────────
export 'golden_standard_factory.dart';
export 'electric_alchemist_factory.dart';

// ─── Registry ─────────────────────────────────────────────────────────────────
// AppThemeRegistry is defined below (not in a separate file) to avoid a
// circular dependency with theme_cubit.dart (which defines AppThemeVariant).
// The registry imports theme_cubit indirectly through the app barrel.

// ─── Legacy files (still exported for backward compatibility) ─────────────────
// These export the original top-level build functions (buildGoldenStandardLight,
// buildElectricAlchemistDark, etc.) so existing call sites in main.dart do not
// break during the migration window.
export 'electric_alchemist_dark.dart';
export 'electric_alchemist_light.dart';
export 'golden_standard_light.dart';
export 'golden_standard_dark.dart';

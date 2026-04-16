import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/storage/hive_storage.dart';

// =============================================================================
// THEME CUBIT
// =============================================================================
//
// Manages the active theme variant across the entire app.
// Persists the selection to Hive local storage.
//
// State: [AppThemeVariant] — one of four supported themes.
//
// Usage:
//   context.read<ThemeCubit>().setVariant(AppThemeVariant.goldenLight)
//   context.watch<ThemeCubit>().state   → AppThemeVariant
// =============================================================================

/// Identifies each selectable theme in the app.
enum AppThemeVariant {
  /// "The Golden Standard" — light mode. New primary theme.
  goldenLight,

  /// "The Golden Standard" — dark mode.
  goldenDark,

  /// "The Electric Alchemist" — dark mode. Original default.
  alchemistDark,

  /// "The Electric Alchemist" — light mode.
  alchemistLight;

  // ── Metadata ───────────────────────────────────────────────────────────────

  /// Human-readable display name for Settings UI.
  String get displayName => switch (this) {
    goldenLight => 'Golden Standard — Claro',
    goldenDark => 'Golden Standard — Oscuro',
    alchemistDark => 'Electric Alchemist — Oscuro',
    alchemistLight => 'Electric Alchemist — Claro',
  };

  /// Short subtitle for the theme picker card.
  String get subtitle => switch (this) {
    goldenLight => 'Cian suave · Oro · Manrope',
    goldenDark => 'Azul noche · Oro · Manrope',
    alchemistDark => 'Negro carbón · Neón · Space Grotesk',
    alchemistLight => 'Crema cálida · Neón · Space Grotesk',
  };

  /// Whether this variant belongs to Brightness.dark.
  bool get isDark =>
      this == AppThemeVariant.goldenDark ||
      this == AppThemeVariant.alchemistDark;

  /// ThemeMode for [MaterialApp].
  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  /// Hive storage key.
  String get storageKey => name;

  /// Palette preview colors [background, primary accent].
  (Color, Color) get previewColors => switch (this) {
    goldenLight => (const Color(0xFFE4F6F8), const Color(0xFFFFB400)),
    goldenDark => (const Color(0xFF0D1F22), const Color(0xFFFFB400)),
    alchemistDark => (const Color(0xFF131313), const Color(0xFFDEED00)),
    alchemistLight => (const Color(0xFFF8F8F2), const Color(0xFFDEED00)),
  };
}

// =============================================================================
// Cubit
// =============================================================================

/// Global cubit that controls which [AppThemeVariant] is active.
class ThemeCubit extends Cubit<AppThemeVariant> {
  ThemeCubit() : super(_initialVariant());

  // ── Initialization ─────────────────────────────────────────────────────────

  static AppThemeVariant _initialVariant() {
    final stored = HiveStorage.themeMode;
    return AppThemeVariant.values.firstWhere(
      (v) => v.storageKey == stored,
      orElse: () => AppThemeVariant.goldenDark, // default to new primary theme
    );
  }

  // ── Commands ───────────────────────────────────────────────────────────────

  /// Switch to a specific [AppThemeVariant] and persist.
  void setVariant(AppThemeVariant variant) {
    emit(variant);
    HiveStorage.setThemeMode(variant.storageKey);
  }

  /// Toggle between dark and light within the same design system family.
  void toggleBrightness() {
    final next = switch (state) {
      AppThemeVariant.goldenLight => AppThemeVariant.goldenDark,
      AppThemeVariant.goldenDark => AppThemeVariant.goldenLight,
      AppThemeVariant.alchemistDark => AppThemeVariant.alchemistLight,
      AppThemeVariant.alchemistLight => AppThemeVariant.alchemistDark,
    };
    setVariant(next);
  }

  // ── Backward-compat shims ──────────────────────────────────────────────────
  // These keep the Settings screen toggle and old call sites working.

  /// @deprecated Use [setVariant] + [AppThemeVariant]. Toggles brightness only.
  void toggleTheme() => toggleBrightness();

  /// @deprecated Use [state.isDark].
  bool get isDark => state.isDark;

  /// @deprecated Use [state.displayName].
  String get label => state.displayName;

  /// @deprecated Use [state.themeMode].
  ThemeMode get themeMode => state.themeMode;

  /// @deprecated Use [setVariant].
  void setTheme(ThemeMode mode) {
    final next = mode == ThemeMode.dark
        ? AppThemeVariant.goldenDark
        : AppThemeVariant.goldenLight;
    setVariant(next);
  }
}

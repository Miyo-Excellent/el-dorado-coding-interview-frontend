import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/theme_factory.dart';

// =============================================================================
// GOLDEN STANDARD — Concrete Factory implementations
// Source of truth: assets/DESIGN_SYSTEM.md
// =============================================================================
//
// Provides two Concrete Factories (light + dark) for "The Golden Standard."
// Both factories share the same Typography product but different Color products.
// Components are shared via GoldenStandardComponents (extends Default).
//
// Design identity:
//   Light: Soft Cyan surface (#E4F6F8) + White cards + El Dorado Gold (#FFB400)
//   Dark:  Midnight Teal surface (#0D1F22) + Gold unchanged
//   Type:  Manrope (headlines) + Inter (body)
// =============================================================================

// =============================================================================
// PRODUCT 1A — Color Tokens (Light)
// =============================================================================

class GoldenStandardLightColors extends AppColorTokens {
  const GoldenStandardLightColors();

  @override Brightness get brightness => Brightness.light;
  @override Color get primary => const Color(0xFFFFB400);
  @override Color get onPrimary => const Color(0xFF191C1D);
  @override Color get primaryContainer => const Color(0xFFFFF0C0);
  @override Color get onPrimaryContainer => const Color(0xFF4A3800);
  @override Color get secondary => const Color(0xFF28A745);
  @override Color get onSecondary => const Color(0xFFFFFFFF);
  @override Color get secondaryContainer => const Color(0xFFD4EDDA);
  @override Color get onSecondaryContainer => const Color(0xFF0D3318);
  @override Color get tertiary => const Color(0xFF00838F);
  @override Color get onTertiary => const Color(0xFFFFFFFF);
  @override Color get tertiaryContainer => const Color(0xFFB2EBF2);
  @override Color get onTertiaryContainer => const Color(0xFF00363B);
  @override Color get error => const Color(0xFFD32F2F);
  @override Color get onError => const Color(0xFFFFFFFF);
  @override Color get errorContainer => const Color(0xFFFFDAD6);
  @override Color get onErrorContainer => const Color(0xFF410002);
  @override Color get surface => const Color(0xFFE4F6F8);
  @override Color get onSurface => const Color(0xFF191C1D);
  @override Color get onSurfaceVariant => const Color(0xFF586060);
  @override Color get surfaceContainerLowest => const Color(0xFFFFFFFF);
  @override Color get surfaceContainerLow => const Color(0xFFF0FAFB);
  @override Color get surfaceContainer => const Color(0xFFF5F5F5);
  @override Color get surfaceContainerHigh => const Color(0xFFE8F4F5);
  @override Color get surfaceContainerHighest => const Color(0xFFDCEEF0);
  @override Color get surfaceBright => const Color(0xFFFFFFFF);
  @override Color get outline => const Color(0xFFB0BEC5);
  @override Color get outlineVariant => const Color(0xFFE0E0E0);
  @override Color get inverseSurface => const Color(0xFF191C1D);
  @override Color get onInverseSurface => const Color(0xFFE4F6F8);
  @override Color get inversePrimary => const Color(0xFFFFB400);

  @override
  Color accentGlow(double opacity) =>
      Color.fromRGBO(0xFF, 0xB4, 0x00, opacity.clamp(0, 1));
}

// =============================================================================
// PRODUCT 1B — Color Tokens (Dark)
// =============================================================================

class GoldenStandardDarkColors extends AppColorTokens {
  const GoldenStandardDarkColors();

  @override Brightness get brightness => Brightness.dark;
  @override Color get primary => const Color(0xFFFFB400);
  @override Color get onPrimary => const Color(0xFF191C1D);
  @override Color get primaryContainer => const Color(0xFF3D2C00);
  @override Color get onPrimaryContainer => const Color(0xFFFFDFA0);
  @override Color get secondary => const Color(0xFF4CAF50);
  @override Color get onSecondary => const Color(0xFF003A05);
  @override Color get secondaryContainer => const Color(0xFF00531A);
  @override Color get onSecondaryContainer => const Color(0xFF86EF8E);
  @override Color get tertiary => const Color(0xFF4DD0E1);
  @override Color get onTertiary => const Color(0xFF00363B);
  @override Color get tertiaryContainer => const Color(0xFF00525A);
  @override Color get onTertiaryContainer => const Color(0xFFB2EBF2);
  @override Color get error => const Color(0xFFFFB4AB);
  @override Color get onError => const Color(0xFF690005);
  @override Color get errorContainer => const Color(0xFF93000A);
  @override Color get onErrorContainer => const Color(0xFFFFDAD6);
  @override Color get surface => const Color(0xFF0D1F22);
  @override Color get onSurface => const Color(0xFFE0F2F4);
  @override Color get onSurfaceVariant => const Color(0xFF7FA9AE);
  @override Color get surfaceContainerLowest => const Color(0xFF08181A);
  @override Color get surfaceContainerLow => const Color(0xFF121E21);
  @override Color get surfaceContainer => const Color(0xFF1A2E33);
  @override Color get surfaceContainerHigh => const Color(0xFF1F3840);
  @override Color get surfaceContainerHighest => const Color(0xFF28464E);
  @override Color get surfaceBright => const Color(0xFF2D5059);
  @override Color get outline => const Color(0xFF3A6066);
  @override Color get outlineVariant => const Color(0xFF254044);
  @override Color get inverseSurface => const Color(0xFFE0F2F4);
  @override Color get onInverseSurface => const Color(0xFF0D1F22);
  @override Color get inversePrimary => const Color(0xFF3D2C00);

  @override
  Color accentGlow(double opacity) =>
      Color.fromRGBO(0xFF, 0xB4, 0x00, opacity.clamp(0, 1));
}

// =============================================================================
// PRODUCT 2 — Typography (shared by light + dark)
// =============================================================================

class GoldenStandardTypography extends AppTypography {
  const GoldenStandardTypography();

  @override String get displayFont => AppFonts.manrope;
  @override String get bodyFont => AppFonts.inter;

  @override
  TextTheme build(AppColorTokens c) {
    final mn = displayFont;
    final it = bodyFont;
    final text = c.onSurface;
    final muted = c.onSurfaceVariant;

    return TextTheme(
      displayLarge:  TextStyle(fontFamily: mn, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.0,  color: text),
      displayMedium: TextStyle(fontFamily: mn, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.2, height: 1.05, color: text),
      displaySmall:  TextStyle(fontFamily: mn, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.8, height: 1.1,  color: text),
      headlineLarge: TextStyle(fontFamily: mn, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: text),
      headlineMedium:TextStyle(fontFamily: mn, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.2,  color: text),
      headlineSmall: TextStyle(fontFamily: mn, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.2, height: 1.25, color: text),
      titleLarge:    TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing:  0,   height: 1.3,  color: text),
      titleMedium:   TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3,  color: text),
      titleSmall:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,  height: 1.4,  color: text),
      bodyLarge:     TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5,  color: text),
      bodyMedium:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5,  color: text),
      bodySmall:     TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,  height: 1.5,  color: muted),
      labelLarge:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,  height: 1.4,  color: text),
      labelMedium:   TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0,  height: 1.4,  color: text),
      labelSmall:    TextStyle(fontFamily: it, fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5,  height: 1.4,  color: muted),
    );
  }
}

// =============================================================================
// PRODUCT 3 — Component Styles
// =============================================================================
// Extends DefaultComponentStyles and overrides only what differs from the
// shared defaults (Manrope headings, gold borders, outlined inputs, xl radius).

class GoldenStandardComponents extends DefaultComponentStyles {
  const GoldenStandardComponents();

  @override
  AppBarTheme appBarTheme(AppColorTokens c, AppTypography t) => AppBarTheme(
        backgroundColor: c.surfaceContainerLowest,
        foregroundColor: c.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: c.shadow(0.06),
        systemOverlayStyle: (c.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark)
            .copyWith(statusBarColor: Colors.transparent),
        titleTextStyle: TextStyle(
          fontFamily: t.displayFont,   // Manrope — editorial authority
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
          color: c.onSurface,
        ),
        iconTheme: IconThemeData(color: c.onSurface, size: 24),
        actionsIconTheme: IconThemeData(color: c.onSurface, size: 24),
      );

  @override
  ElevatedButtonThemeData elevatedButtonTheme(
          AppColorTokens c, AppTypography t) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return c.primary.withValues(alpha: 0.38);
            }
            return c.primary;
          }),
          foregroundColor: WidgetStateProperty.all(c.onPrimary),
          overlayColor:
              WidgetStateProperty.all(c.onPrimary.withValues(alpha: 0.1)),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          textStyle: WidgetStateProperty.all(TextStyle(
              fontFamily: t.bodyFont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
          // xl radius — "Golden Standard" button shape
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl))),
          animationDuration: const Duration(milliseconds: 200),
        ),
      );

  @override
  OutlinedButtonThemeData outlinedButtonTheme(
          AppColorTokens c, AppTypography t) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(c.onSurface),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused) ||
                states.contains(WidgetState.pressed)) {
              return BorderSide(color: c.primary, width: 1.5);
            }
            return BorderSide(color: c.outline, width: 1);
          }),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          textStyle: WidgetStateProperty.all(TextStyle(
              fontFamily: t.bodyFont,
              fontSize: 15,
              fontWeight: FontWeight.w600)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl))),
        ),
      );

  /// GS inputs: white bg + gray border → gold on focus (design system rule).
  @override
  InputDecorationTheme inputDecorationTheme(
          AppColorTokens c, AppTypography t) =>
      InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: c.outline, width: 1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: c.outline, width: 1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: c.primary, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: c.error, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: c.error, width: 2),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        labelStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 14, color: c.onSurfaceVariant),
        floatingLabelStyle: TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: c.primary),
        hintStyle: TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 14,
            color: c.onSurfaceVariant.withValues(alpha: 0.5)),
        helperStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 10, color: c.onSurfaceVariant),
        errorStyle:
            TextStyle(fontFamily: t.bodyFont, fontSize: 10, color: c.error),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      );

  @override
  FloatingActionButtonThemeData fabTheme(AppColorTokens c) =>
      FloatingActionButtonThemeData(
        backgroundColor: c.primary,
        foregroundColor: c.onPrimary,
        elevation: 2,
        highlightElevation: 4,
        shape: const CircleBorder(),
      );

  @override
  DialogThemeData dialogTheme(AppColorTokens c, AppTypography t) =>
      DialogThemeData(
        backgroundColor: c.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl)),
        titleTextStyle: TextStyle(
            fontFamily: t.displayFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
            color: c.onSurface),
        contentTextStyle:
            TextStyle(fontFamily: t.bodyFont, fontSize: 14, color: c.onSurface),
      );

  @override
  ListTileThemeData listTileTheme(AppColorTokens c, AppTypography t) =>
      ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: c.primaryContainer,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md)),
        titleTextStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 16, color: c.onSurface),
        subtitleTextStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 12, color: c.onSurfaceVariant),
        iconColor: c.primary,
        textColor: c.onSurface,
        horizontalTitleGap: AppSpacing.lg,
        minVerticalPadding: AppSpacing.md,
      );

  @override
  SnackBarThemeData snackBarTheme(AppColorTokens c, AppTypography t) =>
      SnackBarThemeData(
        backgroundColor: c.onSurface,
        contentTextStyle:
            TextStyle(fontFamily: t.bodyFont, fontSize: 14, color: c.surface),
        actionTextColor: c.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md)),
        elevation: 0,
      );
}

// =============================================================================
// CONCRETE FACTORIES
// =============================================================================

/// Concrete Factory — "The Golden Standard" Light Mode.
class GoldenStandardLightFactory extends AppThemeFactory {
  const GoldenStandardLightFactory();

  static const _colors = GoldenStandardLightColors();
  static const _typography = GoldenStandardTypography();
  static const _components = GoldenStandardComponents();

  @override AppColorTokens createTokens() => _colors;
  @override AppTypography createTypography() => _typography;
  @override AppComponentStyles createComponents() => _components;
}

/// Concrete Factory — "The Golden Standard" Dark Mode.
class GoldenStandardDarkFactory extends AppThemeFactory {
  const GoldenStandardDarkFactory();

  static const _colors = GoldenStandardDarkColors();
  static const _typography = GoldenStandardTypography();
  static const _components = GoldenStandardComponents();

  @override AppColorTokens createTokens() => _colors;
  @override AppTypography createTypography() => _typography;
  @override AppComponentStyles createComponents() => _components;
}

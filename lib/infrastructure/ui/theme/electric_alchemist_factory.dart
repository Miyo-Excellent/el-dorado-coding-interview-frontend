import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/theme_factory.dart';

// =============================================================================
// ELECTRIC ALCHEMIST — Concrete Factory implementations
// Source of truth: assets/DESIGN_SYSTEM_CUSTOM.md
// =============================================================================
//
// Provides two Concrete Factories (dark + light) for "The Electric Alchemist."
// Design identity:
//   Dark:  #131313 surface + #DEED00 neon accent. Space Grotesk. "Lookbook."
//   Light: #F8F8F2 warm cream + #DEED00 neon. Same Space Grotesk aesthetic.
//   Type:  Space Grotesk (headlines) + Inter (body)
// =============================================================================

// =============================================================================
// PRODUCT 1A — Color Tokens (Dark)
// =============================================================================

class ElectricAlchemistDarkColors extends AppColorTokens {
  const ElectricAlchemistDarkColors();

  @override Brightness get brightness => Brightness.dark;
  @override Color get primary => const Color(0xFFFFFFFF);
  @override Color get onPrimary => const Color(0xFF2F3300);
  @override Color get primaryContainer => const Color(0xFFDEED00);
  @override Color get onPrimaryContainer => const Color(0xFF626900);
  @override Color get secondary => const Color(0xFFC6C6C7);
  @override Color get onSecondary => const Color(0xFF2F3131);
  @override Color get secondaryContainer => const Color(0xFF454747);
  @override Color get onSecondaryContainer => const Color(0xFFB4B5B5);
  @override Color get tertiary => const Color(0xFFEFFF00);
  @override Color get onTertiary => const Color(0xFF2F3300);
  @override Color get tertiaryContainer => const Color(0xFFDEED00);
  @override Color get onTertiaryContainer => const Color(0xFF626900);
  @override Color get error => const Color(0xFFFFB4AB);
  @override Color get onError => const Color(0xFF690005);
  @override Color get errorContainer => const Color(0xFF93000A);
  @override Color get onErrorContainer => const Color(0xFFFFDAD6);
  @override Color get surface => const Color(0xFF131313);
  @override Color get onSurface => const Color(0xFFE2E2E2);
  @override Color get onSurfaceVariant => const Color(0xFFC8C8AB);
  @override Color get surfaceContainerLowest => const Color(0xFF0E0E0E);
  @override Color get surfaceContainerLow => const Color(0xFF1B1B1B);
  @override Color get surfaceContainer => const Color(0xFF1F1F1F);
  @override Color get surfaceContainerHigh => const Color(0xFF2A2A2A);
  @override Color get surfaceContainerHighest => const Color(0xFF353535);
  @override Color get surfaceBright => const Color(0xFF393939);
  @override Color get outline => const Color(0xFF929277);
  @override Color get outlineVariant => const Color(0xFF474832);
  @override Color get inverseSurface => const Color(0xFFE2E2E2);
  @override Color get onInverseSurface => const Color(0xFF303030);
  @override Color get inversePrimary => const Color(0xFF5C6300);

  @override
  Color accentGlow(double opacity) =>
      Color.fromRGBO(0xDE, 0xED, 0x00, opacity.clamp(0, 1));
}

// =============================================================================
// PRODUCT 1B — Color Tokens (Light)
// =============================================================================

class ElectricAlchemistLightColors extends AppColorTokens {
  const ElectricAlchemistLightColors();

  @override Brightness get brightness => Brightness.light;
  @override Color get primary => const Color(0xFF1A1A1A);
  @override Color get onPrimary => const Color(0xFFFFFFFF);
  @override Color get primaryContainer => const Color(0xFFDEED00);
  @override Color get onPrimaryContainer => const Color(0xFF2F3300);
  @override Color get secondary => const Color(0xFF5A5A5A);
  @override Color get onSecondary => const Color(0xFFFFFFFF);
  @override Color get secondaryContainer => const Color(0xFFE8E8E8);
  @override Color get onSecondaryContainer => const Color(0xFF3A3A3A);
  @override Color get tertiary => const Color(0xFFC3D000);
  @override Color get onTertiary => const Color(0xFF2F3300);
  @override Color get tertiaryContainer => const Color(0xFFEFFF00);
  @override Color get onTertiaryContainer => const Color(0xFF626900);
  @override Color get error => const Color(0xFFBA1A1A);
  @override Color get onError => const Color(0xFFFFFFFF);
  @override Color get errorContainer => const Color(0xFFFFDAD6);
  @override Color get onErrorContainer => const Color(0xFF410002);
  @override Color get surface => const Color(0xFFF8F8F2);
  @override Color get onSurface => const Color(0xFF1A1A1A);
  @override Color get onSurfaceVariant => const Color(0xFF5A5A48);
  @override Color get surfaceContainerLowest => const Color(0xFFFFFFFF);
  @override Color get surfaceContainerLow => const Color(0xFFF2F2EA);
  @override Color get surfaceContainer => const Color(0xFFECECE3);
  @override Color get surfaceContainerHigh => const Color(0xFFE3E3DA);
  @override Color get surfaceContainerHighest => const Color(0xFFDADAD0);
  @override Color get surfaceBright => const Color(0xFFF8F8F2);
  @override Color get outline => const Color(0xFF929277);
  @override Color get outlineVariant => const Color(0xFFD0D0B8);
  @override Color get inverseSurface => const Color(0xFF303030);
  @override Color get onInverseSurface => const Color(0xFFF2F2EA);
  @override Color get inversePrimary => const Color(0xFFDEED00);

  @override
  Color accentGlow(double opacity) =>
      Color.fromRGBO(0xDE, 0xED, 0x00, opacity.clamp(0, 1));
}

// =============================================================================
// PRODUCT 2 — Typography (shared by dark + light)
// =============================================================================

class ElectricAlchemistTypography extends AppTypography {
  const ElectricAlchemistTypography();

  @override String get displayFont => AppFonts.spaceGrotesk;
  @override String get bodyFont => AppFonts.inter;

  @override
  TextTheme build(AppColorTokens c) {
    final sg = displayFont;
    final it = bodyFont;
    final text = c.onSurface;
    final muted = c.onSurfaceVariant;

    return TextTheme(
      // Display: massive, tight, bold — Space Grotesk "loud" voice
      displayLarge:  TextStyle(fontFamily: sg, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -2.0, height: 1.0,  color: c.primary),
      displayMedium: TextStyle(fontFamily: sg, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.05, color: c.primary),
      displaySmall:  TextStyle(fontFamily: sg, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.0, height: 1.1,  color: c.primary),
      headlineLarge: TextStyle(fontFamily: sg, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: c.primary),
      headlineMedium:TextStyle(fontFamily: sg, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.2,  color: c.primary),
      headlineSmall: TextStyle(fontFamily: sg, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.25, color: c.primary),
      // Title: Inter for functional clarity
      titleLarge:    TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing:  0,   height: 1.3,  color: c.primary),
      titleMedium:   TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3,  color: c.primary),
      titleSmall:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,  height: 1.4,  color: c.primary),
      // Body: Inter "functional" voice
      bodyLarge:     TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5,  color: text),
      bodyMedium:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5,  color: text),
      bodySmall:     TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,  height: 1.5,  color: muted),
      // Labels: Space Grotesk for editorial capsule feel
      labelLarge:    TextStyle(fontFamily: sg, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,  height: 1.4,  color: text),
      labelMedium:   TextStyle(fontFamily: sg, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0,  height: 1.4,  color: text),
      labelSmall:    TextStyle(fontFamily: sg, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5,  height: 1.4,  color: muted),
    );
  }
}

// =============================================================================
// PRODUCT 3 — Component Styles
// =============================================================================
// The Electric Alchemist has a distinctive component personality:
//   • AppBar title in primaryContainer (neon yellow) — the EA "logo" effect
//   • "No-Line" rule: inputs use NO border, only filled surfaceContainerHighest
//   • Ghost border on focus: primaryContainer at 40% opacity
//   • md button radius (not xl like GS)
//   • Glassmorphism nav: transparent bg

class ElectricAlchemistComponents extends DefaultComponentStyles {
  const ElectricAlchemistComponents();

  @override
  AppBarTheme appBarTheme(AppColorTokens c, AppTypography t) => AppBarTheme(
        backgroundColor: c.surface,
        foregroundColor: c.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: (c.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark)
            .copyWith(statusBarColor: Colors.transparent),
        // Title in primaryContainer (neon yellow) — EA signature
        titleTextStyle: TextStyle(
          fontFamily: t.displayFont,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: c.primaryContainer,
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
              return c.primaryContainer.withValues(alpha: 0.38);
            }
            return c.primaryContainer;
          }),
          foregroundColor: WidgetStateProperty.all(c.onPrimaryContainer),
          overlayColor: WidgetStateProperty.all(
              c.onPrimaryContainer.withValues(alpha: 0.08)),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          textStyle: WidgetStateProperty.all(TextStyle(
              fontFamily: t.displayFont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
          // md radius — "Electric Alchemist" tighter feel
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md))),
          animationDuration: const Duration(milliseconds: 200),
        ),
      );

  @override
  OutlinedButtonThemeData outlinedButtonTheme(
          AppColorTokens c, AppTypography t) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(c.surfaceContainerHigh),
          foregroundColor: WidgetStateProperty.all(c.onSurface),
          // No Line rule: no border
          side: WidgetStateProperty.all(BorderSide.none),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          textStyle: WidgetStateProperty.all(TextStyle(
              fontFamily: t.bodyFont,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md))),
        ),
      );

  /// EA inputs: "No-Line" rule — no border. Ghost border on focus.
  @override
  InputDecorationTheme inputDecorationTheme(
          AppColorTokens c, AppTypography t) =>
      InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceContainerHighest,
        // No enabled border (No-Line rule)
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.md)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.md)),
        // Ghost border on focus (primaryContainer at 40%)
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: c.primaryContainer.withValues(alpha: 0.4), width: 2),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: c.error.withValues(alpha: 0.4), width: 2),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: c.error, width: 2),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        // Space Grotesk for helper text (EA editorial label)
        helperStyle: TextStyle(
            fontFamily: t.displayFont,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: c.onSurfaceVariant),
        hintStyle: TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 14,
            color: c.onSurfaceVariant.withValues(alpha: 0.6)),
        labelStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 14, color: c.onSurfaceVariant),
        floatingLabelStyle: TextStyle(
            fontFamily: t.displayFont,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: c.primaryContainer),
        errorStyle:
            TextStyle(fontFamily: t.bodyFont, fontSize: 10, color: c.error),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      );

  @override
  FloatingActionButtonThemeData fabTheme(AppColorTokens c) =>
      FloatingActionButtonThemeData(
        backgroundColor: c.primaryContainer,
        foregroundColor: c.onPrimaryContainer,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
      );

  @override
  DialogThemeData dialogTheme(AppColorTokens c, AppTypography t) =>
      DialogThemeData(
        backgroundColor: c.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl)),
        titleTextStyle: TextStyle(
            fontFamily: t.displayFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: c.onSurface),
        contentTextStyle:
            TextStyle(fontFamily: t.bodyFont, fontSize: 14, color: c.onSurface),
      );
}

// =============================================================================
// CONCRETE FACTORIES
// =============================================================================

/// Concrete Factory — "The Electric Alchemist" Dark Mode.
class ElectricAlchemistDarkFactory extends AppThemeFactory {
  const ElectricAlchemistDarkFactory();

  static const _colors = ElectricAlchemistDarkColors();
  static const _typography = ElectricAlchemistTypography();
  static const _components = ElectricAlchemistComponents();

  @override AppColorTokens createTokens() => _colors;
  @override AppTypography createTypography() => _typography;
  @override AppComponentStyles createComponents() => _components;
}

/// Concrete Factory — "The Electric Alchemist" Light Mode.
class ElectricAlchemistLightFactory extends AppThemeFactory {
  const ElectricAlchemistLightFactory();

  static const _colors = ElectricAlchemistLightColors();
  static const _typography = ElectricAlchemistTypography();
  static const _components = ElectricAlchemistComponents();

  @override AppColorTokens createTokens() => _colors;
  @override AppTypography createTypography() => _typography;
  @override AppComponentStyles createComponents() => _components;
}

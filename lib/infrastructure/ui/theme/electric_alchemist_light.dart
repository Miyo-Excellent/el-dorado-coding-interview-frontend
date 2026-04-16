import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';

// =============================================================================
// ELECTRIC ALCHEMIST — Light Theme  (optional: day mode for the Alchemist)
// Source of truth: assets/DESIGN_SYSTEM_CUSTOM.md
// =============================================================================
//
// Inverts the surface/primary relationship while keeping the golden identity.
// "Golden atmosphere" maintained via warm-tinted neutrals (not pure greys).
// =============================================================================

// -----------------------------------------------------------------------------
// § 1 · COLOR TOKENS
// -----------------------------------------------------------------------------

/// Light color palette for "The Electric Alchemist".
abstract final class AppColorsLight {
  static const Color primary = Color(0xFF1A1A1A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFDEED00);
  static const Color onPrimaryContainer = Color(0xFF2F3300);
  static const Color primaryFixedDim = Color(0xFFC3D000);

  static const Color secondary = Color(0xFF5A5A5A);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8E8E8);
  static const Color onSecondaryContainer = Color(0xFF3A3A3A);

  static const Color tertiary = Color(0xFFC3D000);
  static const Color onTertiary = Color(0xFF2F3300);
  static const Color tertiaryContainer = Color(0xFFEFFF00);
  static const Color onTertiaryContainer = Color(0xFF626900);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // Surface tiers — warm-tinted, never pure grey
  static const Color surface = Color(0xFFF8F8F2);
  static const Color onSurface = Color(0xFF1A1A1A);
  static const Color onSurfaceVariant = Color(0xFF5A5A48);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F2EA);
  static const Color surfaceContainer = Color(0xFFECECE3);
  static const Color surfaceContainerHigh = Color(0xFFE3E3DA);
  static const Color surfaceContainerHighest = Color(0xFFDADAD0);
  static const Color surfaceBright = Color(0xFFF8F8F2);

  static const Color outline = Color(0xFF929277);
  static const Color outlineVariant = Color(0xFFD0D0B8);

  static const Color inverseSurface = Color(0xFF303030);
  static const Color onInverseSurface = Color(0xFFF2F2EA);
  static const Color inversePrimary = Color(0xFFDEED00);
}

// -----------------------------------------------------------------------------
// § 2 · COLOR SCHEME
// -----------------------------------------------------------------------------

const ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColorsLight.primary,
  onPrimary: AppColorsLight.onPrimary,
  primaryContainer: AppColorsLight.primaryContainer,
  onPrimaryContainer: AppColorsLight.onPrimaryContainer,
  secondary: AppColorsLight.secondary,
  onSecondary: AppColorsLight.onSecondary,
  secondaryContainer: AppColorsLight.secondaryContainer,
  onSecondaryContainer: AppColorsLight.onSecondaryContainer,
  tertiary: AppColorsLight.tertiary,
  onTertiary: AppColorsLight.onTertiary,
  tertiaryContainer: AppColorsLight.tertiaryContainer,
  onTertiaryContainer: AppColorsLight.onTertiaryContainer,
  error: AppColorsLight.error,
  onError: AppColorsLight.onError,
  errorContainer: AppColorsLight.errorContainer,
  onErrorContainer: AppColorsLight.onErrorContainer,
  surface: AppColorsLight.surface,
  onSurface: AppColorsLight.onSurface,
  onSurfaceVariant: AppColorsLight.onSurfaceVariant,
  outline: AppColorsLight.outline,
  outlineVariant: AppColorsLight.outlineVariant,
  inverseSurface: AppColorsLight.inverseSurface,
  onInverseSurface: AppColorsLight.onInverseSurface,
  inversePrimary: AppColorsLight.inversePrimary,
);

// -----------------------------------------------------------------------------
// § 3 · TEXT THEME
// -----------------------------------------------------------------------------

TextTheme _buildLightTextTheme() {
  final sg = AppFonts.spaceGrotesk;
  final it = AppFonts.inter;

  return TextTheme(
    displayLarge:  TextStyle(fontFamily: sg, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -2.0, height: 1.0,  color: AppColorsLight.primary),
    displayMedium: TextStyle(fontFamily: sg, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.05, color: AppColorsLight.primary),
    displaySmall:  TextStyle(fontFamily: sg, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.0, height: 1.1,  color: AppColorsLight.primary),
    headlineLarge: TextStyle(fontFamily: sg, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: AppColorsLight.primary),
    headlineMedium:TextStyle(fontFamily: sg, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.2,  color: AppColorsLight.primary),
    headlineSmall: TextStyle(fontFamily: sg, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.25, color: AppColorsLight.primary),
    titleLarge:    TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing:  0,   height: 1.3,  color: AppColorsLight.primary),
    titleMedium:   TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3,  color: AppColorsLight.primary),
    titleSmall:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,  height: 1.4,  color: AppColorsLight.primary),
    bodyLarge:     TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5,  color: AppColorsLight.onSurface),
    bodyMedium:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5,  color: AppColorsLight.onSurface),
    bodySmall:     TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,  height: 1.5,  color: AppColorsLight.onSurfaceVariant),
    labelLarge:    TextStyle(fontFamily: sg, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,  height: 1.4,  color: AppColorsLight.onSurface),
    labelMedium:   TextStyle(fontFamily: sg, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0,  height: 1.4,  color: AppColorsLight.onSurface),
    labelSmall:    TextStyle(fontFamily: sg, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5,  height: 1.4,  color: AppColorsLight.onSurfaceVariant),
  );
}

// -----------------------------------------------------------------------------
// § 4 · PUBLIC API
// -----------------------------------------------------------------------------

/// Builds "The Electric Alchemist" light [ThemeData].
ThemeData buildElectricAlchemistLight() {
  final tt = _buildLightTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: AppColorsLight.surface,
    canvasColor: AppColorsLight.surface,
    cardColor: AppColorsLight.surfaceContainerLow,
    shadowColor: AppColorsLight.primary.withValues(alpha: 0.1),
    fontFamily: AppFonts.inter,
    textTheme: tt,
    primaryTextTheme: tt,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsLight.surface,
      foregroundColor: AppColorsLight.primary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.spaceGrotesk,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColorsLight.primaryContainer,
      ),
      iconTheme: const IconThemeData(color: AppColorsLight.primary, size: 24),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      indicatorColor: AppColorsLight.primaryContainer,
      indicatorShape: const StadiumBorder(),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColorsLight.onPrimaryContainer, size: 24);
        }
        return IconThemeData(color: AppColorsLight.primary.withValues(alpha: 0.4), size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 10,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: 1.2,
          color: active ? AppColorsLight.onPrimaryContainer : AppColorsLight.primary.withValues(alpha: 0.4),
        );
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 64,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return AppColorsLight.primaryContainer.withValues(alpha: 0.38);
          return AppColorsLight.primaryContainer;
        }),
        foregroundColor: WidgetStateProperty.all(AppColorsLight.onPrimaryContainer),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.1)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md))),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsLight.surfaceContainerHighest,
      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(AppRadius.md)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(AppRadius.md)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsLight.primaryContainer.withValues(alpha: 0.6), width: 2),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColorsLight.surfaceContainerLow,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorsLight.surfaceContainer,
      selectedColor: AppColorsLight.primaryContainer,
      labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: AppColorsLight.onSurface),
      shape: const StadiumBorder(side: BorderSide.none),
      elevation: 0,
    ),
    dividerTheme: const DividerThemeData(color: Colors.transparent, thickness: 0, space: 0),
    dividerColor: Colors.transparent,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColorsLight.primaryContainer,
      linearTrackColor: AppColorsLight.surfaceContainerHigh,
      circularTrackColor: AppColorsLight.surfaceContainerHigh,
    ),
    iconTheme: const IconThemeData(color: AppColorsLight.primary, size: 24),
    primaryIconTheme: const IconThemeData(color: AppColorsLight.primary, size: 24),
    splashColor: AppColorsLight.primary.withValues(alpha: 0.04),
    highlightColor: AppColorsLight.primary.withValues(alpha: 0.02),
    hoverColor: AppColorsLight.surfaceContainerHigh,
    focusColor: AppColorsLight.primaryContainer.withValues(alpha: 0.12),
  );
}

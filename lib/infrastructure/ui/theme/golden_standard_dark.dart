import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';

// =============================================================================
// GOLDEN STANDARD — Dark Theme
// Source of truth: assets/DESIGN_SYSTEM.md (dark variant)
// =============================================================================
//
// Inverts the Golden Standard's surface strategy:
//   surface     → Deep midnight teal (#0D1F22) — calming dark canvas
//   container   → Rich dark charcoal (#1A2E33) — card backgrounds
//   primary     → El Dorado Gold (#FFB400) — unchanged, maximum impact
//
// Typography unchanged: Manrope headlines + Inter body.
// "The gold now glows against the darkness — premium night mode."
// =============================================================================

// -----------------------------------------------------------------------------
// § 1 · COLOR TOKENS
// -----------------------------------------------------------------------------

/// Dark color palette for "The Golden Standard — Dark Mode."
abstract final class GsDarkColors {
  // ─── Primary — El Dorado Gold (unchanged across modes) ────────────────────
  /// #FFB400 — Core actions, CTAs, active borders.
  static const Color primary = Color(0xFFFFB400);
  /// #191C1D — Charcoal for text on gold.
  static const Color onPrimary = Color(0xFF191C1D);
  /// #FFB400 — Deep amber container on dark.
  static const Color primaryContainer = Color(0xFFFFB400);
  /// #191C1D — Warm text on dark gold container.
  static const Color onPrimaryContainer = Color(0xFF191C1D);

  // ─── Secondary — Trust Green (dark variant) ────────────────────────────────
  static const Color secondary = Color(0xFFE0F7FA);
  static const Color onSecondary = Color(0xFF191C1D);
  static const Color secondaryContainer = Color(0xFF00531A);
  static const Color onSecondaryContainer = Color(0xFF86EF8E);

  // ─── Tertiary — Cyber Teal (dark variant) ─────────────────────────────────
  static const Color tertiary = Color(0xFF28A745);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF00525A);
  static const Color onTertiaryContainer = Color(0xFFB2EBF2);

  // ─── Error ────────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // ─── Surface tiers — Deep Midnight Teal base ──────────────────────────────
  /// #0D1F22 — Midnight teal canvas.
  static const Color surface = Color(0xFF191C1D);
  /// #E0F7FA — Light text on dark surface.
  static const Color onSurface = Color(0xFFE0F7FA);
  /// Muted light text for variants.
  static const Color onSurfaceVariant = Color(0xFFB0C4C7);
  /// #08181A — The deepest recesses.
  static const Color surfaceContainerLowest = Color(0xFF08181A);
  /// #121E21 — Section backgrounds.
  static const Color surfaceContainerLow = Color(0xFF121E21);
  /// #1A2E33 — Card backgrounds (replace white cards from light mode).
  static const Color surfaceContainer = Color(0xFF1A2E33);
  /// #1F3840 — Elevated interactive elements.
  static const Color surfaceContainerHigh = Color(0xFF1F3840);
  /// #28464E — Highest elevation cards.
  static const Color surfaceContainerHighest = Color(0xFF28464E);
  /// #2D5059 — Glassmorphism nav surface.
  static const Color surfaceBright = Color(0xFF2D5059);

  // ─── Outline ──────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFF3A6066);
  static const Color outlineVariant = Color(0xFF254044);

  // ─── Inverse ──────────────────────────────────────────────────────────────
  static const Color inverseSurface = Color(0xFFE0F7FA);
  static const Color onInverseSurface = Color(0xFF191C1D);
  static const Color inversePrimary = Color(0xFF3D2C00);

  static Color shadow(double opacity) =>
      Color.fromRGBO(0, 0, 0, opacity.clamp(0.0, 1.0));
  static Color goldenGlow(double opacity) =>
      Color.fromRGBO(0xFF, 0xB4, 0x00, opacity.clamp(0.0, 1.0));
}

// -----------------------------------------------------------------------------
// § 2 · COLOR SCHEME
// -----------------------------------------------------------------------------

const ColorScheme _gsDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: GsDarkColors.primary,
  onPrimary: GsDarkColors.onPrimary,
  primaryContainer: GsDarkColors.primaryContainer,
  onPrimaryContainer: GsDarkColors.onPrimaryContainer,
  secondary: GsDarkColors.secondary,
  onSecondary: GsDarkColors.onSecondary,
  secondaryContainer: GsDarkColors.secondaryContainer,
  onSecondaryContainer: GsDarkColors.onSecondaryContainer,
  tertiary: GsDarkColors.tertiary,
  onTertiary: GsDarkColors.onTertiary,
  tertiaryContainer: GsDarkColors.tertiaryContainer,
  onTertiaryContainer: GsDarkColors.onTertiaryContainer,
  error: GsDarkColors.error,
  onError: GsDarkColors.onError,
  errorContainer: GsDarkColors.errorContainer,
  onErrorContainer: GsDarkColors.onErrorContainer,
  surface: GsDarkColors.surface,
  onSurface: GsDarkColors.onSurface,
  onSurfaceVariant: GsDarkColors.onSurfaceVariant,
  outline: GsDarkColors.outline,
  outlineVariant: GsDarkColors.outlineVariant,
  inverseSurface: GsDarkColors.inverseSurface,
  onInverseSurface: GsDarkColors.onInverseSurface,
  inversePrimary: GsDarkColors.inversePrimary,
);

// -----------------------------------------------------------------------------
// § 3 · TEXT THEME (Manrope + Inter — same as light)
// -----------------------------------------------------------------------------

TextTheme _buildGsDarkTextTheme() {
  final mn = AppFonts.manrope;
  final it = AppFonts.inter;

  return TextTheme(
    displayLarge:  TextStyle(fontFamily: mn, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.0,  color: GsDarkColors.onSurface),
    displayMedium: TextStyle(fontFamily: mn, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.2, height: 1.05, color: GsDarkColors.onSurface),
    displaySmall:  TextStyle(fontFamily: mn, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.8, height: 1.1,  color: GsDarkColors.onSurface),
    headlineLarge: TextStyle(fontFamily: mn, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: GsDarkColors.onSurface),
    headlineMedium:TextStyle(fontFamily: mn, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.2,  color: GsDarkColors.onSurface),
    headlineSmall: TextStyle(fontFamily: mn, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.2, height: 1.25, color: GsDarkColors.onSurface),
    titleLarge:    TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing:  0,   height: 1.3,  color: GsDarkColors.onSurface),
    titleMedium:   TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3,  color: GsDarkColors.onSurface),
    titleSmall:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,  height: 1.4,  color: GsDarkColors.onSurface),
    bodyLarge:     TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5,  color: GsDarkColors.onSurface),
    bodyMedium:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5,  color: GsDarkColors.onSurface),
    bodySmall:     TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,  height: 1.5,  color: GsDarkColors.onSurfaceVariant),
    labelLarge:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,  height: 1.4,  color: GsDarkColors.onSurface),
    labelMedium:   TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0,  height: 1.4,  color: GsDarkColors.onSurface),
    labelSmall:    TextStyle(fontFamily: it, fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5,  height: 1.4,  color: GsDarkColors.onSurfaceVariant),
  );
}

// -----------------------------------------------------------------------------
// § 4 · PUBLIC API
// -----------------------------------------------------------------------------

/// Builds "The Golden Standard — Dark Mode" [ThemeData].
ThemeData buildGoldenStandardDark() {
  final tt = _buildGsDarkTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: _gsDarkColorScheme,
    scaffoldBackgroundColor: GsDarkColors.surface,
    canvasColor: GsDarkColors.surface,
    cardColor: GsDarkColors.surfaceContainer,
    shadowColor: GsDarkColors.shadow(0.4),
    fontFamily: AppFonts.inter,
    textTheme: tt,
    primaryTextTheme: tt,

    appBarTheme: AppBarTheme(
      backgroundColor: GsDarkColors.surfaceContainerLow,
      foregroundColor: GsDarkColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: GsDarkColors.onSurface,
      ),
      iconTheme: const IconThemeData(color: GsDarkColors.onSurface, size: 24),
      actionsIconTheme: const IconThemeData(color: GsDarkColors.onSurface, size: 24),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: GsDarkColors.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      indicatorColor: GsDarkColors.primary,
      indicatorShape: const StadiumBorder(),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: GsDarkColors.onPrimary, size: 24);
        }
        return const IconThemeData(color: GsDarkColors.onSurfaceVariant, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 10,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: 0.8,
          color: active ? GsDarkColors.primary : GsDarkColors.onSurfaceVariant,
        );
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 64,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return GsDarkColors.primary.withValues(alpha: 0.38);
          return GsDarkColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(GsDarkColors.onPrimary),
        overlayColor: WidgetStateProperty.all(GsDarkColors.onPrimary.withValues(alpha: 0.1)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl))),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(GsDarkColors.onSurface),
        side: WidgetStateProperty.all(const BorderSide(color: GsDarkColors.outline, width: 1)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 15, fontWeight: FontWeight.w600)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl))),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(GsDarkColors.primary),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: GsDarkColors.surfaceContainer,
      border: OutlineInputBorder(borderSide: const BorderSide(color: GsDarkColors.outline, width: 1), borderRadius: BorderRadius.circular(AppRadius.md)),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: GsDarkColors.outline, width: 1), borderRadius: BorderRadius.circular(AppRadius.md)),
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: GsDarkColors.primary, width: 1.5), borderRadius: BorderRadius.circular(AppRadius.md)),
      errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: GsDarkColors.error, width: 1.5), borderRadius: BorderRadius.circular(AppRadius.md)),
      labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsDarkColors.onSurfaceVariant),
      floatingLabelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w600, color: GsDarkColors.primary),
      hintStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsDarkColors.onSurfaceVariant.withValues(alpha: 0.5)),
      helperStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, color: GsDarkColors.onSurfaceVariant),
      errorStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, color: GsDarkColors.error),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
    ),

    cardTheme: CardThemeData(
      color: GsDarkColors.surfaceContainer,
      elevation: 0,
      shadowColor: GsDarkColors.shadow(0.3),
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      clipBehavior: Clip.antiAlias,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: GsDarkColors.surfaceContainerHigh,
      selectedColor: GsDarkColors.primary,
      labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w500, color: GsDarkColors.onSurface),
      secondaryLabelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w500, color: GsDarkColors.onPrimary),
      shape: const StadiumBorder(side: BorderSide.none),
      elevation: 0,
    ),

    dividerTheme: const DividerThemeData(color: Colors.transparent, thickness: 0, space: 0),
    dividerColor: Colors.transparent,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: GsDarkColors.primary,
      foregroundColor: GsDarkColors.onPrimary,
      elevation: 2,
      highlightElevation: 4,
      shape: const CircleBorder(),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return GsDarkColors.onPrimary;
        return GsDarkColors.onSurfaceVariant;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return GsDarkColors.primary;
        return GsDarkColors.surfaceContainerHigh;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: GsDarkColors.primaryContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      titleTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 16, color: GsDarkColors.onSurface),
      subtitleTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, color: GsDarkColors.onSurfaceVariant),
      iconColor: GsDarkColors.primary,
      textColor: GsDarkColors.onSurface,
      horizontalTitleGap: AppSpacing.lg,
      minVerticalPadding: AppSpacing.md,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: GsDarkColors.surfaceContainerLow,
      modalBackgroundColor: GsDarkColors.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xl),
          topRight: Radius.circular(AppRadius.xl),
        ),
      ),
      dragHandleColor: GsDarkColors.outline,
      dragHandleSize: const Size(32, 4),
      showDragHandle: true,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: GsDarkColors.surfaceContainerHighest,
      contentTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsDarkColors.onSurface),
      actionTextColor: GsDarkColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: GsDarkColors.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
      titleTextStyle: TextStyle(fontFamily: AppFonts.manrope, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.2, color: GsDarkColors.onSurface),
      contentTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsDarkColors.onSurface),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: GsDarkColors.primary,
      linearTrackColor: GsDarkColors.surfaceContainerHigh,
      circularTrackColor: GsDarkColors.surfaceContainerHigh,
    ),

    badgeTheme: BadgeThemeData(
      backgroundColor: GsDarkColors.primary,
      textColor: GsDarkColors.onPrimary,
      textStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, fontWeight: FontWeight.w700),
    ),

    iconTheme: const IconThemeData(color: GsDarkColors.onSurface, size: 24),
    primaryIconTheme: const IconThemeData(color: GsDarkColors.primary, size: 24),

    splashColor: GsDarkColors.primary.withValues(alpha: 0.08),
    highlightColor: GsDarkColors.primary.withValues(alpha: 0.04),
    hoverColor: GsDarkColors.surfaceContainerHigh,
    focusColor: GsDarkColors.primary.withValues(alpha: 0.10),
  );
}

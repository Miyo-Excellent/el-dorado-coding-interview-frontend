import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';

// =============================================================================
// GOLDEN STANDARD — Light Theme  (NEW primary theme)
// Source of truth: assets/DESIGN_SYSTEM.md
// =============================================================================
//
// "Soft Minimalism" + energetic El Dorado Gold accents.
// Palette: El Dorado Gold (#FFB400), Soft Cyan (#E0F7FA), Atmospheric Grays.
// Typography: Manrope (editorial headlines) + Inter (functional data).
//
// Surface hierarchy:
//   surface     → Soft Cyan base (#E4F6F8)
//   container   → White cards (#FFFFFF) — the visual focal point
//   secondary   → Light gray utility areas (#F5F5F5)
// =============================================================================

// -----------------------------------------------------------------------------
// § 1 · COLOR TOKENS
// -----------------------------------------------------------------------------

/// Light color palette for "The Golden Standard."
abstract final class GsColors {
  // ─── Primary role — El Dorado Gold ────────────────────────────────────────
  /// #FFB400 — Core actions, CTA buttons, active borders.
  static const Color primary = Color(0xFFFFB400);
  /// #191C1D — Dark charcoal for text on gold backgrounds.
  static const Color onPrimary = Color(0xFF191C1D);
  /// #FFB400 — Used across main app bars and navigational containers to pop.
  static const Color primaryContainer = Color(0xFFFFB400);
  /// #191C1D — Dark gray text over Gold containers.
  static const Color onPrimaryContainer = Color(0xFF191C1D);

  // ─── Secondary role — Trust Green ─────────────────────────────────────────
  /// #28A745 — Verification badges, positive trends, success states.
  static const Color secondary = Color(0xFFE0F7FA);
  static const Color onSecondary = Color(0xFF191C1D);
  static const Color secondaryContainer = Color(0xFFD4EDDA);
  static const Color onSecondaryContainer = Color(0xFF0D3318);

  // ─── Tertiary role — Cyber Teal ───────────────────────────────────────────
  /// #00838F — Accent for crypto indicators, links.
  static const Color tertiary = Color(0xFF28A745);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFB2EBF2);
  static const Color onTertiaryContainer = Color(0xFF00363B);

  // ─── Error ────────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFD32F2F);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // ─── Surface tiers — Soft Cyan base ───────────────────────────────────────
  /// #E4F6F8 — The Soft Cyan base canvas.
  static const Color surface = Color(0xFFE0F7FA);
  /// #191C1D — Charcoal (not pure black) for readable body text.
  static const Color onSurface = Color(0xFF191C1D);
  /// #586060 — Muted text on surface.
  static const Color onSurfaceVariant = Color(0xFF586060);
  /// #FFFFFF — White cards — primary focal point.
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  /// #F0FAFB — Very light teal for secondary backgrounds.
  static const Color surfaceContainerLow = Color(0xFFF0FAFB);
  /// #F5F5F5 — Utility section backgrounds.
  static const Color surfaceContainer = Color(0xFFF5F5F5);
  /// #E8F4F5 — Elevated interactive elements.
  static const Color surfaceContainerHigh = Color(0xFFE8F4F5);
  /// #DCEEF0 — Highest elevation cards.
  static const Color surfaceContainerHighest = Color(0xFFDCEEF0);
  /// #FFFFFF — Glassmorphism surface (same as lowest for light theme).
  static const Color surfaceBright = Color(0xFFFFFFFF);

  // ─── Outline ──────────────────────────────────────────────────────────────
  /// #B0BEC5 — Subtle borders (used sparingly).
  static const Color outline = Color(0xFFB0BEC5);
  /// #E0E0E0 — Ghost dividers — never at 100% opacity.
  static const Color outlineVariant = Color(0xFFE0E0E0);

  // ─── Inverse ──────────────────────────────────────────────────────────────
  static const Color inverseSurface = Color(0xFF191C1D);
  static const Color onInverseSurface = Color(0xFFE0F7FA);
  static const Color inversePrimary = Color(0xFFFFB400);

  // ─── Shadows ──────────────────────────────────────────────────────────────
  /// Ambient shadow: 8-10% opacity, 30-50px blur.
  static Color shadow(double opacity) =>
      Color.fromRGBO(0, 0, 0, opacity.clamp(0.0, 1.0));
  static Color goldenGlow(double opacity) =>
      Color.fromRGBO(0xFF, 0xB4, 0x00, opacity.clamp(0.0, 1.0));
}

// -----------------------------------------------------------------------------
// § 2 · SHADOWS & DECORATIONS
// -----------------------------------------------------------------------------

abstract final class GsShadows {
  /// Soft ambient shadow for white cards on cyan background (8% opacity).
  static List<BoxShadow> get card => [
        BoxShadow(
          color: GsColors.shadow(0.08),
          blurRadius: 32,
          offset: const Offset(0, 4),
        ),
      ];

  /// Stronger float — calculator card, modals (10% opacity).
  static List<BoxShadow> get float => [
        BoxShadow(
          color: GsColors.shadow(0.10),
          blurRadius: 48,
          offset: const Offset(0, 8),
        ),
      ];

  /// Golden swap-button glow.
  static List<BoxShadow> goldenGlow({double opacity = 0.25}) => [
        BoxShadow(
          color: GsColors.goldenGlow(opacity),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> get navBar => [
        BoxShadow(
          color: GsColors.shadow(0.08),
          blurRadius: 24,
          offset: const Offset(0, -4),
        ),
      ];
}

abstract final class GsDecorations {
  /// White card on Soft Cyan — "pop" focal point.
  static BoxDecoration card({double radius = AppRadius.md}) => BoxDecoration(
        color: GsColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: GsShadows.card,
      );

  /// Golden-bordered input focus state.
  static BoxDecoration inputFocused({double radius = AppRadius.md}) =>
      BoxDecoration(
        color: GsColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: GsColors.primary, width: 1.5),
      );

  /// Wealth Card — golden gradient on white card.
  static BoxDecoration wealthCardOf(BuildContext context) => BoxDecoration(
        color: GsColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: GsShadows.float,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GsColors.primaryContainer.withValues(alpha: 0.5),
            GsColors.surfaceContainerLowest,
          ],
          stops: const [0.0, 0.6],
        ),
      );
}

// -----------------------------------------------------------------------------
// § 3 · COLOR SCHEME
// -----------------------------------------------------------------------------

const ColorScheme _gsLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: GsColors.primary,
  onPrimary: GsColors.onPrimary,
  primaryContainer: GsColors.primaryContainer,
  onPrimaryContainer: GsColors.onPrimaryContainer,
  secondary: GsColors.secondary,
  onSecondary: GsColors.onSecondary,
  secondaryContainer: GsColors.secondaryContainer,
  onSecondaryContainer: GsColors.onSecondaryContainer,
  tertiary: GsColors.tertiary,
  onTertiary: GsColors.onTertiary,
  tertiaryContainer: GsColors.tertiaryContainer,
  onTertiaryContainer: GsColors.onTertiaryContainer,
  error: GsColors.error,
  onError: GsColors.onError,
  errorContainer: GsColors.errorContainer,
  onErrorContainer: GsColors.onErrorContainer,
  surface: GsColors.surface,
  onSurface: GsColors.onSurface,
  onSurfaceVariant: GsColors.onSurfaceVariant,
  outline: GsColors.outline,
  outlineVariant: GsColors.outlineVariant,
  inverseSurface: GsColors.inverseSurface,
  onInverseSurface: GsColors.onInverseSurface,
  inversePrimary: GsColors.inversePrimary,
);

// -----------------------------------------------------------------------------
// § 4 · TEXT THEME
// -----------------------------------------------------------------------------

/// Manrope (headlines) + Inter (body) — "Golden Standard" editorial pairing.
TextTheme _buildGsLightTextTheme() {
  final mn = AppFonts.manrope;
  final it = AppFonts.inter;

  return TextTheme(
    displayLarge:  TextStyle(fontFamily: mn, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.0,  color: GsColors.onSurface),
    displayMedium: TextStyle(fontFamily: mn, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.2, height: 1.05, color: GsColors.onSurface),
    displaySmall:  TextStyle(fontFamily: mn, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.8, height: 1.1,  color: GsColors.onSurface),
    headlineLarge: TextStyle(fontFamily: mn, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: GsColors.onSurface),
    headlineMedium:TextStyle(fontFamily: mn, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.2,  color: GsColors.onSurface),
    headlineSmall: TextStyle(fontFamily: mn, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.2, height: 1.25, color: GsColors.onSurface),
    titleLarge:    TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing:  0,   height: 1.3,  color: GsColors.onSurface),
    titleMedium:   TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3,  color: GsColors.onSurface),
    titleSmall:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1,  height: 1.4,  color: GsColors.onSurface),
    bodyLarge:     TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5,  color: GsColors.onSurface),
    bodyMedium:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5,  color: GsColors.onSurface),
    bodySmall:     TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,  height: 1.5,  color: GsColors.onSurfaceVariant),
    labelLarge:    TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5,  height: 1.4,  color: GsColors.onSurface),
    labelMedium:   TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0,  height: 1.4,  color: GsColors.onSurface),
    labelSmall:    TextStyle(fontFamily: it, fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5,  height: 1.4,  color: GsColors.onSurfaceVariant),
  );
}

// -----------------------------------------------------------------------------
// § 5 · PUBLIC API
// -----------------------------------------------------------------------------

/// Builds "The Golden Standard" light [ThemeData].
ThemeData buildGoldenStandardLight() {
  final tt = _buildGsLightTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: _gsLightColorScheme,
    scaffoldBackgroundColor: GsColors.surface,
    canvasColor: GsColors.surface,
    cardColor: GsColors.surfaceContainerLowest,
    shadowColor: GsColors.shadow(0.08),
    fontFamily: AppFonts.inter,
    textTheme: tt,
    primaryTextTheme: tt,

    appBarTheme: AppBarTheme(
      backgroundColor: GsColors.surfaceContainerLowest,
      foregroundColor: GsColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      shadowColor: GsColors.shadow(0.06),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: GsColors.onSurface,
      ),
      iconTheme: const IconThemeData(color: GsColors.onSurface, size: 24),
      actionsIconTheme: const IconThemeData(color: GsColors.onSurface, size: 24),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: GsColors.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: GsColors.shadow(0.08),
      indicatorColor: GsColors.primary,
      indicatorShape: const StadiumBorder(),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: GsColors.onPrimary, size: 24);
        }
        return const IconThemeData(color: GsColors.onSurfaceVariant, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 10,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: 0.8,
          color: active ? GsColors.primary : GsColors.onSurfaceVariant,
        );
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 64,
    ),

    // Primary button — El Dorado Gold fill
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return GsColors.primary.withValues(alpha: 0.38);
          return GsColors.primary;
        }),
        foregroundColor: WidgetStateProperty.all(GsColors.onPrimary),
        overlayColor: WidgetStateProperty.all(GsColors.onPrimary.withValues(alpha: 0.1)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl))),
        animationDuration: const Duration(milliseconds: 200),
      ),
    ),

    // Secondary button — transparent with charcoal text
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(GsColors.onSurface),
        side: WidgetStateProperty.all(const BorderSide(color: GsColors.outline, width: 1)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 15, fontWeight: FontWeight.w600)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl))),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(GsColors.primary),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    ),

    // Input fields — white bg, gray border → gold on focus
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: GsColors.surfaceContainerLowest,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: GsColors.outline, width: 1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: GsColors.outline, width: 1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: GsColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: GsColors.error, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: GsColors.error, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsColors.onSurfaceVariant),
      floatingLabelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w600, color: GsColors.primary),
      hintStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsColors.onSurfaceVariant.withValues(alpha: 0.5)),
      helperStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, color: GsColors.onSurfaceVariant),
      errorStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, color: GsColors.error),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
    ),

    cardTheme: CardThemeData(
      color: GsColors.surfaceContainerLowest,
      elevation: 0,
      shadowColor: GsColors.shadow(0.08),
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      clipBehavior: Clip.antiAlias,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: GsColors.surfaceContainerLow,
      selectedColor: GsColors.primary,
      disabledColor: GsColors.surfaceContainer,
      deleteIconColor: GsColors.onSurfaceVariant,
      labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w500, color: GsColors.onSurface),
      secondaryLabelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w500, color: GsColors.onPrimary),
      shape: const StadiumBorder(side: BorderSide.none),
      elevation: 0,
    ),

    dividerTheme: const DividerThemeData(color: Colors.transparent, thickness: 0, space: 0),
    dividerColor: Colors.transparent,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: GsColors.primary,
      foregroundColor: GsColors.onPrimary,
      elevation: 2,
      highlightElevation: 4,
      shape: const CircleBorder(),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return GsColors.onPrimary;
        return GsColors.onSurfaceVariant;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return GsColors.primary;
        return GsColors.surfaceContainerHigh;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: GsColors.primaryContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      titleTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 16, fontWeight: FontWeight.w400, color: GsColors.onSurface),
      subtitleTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w400, color: GsColors.onSurfaceVariant),
      iconColor: GsColors.primary,
      textColor: GsColors.onSurface,
      horizontalTitleGap: AppSpacing.lg,
      minVerticalPadding: AppSpacing.md,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: GsColors.surfaceContainerLowest,
      modalBackgroundColor: GsColors.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalElevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xl),
          topRight: Radius.circular(AppRadius.xl),
        ),
      ),
      dragHandleColor: GsColors.outline,
      dragHandleSize: const Size(32, 4),
      showDragHandle: true,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: GsColors.onSurface,
      contentTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsColors.surface),
      actionTextColor: GsColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      elevation: 0,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: GsColors.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
      titleTextStyle: TextStyle(fontFamily: AppFonts.manrope, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.2, color: GsColors.onSurface),
      contentTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, color: GsColors.onSurface),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: GsColors.primary,
      linearTrackColor: GsColors.surfaceContainerHigh,
      circularTrackColor: GsColors.surfaceContainerHigh,
    ),

    badgeTheme: BadgeThemeData(
      backgroundColor: GsColors.primary,
      textColor: GsColors.onPrimary,
      textStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, fontWeight: FontWeight.w700),
    ),

    iconTheme: const IconThemeData(color: GsColors.onSurface, size: 24),
    primaryIconTheme: const IconThemeData(color: GsColors.primary, size: 24),

    splashColor: GsColors.primary.withValues(alpha: 0.08),
    highlightColor: GsColors.primary.withValues(alpha: 0.04),
    hoverColor: GsColors.surfaceContainerHigh,
    focusColor: GsColors.primary.withValues(alpha: 0.10),
  );
}

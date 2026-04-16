import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';

// =============================================================================
// ELECTRIC ALCHEMIST — Dark Theme  (current default)
// Source of truth: assets/DESIGN_SYSTEM_CUSTOM.md
// =============================================================================
//
// Core tension: #131313 (Surface) vs #EFFF00 (Vibrant Energy).
// "Every screen should feel like a page from a high-end fashion lookbook."
// =============================================================================

// -----------------------------------------------------------------------------
// § 1 · COLOR TOKENS
// -----------------------------------------------------------------------------

/// Full dark color palette for "The Electric Alchemist."
abstract final class AppColors {
  // ─── Primary role ─────────────────────────────────────────────────────────
  /// #FFFFFF — Maximum readability against dark backgrounds.
  static const Color primary = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFF2F3300);
  /// #DEED00 — The "Golden" signature. CTAs, status indicators.
  static const Color primaryContainer = Color(0xFFDEED00);
  /// Vibrant variant used for glows/bleeds (#EFFF00).
  static const Color primaryContainerVibrant = Color(0xFFEFFF00);
  static const Color onPrimaryContainer = Color(0xFF626900);
  static const Color primaryFixedDim = Color(0xFFC3D000);

  // ─── Secondary role ───────────────────────────────────────────────────────
  static const Color secondary = Color(0xFFC6C6C7);
  static const Color onSecondary = Color(0xFF2F3131);
  static const Color secondaryContainer = Color(0xFF454747);
  static const Color onSecondaryContainer = Color(0xFFB4B5B5);

  // ─── Tertiary role ────────────────────────────────────────────────────────
  static const Color tertiary = Color(0xFFEFFF00);
  static const Color onTertiary = Color(0xFF2F3300);
  static const Color tertiaryContainer = Color(0xFFDEED00);
  static const Color onTertiaryContainer = Color(0xFF626900);

  // ─── Error ────────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // ─── Surface tiers ────────────────────────────────────────────────────────
  /// #131313 — The base canvas.
  static const Color surface = Color(0xFF131313);
  static const Color onSurface = Color(0xFFE2E2E2);
  /// Warm-tinted muted text, not pure grey.
  static const Color onSurfaceVariant = Color(0xFFC8C8AB);
  static const Color surfaceContainerLowest = Color(0xFF0E0E0E);
  static const Color surfaceContainerLow = Color(0xFF1B1B1B);
  static const Color surfaceContainer = Color(0xFF1F1F1F);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighest = Color(0xFF353535);
  /// At 60% opacity for glassmorphism nav.
  static const Color surfaceBright = Color(0xFF393939);

  // ─── Outline ──────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFF929277);
  /// Ghost border — never use at 100% opacity.
  static const Color outlineVariant = Color(0xFF474832);

  // ─── Inverse ──────────────────────────────────────────────────────────────
  static const Color inverseSurface = Color(0xFFE2E2E2);
  static const Color onInverseSurface = Color(0xFF303030);
  static const Color inversePrimary = Color(0xFF5C6300);

  // ─── Semantic helpers ─────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;
  static Color shadow(double opacity) =>
      Color.fromRGBO(0, 0, 0, opacity.clamp(0.0, 1.0));
  static Color goldenGlow(double opacity) =>
      Color.fromRGBO(0xDE, 0xED, 0x00, opacity.clamp(0.0, 1.0));
}

// -----------------------------------------------------------------------------
// § 2 · SHADOWS & DECORATIONS
// -----------------------------------------------------------------------------

/// Pre-built [BoxShadow] lists — atmospheric, never standard grey.
abstract final class AppShadows {
  static List<BoxShadow> get low => [
        BoxShadow(
          color: AppColors.shadow(0.15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
  static List<BoxShadow> get medium => [
        BoxShadow(
          color: AppColors.shadow(0.4),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];
  static List<BoxShadow> get high => [
        BoxShadow(
          color: AppColors.shadow(0.4),
          blurRadius: 40,
          offset: const Offset(0, 20),
        ),
      ];
  static List<BoxShadow> goldenGlow({double opacity = 0.20}) => [
        BoxShadow(
          color: AppColors.goldenGlow(opacity),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ];
  static List<BoxShadow> get navBar => [
        BoxShadow(
          color: AppColors.shadow(0.6),
          blurRadius: 40,
          offset: const Offset(0, -10),
        ),
      ];
}

/// Reusable [BoxDecoration] presets for The Electric Alchemist.
abstract final class AppDecorations {
  /// Radial golden glow texture for Hero section backgrounds.
  static const BoxDecoration heroGlow = BoxDecoration(
    gradient: RadialGradient(
      center: Alignment.topLeft,
      radius: 1.2,
      colors: [
        Color(0x0CDEED00), // #deed00 at ~5%
        Colors.transparent,
      ],
      stops: [0.0, 0.4],
    ),
  );

  /// Glassmorphism — for floating nav / bottom-sheets.
  static BoxDecoration glassmorphism({BorderRadius? borderRadius}) =>
      BoxDecoration(
        color: AppColors.surfaceBright.withValues(alpha: 0.6),
        borderRadius: borderRadius ??
            const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.xl),
              topRight: Radius.circular(AppRadius.xl),
            ),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: AppShadows.navBar,
      );

  /// Standard interactive card — surfaceContainerLow background.
  static BoxDecoration card({double radius = AppRadius.md, bool elevated = false}) =>
      BoxDecoration(
        color: elevated ? AppColors.surfaceContainerHigh : AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: elevated ? AppShadows.low : null,
      );

  /// Wealth Card — glassmorphic balance card with golden gradient.
  static BoxDecoration wealthCardOf(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;
    return BoxDecoration(
      color: cs.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      boxShadow: AppShadows.high,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          isDark
              ? const Color(0xFF1A1A00)
              : cs.primaryContainer.withValues(alpha: 0.15),
          cs.surfaceContainerLowest,
        ],
        stops: const [0.0, 0.6],
      ),
    );
  }

  /// Legacy accessor (dark theme only). Prefer [wealthCardOf].
  static BoxDecoration wealthCard = BoxDecoration(
    color: AppColors.surfaceContainerLowest,
    borderRadius: BorderRadius.circular(AppRadius.xl),
    boxShadow: AppShadows.high,
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1A1A00), AppColors.surfaceContainerLowest],
      stops: [0.0, 0.6],
    ),
  );
}

// -----------------------------------------------------------------------------
// § 3 · COLOR SCHEME
// -----------------------------------------------------------------------------

const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.secondaryContainer,
  onSecondaryContainer: AppColors.onSecondaryContainer,
  tertiary: AppColors.tertiary,
  onTertiary: AppColors.onTertiary,
  tertiaryContainer: AppColors.tertiaryContainer,
  onTertiaryContainer: AppColors.onTertiaryContainer,
  error: AppColors.error,
  onError: AppColors.onError,
  errorContainer: AppColors.errorContainer,
  onErrorContainer: AppColors.onErrorContainer,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
  inverseSurface: AppColors.inverseSurface,
  onInverseSurface: AppColors.onInverseSurface,
  inversePrimary: AppColors.inversePrimary,
);

// -----------------------------------------------------------------------------
// § 4 · TEXT THEME
// -----------------------------------------------------------------------------

TextTheme _buildDarkTextTheme() {
  final sg = AppFonts.spaceGrotesk;
  final it = AppFonts.inter;

  return TextTheme(
    displayLarge: TextStyle(fontFamily: sg, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -2.0, height: 1.0, color: AppColors.primary),
    displayMedium: TextStyle(fontFamily: sg, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.05, color: AppColors.primary),
    displaySmall: TextStyle(fontFamily: sg, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.0, height: 1.1, color: AppColors.primary),
    headlineLarge: TextStyle(fontFamily: sg, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: AppColors.primary),
    headlineMedium: TextStyle(fontFamily: sg, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.2, color: AppColors.primary),
    headlineSmall: TextStyle(fontFamily: sg, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.25, color: AppColors.primary),
    titleLarge: TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.3, color: AppColors.primary),
    titleMedium: TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3, color: AppColors.primary),
    titleSmall: TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1, height: 1.4, color: AppColors.primary),
    bodyLarge: TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5, color: AppColors.onSurface),
    bodyMedium: TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5, color: AppColors.onSurface),
    bodySmall: TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.5, color: AppColors.onSurfaceVariant),
    labelLarge: TextStyle(fontFamily: sg, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1.4, color: AppColors.onSurface),
    labelMedium: TextStyle(fontFamily: sg, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0, height: 1.4, color: AppColors.onSurface),
    labelSmall: TextStyle(fontFamily: sg, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5, height: 1.4, color: AppColors.onSurfaceVariant),
  );
}

// -----------------------------------------------------------------------------
// § 5 · COMPONENT STYLES
// -----------------------------------------------------------------------------

AppBarTheme _appBarTheme() => AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.primary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.spaceGrotesk,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.primaryContainer,
      ),
      iconTheme: const IconThemeData(color: AppColors.primary, size: 24),
      actionsIconTheme: const IconThemeData(color: AppColors.primary, size: 24),
    );

NavigationBarThemeData _navigationBarTheme() => NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      indicatorColor: AppColors.primaryContainer,
      indicatorShape: const StadiumBorder(),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.onPrimary, size: 24);
        }
        return IconThemeData(color: AppColors.primary.withValues(alpha: 0.4), size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 10,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: 1.2,
          color: active ? AppColors.onPrimary : AppColors.primary.withValues(alpha: 0.4),
        );
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      height: 64,
    );

ElevatedButtonThemeData _primaryButtonTheme(TextTheme tt) => ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.primaryContainer.withValues(alpha: 0.38);
          }
          return AppColors.primaryContainer;
        }),
        foregroundColor: WidgetStateProperty.all(AppColors.onPrimary),
        overlayColor: WidgetStateProperty.all(AppColors.onPrimary.withValues(alpha: 0.08)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.1)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md))),
        animationDuration: const Duration(milliseconds: 200),
      ),
    );

OutlinedButtonThemeData _secondaryButtonTheme() => OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.surfaceContainerHigh),
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        overlayColor: WidgetStateProperty.all(AppColors.primary.withValues(alpha: 0.08)),
        side: WidgetStateProperty.all(BorderSide.none),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.1)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md))),
      ),
    );

TextButtonThemeData _tertiaryButtonTheme() => TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return AppColors.primary.withValues(alpha: 0.6);
          return AppColors.primary;
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm)),
      ),
    );

InputDecorationTheme _inputDecorationTheme(TextTheme tt) {
  final ghostBorder = AppColors.primaryContainer.withValues(alpha: 0.4);
  return InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceContainerHighest,
    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(AppRadius.md)),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(AppRadius.md)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ghostBorder, width: 2), borderRadius: BorderRadius.circular(AppRadius.md)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.error.withValues(alpha: 0.4), width: 2), borderRadius: BorderRadius.circular(AppRadius.md)),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.error, width: 2), borderRadius: BorderRadius.circular(AppRadius.md)),
    helperStyle: TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5, color: AppColors.onSurfaceVariant),
    hintStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant.withValues(alpha: 0.6)),
    labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant),
    floatingLabelStyle: TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryContainer),
    errorStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, color: AppColors.error),
    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
  );
}

ChipThemeData _chipTheme() => ChipThemeData(
      backgroundColor: AppColors.surfaceContainer,
      selectedColor: AppColors.primaryContainer,
      disabledColor: AppColors.surfaceContainerLow,
      deleteIconColor: AppColors.onSurfaceVariant,
      labelStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: AppColors.onSurface),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      shape: const StadiumBorder(side: BorderSide.none),
      elevation: 0,
      pressElevation: 0,
      shadowColor: Colors.transparent,
    );

ListTileThemeData _listTileTheme(TextTheme tt) => ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: AppColors.surfaceContainerHigh,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      titleTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primary),
      subtitleTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant),
      leadingAndTrailingTextStyle: TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant),
      iconColor: AppColors.primaryContainer,
      textColor: AppColors.primary,
      horizontalTitleGap: AppSpacing.lg,
      minVerticalPadding: AppSpacing.md,
    );

BottomSheetThemeData _bottomSheetTheme() => BottomSheetThemeData(
      backgroundColor: AppColors.surfaceContainerLow,
      modalBackgroundColor: AppColors.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalElevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xl),
          topRight: Radius.circular(AppRadius.xl),
        ),
      ),
      dragHandleColor: AppColors.outlineVariant,
      dragHandleSize: const Size(32, 4),
      showDragHandle: true,
    );

SnackBarThemeData _snackBarTheme(TextTheme tt) => SnackBarThemeData(
      backgroundColor: AppColors.surfaceContainerHighest,
      contentTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.onSurface),
      actionTextColor: AppColors.primaryContainer,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      elevation: 0,
    );

DialogThemeData _dialogTheme() => DialogThemeData(
      backgroundColor: AppColors.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
      titleTextStyle: TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.3, color: AppColors.primary),
      contentTextStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.onSurface),
    );

// -----------------------------------------------------------------------------
// § 6 · PUBLIC API
// -----------------------------------------------------------------------------

/// Builds "The Electric Alchemist" dark [ThemeData].
ThemeData buildElectricAlchemistDark() {
  final tt = _buildDarkTextTheme();
  return ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: AppColors.surface,
    canvasColor: AppColors.surface,
    cardColor: AppColors.surfaceContainerLow,
    shadowColor: AppColors.shadow(0.4),
    fontFamily: AppFonts.inter,
    textTheme: tt,
    primaryTextTheme: tt,
    appBarTheme: _appBarTheme(),
    navigationBarTheme: _navigationBarTheme(),
    elevatedButtonTheme: _primaryButtonTheme(tt),
    outlinedButtonTheme: _secondaryButtonTheme(),
    textButtonTheme: _tertiaryButtonTheme(),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryContainer),
        foregroundColor: WidgetStateProperty.all(AppColors.onPrimary),
        overlayColor: WidgetStateProperty.all(AppColors.onPrimary.withValues(alpha: 0.08)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md))),
      ),
    ),
    inputDecorationTheme: _inputDecorationTheme(tt),
    cardTheme: CardThemeData(
      color: AppColors.surfaceContainerLow,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      clipBehavior: Clip.antiAlias,
    ),
    chipTheme: _chipTheme(),
    dividerTheme: const DividerThemeData(color: Colors.transparent, thickness: 0, space: 0),
    dividerColor: Colors.transparent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryContainer,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
      highlightElevation: 0,
      shape: const CircleBorder(),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.onPrimary;
        return AppColors.onSurfaceVariant;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primaryContainer;
        return AppColors.surfaceContainerHigh;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    listTileTheme: _listTileTheme(tt),
    bottomSheetTheme: _bottomSheetTheme(),
    snackBarTheme: _snackBarTheme(tt),
    dialogTheme: _dialogTheme(),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryContainer,
      linearTrackColor: AppColors.surfaceContainerHigh,
      circularTrackColor: AppColors.surfaceContainerHigh,
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.primaryContainer,
      textColor: AppColors.onPrimary,
      textStyle: TextStyle(fontFamily: AppFonts.inter, fontSize: 10, fontWeight: FontWeight.w700),
    ),
    iconTheme: const IconThemeData(color: AppColors.primary, size: 24),
    primaryIconTheme: const IconThemeData(color: AppColors.primary, size: 24),
    splashColor: AppColors.primary.withValues(alpha: 0.04),
    highlightColor: AppColors.primary.withValues(alpha: 0.02),
    hoverColor: AppColors.surfaceContainerHigh,
    focusColor: AppColors.primaryContainer.withValues(alpha: 0.12),
  );
}

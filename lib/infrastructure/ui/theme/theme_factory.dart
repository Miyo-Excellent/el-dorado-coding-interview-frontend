import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';

// =============================================================================
// THEME ARCHITECTURE — Abstract Factory + Template Method
// =============================================================================
//
// Pattern rationale (Refactoring Guru):
//
//  ┌─ ABSTRACT FACTORY ─────────────────────────────────────────────────────┐
//  │  AppThemeFactory  → Abstract Factory                                   │
//  │  Products family:                                                       │
//  │    • AppColorTokens       → color palette                              │
//  │    • AppTypography        → font pairing + TextTheme builder           │
//  │    • AppComponentStyles   → Material component customizations          │
//  │  Each design system (GoldenStandard, ElectricAlchemist) is a          │
//  │  ConcreteFactory returning a COMPATIBLE product family.                │
//  └────────────────────────────────────────────────────────────────────────┘
//
//  ┌─ TEMPLATE METHOD ──────────────────────────────────────────────────────┐
//  │  AppThemeFactory.build() — invariant pipeline:                         │
//  │    1. createTokens()      (abstract — implemented by ConcreteFactory)  │
//  │    2. createTypography()  (abstract — implemented by ConcreteFactory)  │
//  │    3. createComponents()  (abstract — implemented by ConcreteFactory)  │
//  │    4. assemble ThemeData  (final   — cannot be overridden)             │
//  └────────────────────────────────────────────────────────────────────────┘
//
// ── Adding a new theme ───────────────────────────────────────────────────────
// 1. Create  YourThemeColors     extends AppColorTokens
// 2. Create  YourThemeTypography extends AppTypography
// 3. Create  YourThemeComponents extends DefaultComponentStyles (override only diffs)
// 4. Create  YourThemeLightFactory / YourThemeDarkFactory extends AppThemeFactory
// 5. Add two cases in AppThemeRegistry.factoryFor()
// ─────────────────────────────────────────────────────────────────────────────

// -----------------------------------------------------------------------------
// § 1 · PRODUCT CONTRACTS (Abstract Products)
// -----------------------------------------------------------------------------

/// Color palette contract — every theme must provide these 29 tokens.
abstract class AppColorTokens {
  const AppColorTokens();
  // Core roles
  Color get primary;
  Color get onPrimary;
  Color get primaryContainer;
  Color get onPrimaryContainer;
  Color get secondary;
  Color get onSecondary;
  Color get secondaryContainer;
  Color get onSecondaryContainer;
  Color get tertiary;
  Color get onTertiary;
  Color get tertiaryContainer;
  Color get onTertiaryContainer;
  Color get error;
  Color get onError;
  Color get errorContainer;
  Color get onErrorContainer;

  // Surface tiers
  Color get surface;
  Color get onSurface;
  Color get onSurfaceVariant;
  Color get surfaceContainerLowest;
  Color get surfaceContainerLow;
  Color get surfaceContainer;
  Color get surfaceContainerHigh;
  Color get surfaceContainerHighest;
  Color get surfaceBright;

  // Outline
  Color get outline;
  Color get outlineVariant;

  // Inverse
  Color get inverseSurface;
  Color get onInverseSurface;
  Color get inversePrimary;

  // Meta
  Brightness get brightness;

  // Semantic helpers (concrete — subclasses rarely override)
  Color shadow(double opacity) =>
      Color.fromRGBO(0, 0, 0, opacity.clamp(0.0, 1.0));

  /// Theme-specific accent glow color (neon for EA, gold for GS).
  Color accentGlow(double opacity);

  /// Materializes all tokens into a Material 3 [ColorScheme].
  ColorScheme toColorScheme() => ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        inverseSurface: inverseSurface,
        onInverseSurface: onInverseSurface,
        inversePrimary: inversePrimary,
      );
}

/// Typography contract — font pairing + text theme builder.
abstract class AppTypography {
  const AppTypography();
  /// Display/headline font family (e.g. Space Grotesk, Manrope).
  String get displayFont;

  /// Body / data / UI prose font family (always Inter).
  String get bodyFont;

  /// Builds the full Material [TextTheme] using [colors] for role-based colors.
  TextTheme build(AppColorTokens colors);
}

/// Component styles contract — every theme configures these Material components.
abstract class AppComponentStyles {
  const AppComponentStyles();
  AppBarTheme appBarTheme(AppColorTokens c, AppTypography t);
  NavigationBarThemeData navigationBarTheme(AppColorTokens c, AppTypography t);
  ElevatedButtonThemeData elevatedButtonTheme(AppColorTokens c, AppTypography t);
  OutlinedButtonThemeData outlinedButtonTheme(AppColorTokens c, AppTypography t);
  TextButtonThemeData textButtonTheme(AppColorTokens c, AppTypography t);
  FilledButtonThemeData filledButtonTheme(AppColorTokens c, AppTypography t);
  InputDecorationTheme inputDecorationTheme(AppColorTokens c, AppTypography t);
  CardThemeData cardTheme(AppColorTokens c);
  ChipThemeData chipTheme(AppColorTokens c, AppTypography t);
  ListTileThemeData listTileTheme(AppColorTokens c, AppTypography t);
  BottomSheetThemeData bottomSheetTheme(AppColorTokens c);
  SnackBarThemeData snackBarTheme(AppColorTokens c, AppTypography t);
  DialogThemeData dialogTheme(AppColorTokens c, AppTypography t);
  SwitchThemeData switchTheme(AppColorTokens c);
  FloatingActionButtonThemeData fabTheme(AppColorTokens c);
  ProgressIndicatorThemeData progressIndicatorTheme(AppColorTokens c);
  BadgeThemeData badgeTheme(AppColorTokens c, AppTypography t);
}

// -----------------------------------------------------------------------------
// § 2 · ABSTRACT FACTORY — with TEMPLATE METHOD build()
// -----------------------------------------------------------------------------

/// The Abstract Factory for El Dorado app themes.
///
/// **Abstract Factory role:** declares the three factory methods that create
/// the compatible product family for a specific design system variant.
///
/// **Template Method role:** [build] is the sealed pipeline that assembles
/// a [ThemeData] from those products. No subclass can alter the assembly order.
abstract class AppThemeFactory {
  const AppThemeFactory();
  // ── Three abstract factory methods ─────────────────────────────────────────
  AppColorTokens createTokens();
  AppTypography createTypography();
  AppComponentStyles createComponents();

  // ── Template Method (sealed assembly pipeline) ──────────────────────────────
  ThemeData build() {
    final colors = createTokens();
    final typography = createTypography();
    final components = createComponents();

    final colorScheme = colors.toColorScheme();
    final textTheme = typography.build(colors);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.surface,
      canvasColor: colors.surface,
      cardColor: colors.surfaceContainerLow,
      shadowColor: colors.shadow(0.4),
      fontFamily: typography.bodyFont,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: components.appBarTheme(colors, typography),
      navigationBarTheme: components.navigationBarTheme(colors, typography),
      elevatedButtonTheme: components.elevatedButtonTheme(colors, typography),
      outlinedButtonTheme: components.outlinedButtonTheme(colors, typography),
      textButtonTheme: components.textButtonTheme(colors, typography),
      filledButtonTheme: components.filledButtonTheme(colors, typography),
      inputDecorationTheme: components.inputDecorationTheme(colors, typography),
      cardTheme: components.cardTheme(colors),
      chipTheme: components.chipTheme(colors, typography),
      listTileTheme: components.listTileTheme(colors, typography),
      bottomSheetTheme: components.bottomSheetTheme(colors),
      snackBarTheme: components.snackBarTheme(colors, typography),
      dialogTheme: components.dialogTheme(colors, typography),
      switchTheme: components.switchTheme(colors),
      floatingActionButtonTheme: components.fabTheme(colors),
      progressIndicatorTheme: components.progressIndicatorTheme(colors),
      badgeTheme: components.badgeTheme(colors, typography),
      // ── Invariant rules — same for every El Dorado theme ─────────────────
      dividerTheme: const DividerThemeData(
          color: Colors.transparent, thickness: 0, space: 0),
      dividerColor: Colors.transparent,
      iconTheme: IconThemeData(color: colors.onSurface, size: 24),
      primaryIconTheme: IconThemeData(color: colors.primary, size: 24),
      splashColor: colors.primary.withValues(alpha: 0.05),
      highlightColor: colors.primary.withValues(alpha: 0.02),
      hoverColor: colors.surfaceContainerHigh,
      focusColor: colors.primaryContainer.withValues(alpha: 0.12),
    );
  }
}

// -----------------------------------------------------------------------------
// § 3 · DEFAULT COMPONENT STYLES
// (Template Method "hook" steps — shared across all themes)
// -----------------------------------------------------------------------------

/// Base implementation of [AppComponentStyles] for El Dorado themes.
///
/// Provides **default** implementations for component behaviors that are
/// identical across all themes. Concrete component classes extend this and
/// override only the parts that differ (Template Method "optional steps").
abstract class DefaultComponentStyles implements AppComponentStyles {
  const DefaultComponentStyles();

  @override
  NavigationBarThemeData navigationBarTheme(AppColorTokens c, AppTypography t) =>
      NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        indicatorColor: c.primaryContainer,
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: c.onPrimaryContainer, size: 24);
          }
          return IconThemeData(
              color: c.onSurface.withValues(alpha: 0.4), size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 10,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 1.0,
            color: active
                ? c.onPrimaryContainer
                : c.onSurface.withValues(alpha: 0.4),
          );
        }),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        height: 64,
      );

  @override
  TextButtonThemeData textButtonTheme(AppColorTokens c, AppTypography t) =>
      TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return c.primary.withValues(alpha: 0.6);
            }
            return c.primary;
          }),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          textStyle: WidgetStateProperty.all(TextStyle(
              fontFamily: t.bodyFont,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm)),
        ),
      );

  @override
  FilledButtonThemeData filledButtonTheme(AppColorTokens c, AppTypography t) =>
      FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(c.primaryContainer),
          foregroundColor: WidgetStateProperty.all(c.onPrimaryContainer),
          overlayColor: WidgetStateProperty.all(
              c.onPrimaryContainer.withValues(alpha: 0.08)),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md))),
        ),
      );

  @override
  CardThemeData cardTheme(AppColorTokens c) => CardThemeData(
        color: c.surfaceContainerLow,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md)),
        clipBehavior: Clip.antiAlias,
      );

  @override
  ChipThemeData chipTheme(AppColorTokens c, AppTypography t) => ChipThemeData(
        backgroundColor: c.surfaceContainer,
        selectedColor: c.primaryContainer,
        disabledColor: c.surfaceContainerLow,
        deleteIconColor: c.onSurfaceVariant,
        labelStyle: TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: c.onSurface),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        shape: const StadiumBorder(side: BorderSide.none),
        elevation: 0,
        pressElevation: 0,
        shadowColor: Colors.transparent,
      );

  @override
  ListTileThemeData listTileTheme(AppColorTokens c, AppTypography t) =>
      ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: c.surfaceContainerHigh,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md)),
        titleTextStyle: TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: c.onSurface),
        subtitleTextStyle: TextStyle(
            fontFamily: t.bodyFont,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: c.onSurfaceVariant),
        iconColor: c.primaryContainer,
        textColor: c.onSurface,
        horizontalTitleGap: AppSpacing.lg,
        minVerticalPadding: AppSpacing.md,
      );

  @override
  BottomSheetThemeData bottomSheetTheme(AppColorTokens c) =>
      BottomSheetThemeData(
        backgroundColor: c.surfaceContainerLow,
        modalBackgroundColor: c.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.xl),
            topRight: Radius.circular(AppRadius.xl),
          ),
        ),
        dragHandleColor: c.outlineVariant,
        dragHandleSize: const Size(32, 4),
        showDragHandle: true,
      );

  @override
  SnackBarThemeData snackBarTheme(AppColorTokens c, AppTypography t) =>
      SnackBarThemeData(
        backgroundColor: c.surfaceContainerHighest,
        contentTextStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 14, color: c.onSurface),
        actionTextColor: c.primaryContainer,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md)),
        elevation: 0,
      );

  @override
  SwitchThemeData switchTheme(AppColorTokens c) => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return c.onPrimary;
          return c.onSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return c.primaryContainer;
          return c.surfaceContainerHigh;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      );

  @override
  ProgressIndicatorThemeData progressIndicatorTheme(AppColorTokens c) =>
      ProgressIndicatorThemeData(
        color: c.primaryContainer,
        linearTrackColor: c.surfaceContainerHigh,
        circularTrackColor: c.surfaceContainerHigh,
      );

  @override
  BadgeThemeData badgeTheme(AppColorTokens c, AppTypography t) => BadgeThemeData(
        backgroundColor: c.primaryContainer,
        textColor: c.onPrimaryContainer,
        textStyle: TextStyle(
            fontFamily: t.bodyFont, fontSize: 10, fontWeight: FontWeight.w700),
      );
}

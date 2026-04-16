import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// THE ELECTRIC ALCHEMIST — Design System
// Source of truth: assets/DESIGN_SYSTEM.md
// =============================================================================

// -----------------------------------------------------------------------------
// § 1 · COLOR TOKENS
// -----------------------------------------------------------------------------

/// Full color palette for "The Electric Alchemist" design system.
///
/// The core tension: `#131313` (Surface) vs `#EFFF00` (Vibrant Energy).
///
/// Usage:
/// - Reach for [AppColors] when you need a raw color token.
/// - Reach for [ColorScheme] (via `Theme.of(context).colorScheme`) for
///   Material 3 semantic slots that are wired automatically.
abstract final class AppColors {
  // ─── Primary role ────────────────────────────────────────────────────────
  /// #FFFFFF — Maximum readability against dark backgrounds.
  static const Color primary = Color(0xFFFFFFFF);

  /// #2F3300 — Text/icon on the golden primary container.
  static const Color onPrimary = Color(0xFF2F3300);

  /// #DEED00 / #EFFF00 — The "Golden" signature. CTAs, status indicators.
  static const Color primaryContainer = Color(0xFFDEED00);

  /// Vibrant variant used for glows and bleeds (#EFFF00).
  static const Color primaryContainerVibrant = Color(0xFFEFFF00);

  /// #626900 — Text on the primary container (muted golden).
  static const Color onPrimaryContainer = Color(0xFF626900);

  /// #C3D000 — Dim/secondary variant of the golden.
  static const Color primaryFixedDim = Color(0xFFC3D000);

  // ─── Secondary role ───────────────────────────────────────────────────────
  /// #C6C6C7 — Secondary text, divider-replacement tones.
  static const Color secondary = Color(0xFFC6C6C7);

  /// #2F3131 — Text on secondary elements.
  static const Color onSecondary = Color(0xFF2F3131);

  /// #454747 — Secondary container (chips, badges).
  static const Color secondaryContainer = Color(0xFF454747);

  /// #B4B5B5 — Text on secondary container.
  static const Color onSecondaryContainer = Color(0xFFB4B5B5);

  // ─── Tertiary role ────────────────────────────────────────────────────────
  /// #EFFF00 — Tertiary equals primary container by design intent.
  static const Color tertiary = Color(0xFFEFFF00);

  /// #2F3300 — Text on tertiary.
  static const Color onTertiary = Color(0xFF2F3300);

  /// #DEED00 — Tertiary container.
  static const Color tertiaryContainer = Color(0xFFDEED00);

  /// #626900 — Text on tertiary container.
  static const Color onTertiaryContainer = Color(0xFF626900);

  // ─── Error role ───────────────────────────────────────────────────────────
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // ─── Surface tiers ────────────────────────────────────────────────────────
  /// #131313 — The base canvas.
  static const Color surface = Color(0xFF131313);

  /// #E2E2E2 — Text/icon on surface.
  static const Color onSurface = Color(0xFFE2E2E2);

  /// #C8C8AB — Muted / secondary text on surface (warm tint, not pure grey).
  static const Color onSurfaceVariant = Color(0xFFC8C8AB);

  /// #0E0E0E — Deepest recesses, sunken cards.
  static const Color surfaceContainerLowest = Color(0xFF0E0E0E);

  /// #1B1B1B — Container low-tier, section backgrounds.
  static const Color surfaceContainerLow = Color(0xFF1B1B1B);

  /// #1F1F1F — Standard container.
  static const Color surfaceContainer = Color(0xFF1F1F1F);

  /// #2A2A2A — Elevated interactive elements.
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);

  /// #353535 — Highest elevation, top-most interactive surfaces.
  static const Color surfaceContainerHighest = Color(0xFF353535);

  /// #393939 — Used at 60 % opacity for glassmorphism nav.
  static const Color surfaceBright = Color(0xFF393939);

  // ─── Outline ──────────────────────────────────────────────────────────────
  /// #929277 — Borders (use sparingly; prefer tonal layering).
  static const Color outline = Color(0xFF929277);

  /// #474832 — Ghost border / divider-at-opacity. Never use at 100 % opacity.
  static const Color outlineVariant = Color(0xFF474832);

  // ─── Inverse ──────────────────────────────────────────────────────────────
  static const Color inverseSurface = Color(0xFFE2E2E2);
  static const Color onInverseSurface = Color(0xFF303030);
  static const Color inversePrimary = Color(0xFF5C6300);

  // ─── Semantic helpers ─────────────────────────────────────────────────────
  /// Transparent — convenience alias.
  static const Color transparent = Colors.transparent;

  /// Deep atmospheric shadow tint (black at various opacities).
  static Color shadow(double opacity) =>
      Color.fromRGBO(0, 0, 0, opacity.clamp(0.0, 1.0));

  /// Golden glow — primaryContainer at a given opacity (for box-shadows /
  /// radial gradient accents).
  static Color goldenGlow(double opacity) =>
      Color.fromRGBO(0xDE, 0xED, 0x00, opacity.clamp(0.0, 1.0));
}

// -----------------------------------------------------------------------------
// § 2 · SPACING TOKENS
// -----------------------------------------------------------------------------

/// Spacing + border-radius scale for "The Electric Alchemist".
///
/// | Token | Value   | Application                       |
/// |-------|---------|-----------------------------------|
/// | none  | 0       | Hard edges, brutalist sections    |
/// | xs    | 4       | Tight internal gaps               |
/// | sm    | 4       | Internal button padding           |
/// | md    | 12      | Standard card radius              |
/// | lg    | 16      | Card / section padding            |
/// | xl    | 24      | Main container margins (gutter)   |
/// | xxl   | 32      | Hero section padding              |
/// | full  | 9999    | Pills, chips, toggles             |
abstract final class AppSpacing {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 4; // 0.25 rem → 4 px
  static const double md = 12; // 0.75 rem → 12 px
  static const double lg = 16;
  static const double xl = 24; // 1.5  rem → 24 px
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// Border-radius tokens matching the spacing scale.
abstract final class AppRadius {
  static const double none = 0;
  static const double sm = 4; // 0.25 rem
  static const double md = 12; // 0.75 rem — standard card
  static const double lg = 16;
  static const double xl = 24; // 1.5  rem
  static const double full = 9999; // pills / chips
}

// -----------------------------------------------------------------------------
// § 3 · TYPOGRAPHY TOKENS
// -----------------------------------------------------------------------------

/// Font-family accessors backed by google_fonts.
///
/// - **Headline / Display / Label** → Space Grotesk (the "loud" voice)
/// - **Body / Title**              → Inter (the "functional" voice)
abstract final class AppFonts {
  /// Space Grotesk — Display, Headlines, Labels.
  static String get spaceGrotesk => GoogleFonts.spaceGrotesk().fontFamily!;

  /// Inter — Body copy, Titles, UI prose.
  static String get inter => GoogleFonts.inter().fontFamily!;
}

// -----------------------------------------------------------------------------
// § 4 · ELEVATION / SHADOW TOKENS
// -----------------------------------------------------------------------------

/// Pre-built [BoxShadow] lists matching the "Ambient Shadow" spec.
///
/// DO NOT use standard Material elevation shadows (grey drop-shadows).
/// Always use these deep, soft, atmospheric variants.
abstract final class AppShadows {
  /// Subtle lift — cards on dark surface.
  static List<BoxShadow> get low => [
        BoxShadow(
          color: AppColors.shadow(0.15),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  /// Standard floating element — sheets, popovers.
  static List<BoxShadow> get medium => [
        BoxShadow(
          color: AppColors.shadow(0.4),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  /// High floating — modals, bottom sheets.
  static List<BoxShadow> get high => [
        BoxShadow(
          color: AppColors.shadow(0.4),
          blurRadius: 40,
          offset: const Offset(0, 20),
        ),
      ];

  /// Golden glow — CTA buttons, active nav indicators.
  static List<BoxShadow> goldenGlow({double opacity = 0.20}) => [
        BoxShadow(
          color: AppColors.goldenGlow(opacity),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ];

  /// Navigation bar top shadow.
  static List<BoxShadow> get navBar => [
        BoxShadow(
          color: AppColors.shadow(0.6),
          blurRadius: 40,
          offset: const Offset(0, -10),
        ),
      ];
}

// -----------------------------------------------------------------------------
// § 5 · DECORATIONS (reusable BoxDecoration helpers)
// -----------------------------------------------------------------------------

/// Reusable [BoxDecoration] presets that encode the design rules.
abstract final class AppDecorations {
  /// Radial golden glow texture — for Hero section backgrounds.
  ///
  /// "radial-gradient(circle at top left, #deed00 0%, #131313 40%) at 5%"
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
  ///
  /// surfaceBright at 60% opacity + 24px backdrop-blur (apply ClipRRect +
  /// BackdropFilter separately; this decoration handles fill + border only).
  static BoxDecoration glassmorphism({
    BorderRadius? borderRadius,
  }) =>
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
  static BoxDecoration card({
    double radius = AppRadius.md,
    bool elevated = false,
  }) =>
      BoxDecoration(
        color: elevated
            ? AppColors.surfaceContainerHigh
            : AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: elevated ? AppShadows.low : null,
      );

  /// Wealth Card — glassmorphic balance card (primary_fixed gradient base).
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
          isDark ? const Color(0xFF1A1A00) : cs.primaryContainer.withValues(alpha: 0.15),
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
      colors: [
        Color(0xFF1A1A00),
        AppColors.surfaceContainerLowest,
      ],
      stops: [0.0, 0.6],
    ),
  );
}

// -----------------------------------------------------------------------------
// § 6 · MATERIAL COLOR SCHEME
// -----------------------------------------------------------------------------

/// The M3 [ColorScheme] derived from [AppColors] tokens.
const ColorScheme _colorScheme = ColorScheme(
  brightness: Brightness.dark,
  // Primary
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  // Secondary
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.secondaryContainer,
  onSecondaryContainer: AppColors.onSecondaryContainer,
  // Tertiary (= golden, same intent as primaryContainer)
  tertiary: AppColors.tertiary,
  onTertiary: AppColors.onTertiary,
  tertiaryContainer: AppColors.tertiaryContainer,
  onTertiaryContainer: AppColors.onTertiaryContainer,
  // Error
  error: AppColors.error,
  onError: AppColors.onError,
  errorContainer: AppColors.errorContainer,
  onErrorContainer: AppColors.onErrorContainer,
  // Surface
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  // Outline
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
  // Inverse
  inverseSurface: AppColors.inverseSurface,
  onInverseSurface: AppColors.onInverseSurface,
  inversePrimary: AppColors.inversePrimary,
);

// -----------------------------------------------------------------------------
// § 7 · TEXT THEME
// -----------------------------------------------------------------------------

TextTheme _buildTextTheme() {
  // Space Grotesk — the "loud" editorial voice
  final sg = AppFonts.spaceGrotesk;
  // Inter — the "functional" utility voice
  final it = AppFonts.inter;

  return TextTheme(
    // ── Display (Space Grotesk) ─────────────────────────────────────────────
    // display-lg ≈ 3.5 rem → 56 px
    displayLarge: TextStyle(
      fontFamily: sg,
      fontSize: 56,
      fontWeight: FontWeight.w700,
      letterSpacing: -2.0,
      height: 1.0,
      color: AppColors.primary,
    ),
    // display-md ≈ 3 rem → 48 px
    displayMedium: TextStyle(
      fontFamily: sg,
      fontSize: 48,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.05,
      color: AppColors.primary,
    ),
    // display-sm ≈ 2.25 rem → 36 px
    displaySmall: TextStyle(
      fontFamily: sg,
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.0,
      height: 1.1,
      color: AppColors.primary,
    ),

    // ── Headline (Space Grotesk) ────────────────────────────────────────────
    headlineLarge: TextStyle(
      fontFamily: sg,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.15,
      color: AppColors.primary,
    ),
    headlineMedium: TextStyle(
      fontFamily: sg,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.2,
      color: AppColors.primary,
    ),
    headlineSmall: TextStyle(
      fontFamily: sg,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      height: 1.25,
      color: AppColors.primary,
    ),

    // ── Title (Inter) ───────────────────────────────────────────────────────
    titleLarge: TextStyle(
      fontFamily: it,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.3,
      color: AppColors.primary,
    ),
    titleMedium: TextStyle(
      fontFamily: it,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.3,
      color: AppColors.primary,
    ),
    titleSmall: TextStyle(
      fontFamily: it,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.4,
      color: AppColors.primary,
    ),

    // ── Body-md (Inter) — "the workhorse" ≈ 0.875 rem → 14 px ────────────
    bodyLarge: TextStyle(
      fontFamily: it,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.5,
      color: AppColors.onSurface,
    ),
    bodyMedium: TextStyle(
      fontFamily: it,
      fontSize: 14, // body-md: 0.875 rem
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.5,
      color: AppColors.onSurface,
    ),
    bodySmall: TextStyle(
      fontFamily: it,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.5,
      color: AppColors.onSurfaceVariant,
    ),

    // ── Label (Space Grotesk — uppercase sub-headers) ───────────────────────
    // label-md — paired with display-sm for "Power vs Precision" hierarchy
    labelLarge: TextStyle(
      fontFamily: sg,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.4,
      color: AppColors.onSurface,
    ),
    labelMedium: TextStyle(
      fontFamily: sg,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
      height: 1.4,
      color: AppColors.onSurface,
    ),
    labelSmall: TextStyle(
      fontFamily: sg,
      fontSize: 10,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
      height: 1.4,
      color: AppColors.onSurfaceVariant,
    ),
  );
}

// -----------------------------------------------------------------------------
// § 8 · COMPONENT THEMES
// -----------------------------------------------------------------------------

// ─── Buttons ─────────────────────────────────────────────────────────────────

/// Primary (Golden) button style.
///
/// Background: primaryContainer (#deed00) · Text: onPrimary (#2f3300).
/// Use for the main CTA action on each screen.
ElevatedButtonThemeData _primaryButtonTheme(TextTheme tt) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.primaryContainer.withValues(alpha: 0.38);
        }
        return AppColors.primaryContainer;
      }),
      foregroundColor: WidgetStateProperty.all(AppColors.onPrimary),
      overlayColor: WidgetStateProperty.all(
        AppColors.onPrimary.withValues(alpha: 0.08),
      ),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontFamily: AppFonts.spaceGrotesk,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      animationDuration: const Duration(milliseconds: 200),
    ),
  );
}

/// Secondary button style.
///
/// Background: surfaceContainerHigh · Text: primary (#FFFFFF).
OutlinedButtonThemeData _secondaryButtonTheme() {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.surfaceContainerHigh),
      foregroundColor: WidgetStateProperty.all(AppColors.primary),
      overlayColor: WidgetStateProperty.all(
        AppColors.primary.withValues(alpha: 0.08),
      ),
      side: WidgetStateProperty.all(BorderSide.none),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    ),
  );
}

/// Tertiary button style.
///
/// No background · Text: primary. Opacity shift on press.
TextButtonThemeData _tertiaryButtonTheme() {
  return TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return AppColors.primary.withValues(alpha: 0.6);
        }
        return AppColors.primary;
      }),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    ),
  );
}

// ─── Input fields ─────────────────────────────────────────────────────────────

InputDecorationTheme _inputDecorationTheme(TextTheme tt) {
  // Ghost border: primaryContainer at 40% opacity
  final ghostBorder = AppColors.primaryContainer.withValues(alpha: 0.4);

  return InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceContainerHighest,
    // No border in default state (No-Line rule)
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    // 2px Ghost Border on focus
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ghostBorder, width: 2),
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error.withValues(alpha: 0.4),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error, width: 2),
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    // Helper text — label-sm in onSurfaceVariant
    helperStyle: TextStyle(
      fontFamily: AppFonts.spaceGrotesk,
      fontSize: 10,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
      color: AppColors.onSurfaceVariant,
    ),
    hintStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
    ),
    labelStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariant,
    ),
    floatingLabelStyle: TextStyle(
      fontFamily: AppFonts.spaceGrotesk,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryContainer,
    ),
    errorStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 10,
      color: AppColors.error,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    isDense: false,
  );
}

// ─── Cards ────────────────────────────────────────────────────────────────────

CardThemeData _cardTheme() {
  return CardThemeData(
    color: AppColors.surfaceContainerLow,
    elevation: 0,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    clipBehavior: Clip.antiAlias,
  );
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.primary,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ),
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
}

// ─── Navigation Bar ───────────────────────────────────────────────────────────

NavigationBarThemeData _navigationBarTheme() {
  return NavigationBarThemeData(
    // Transparent because AppShell draws its own glassmorphism container.
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    // Golden pill indicator
    indicatorColor: AppColors.primaryContainer,
    indicatorShape: const StadiumBorder(),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: AppColors.onPrimary, size: 24);
      }
      return IconThemeData(
        color: AppColors.primary.withValues(alpha: 0.4),
        size: 24,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      final active = states.contains(WidgetState.selected);
      return TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 10,
        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: 1.2,
        color: active
            ? AppColors.onPrimary
            : AppColors.primary.withValues(alpha: 0.4),
      );
    }),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    height: 64,
  );
}

// ─── Chip ─────────────────────────────────────────────────────────────────────

ChipThemeData _chipTheme() {
  return ChipThemeData(
    backgroundColor: AppColors.surfaceContainer,
    selectedColor: AppColors.primaryContainer,
    disabledColor: AppColors.surfaceContainerLow,
    deleteIconColor: AppColors.onSurfaceVariant,
    labelStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 10,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      color: AppColors.onSurface,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.xs,
    ),
    shape: const StadiumBorder(side: BorderSide.none),
    elevation: 0,
    pressElevation: 0,
    shadowColor: Colors.transparent,
  );
}

// ─── Divider ─────────────────────────────────────────────────────────────────

/// Divider is effectively hidden — the "No-Line" rule.
///
/// Use surface color shifts / spacing instead of visible dividers.
DividerThemeData _dividerTheme() {
  return const DividerThemeData(
    color: Colors.transparent,
    thickness: 0,
    space: 0,
  );
}

// ─── Floating Action Button ───────────────────────────────────────────────────

FloatingActionButtonThemeData _fabTheme() {
  return FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryContainer,
    foregroundColor: AppColors.onPrimary,
    elevation: 0,
    highlightElevation: 0,
    shape: const CircleBorder(),
    extendedTextStyle: TextStyle(
      fontFamily: AppFonts.spaceGrotesk,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );
}

// ─── Switch ───────────────────────────────────────────────────────────────────

SwitchThemeData _switchTheme() {
  return SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.onPrimary;
      return AppColors.onSurfaceVariant;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryContainer;
      }
      return AppColors.surfaceContainerHigh;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
  );
}

// ─── List Tile ────────────────────────────────────────────────────────────────

ListTileThemeData _listTileTheme(TextTheme tt) {
  return ListTileThemeData(
    tileColor: Colors.transparent,
    selectedTileColor: AppColors.surfaceContainerHigh,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    titleTextStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.primary,
    ),
    subtitleTextStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariant,
    ),
    leadingAndTrailingTextStyle: TextStyle(
      fontFamily: AppFonts.spaceGrotesk,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceVariant,
    ),
    iconColor: AppColors.primaryContainer,
    textColor: AppColors.primary,
    horizontalTitleGap: AppSpacing.lg,
    minVerticalPadding: AppSpacing.md,
  );
}

// ─── Bottom Sheet ─────────────────────────────────────────────────────────────

BottomSheetThemeData _bottomSheetTheme() {
  return BottomSheetThemeData(
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
}

// ─── Snack Bar ────────────────────────────────────────────────────────────────

SnackBarThemeData _snackBarTheme(TextTheme tt) {
  return SnackBarThemeData(
    backgroundColor: AppColors.surfaceContainerHighest,
    contentTextStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurface,
    ),
    actionTextColor: AppColors.primaryContainer,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    elevation: 0,
  );
}

// ─── Dialog ───────────────────────────────────────────────────────────────────

DialogThemeData _dialogTheme() {
  return DialogThemeData(
    backgroundColor: AppColors.surfaceContainerLow,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    titleTextStyle: TextStyle(
      fontFamily: AppFonts.spaceGrotesk,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      color: AppColors.primary,
    ),
    contentTextStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurface,
    ),
  );
}

// ─── Progress Indicator ───────────────────────────────────────────────────────

ProgressIndicatorThemeData _progressIndicatorTheme() {
  return const ProgressIndicatorThemeData(
    color: AppColors.primaryContainer,
    linearTrackColor: AppColors.surfaceContainerHigh,
    circularTrackColor: AppColors.surfaceContainerHigh,
    refreshBackgroundColor: AppColors.surfaceContainer,
  );
}

// ─── Badge ────────────────────────────────────────────────────────────────────

BadgeThemeData _badgeTheme() {
  return BadgeThemeData(
    backgroundColor: AppColors.primaryContainer,
    textColor: AppColors.onPrimary,
    textStyle: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 10,
      fontWeight: FontWeight.w700,
    ),
    smallSize: 6,
    largeSize: 16,
  );
}

// ─── Icon ─────────────────────────────────────────────────────────────────────

IconThemeData _iconTheme() {
  return const IconThemeData(
    color: AppColors.primary,
    size: 24,
  );
}

// -----------------------------------------------------------------------------
// § 9 · LIGHT THEME COLORS
// -----------------------------------------------------------------------------

/// Light theme color palette.
///
/// Inverts the surface/primary relationship of the dark theme while
/// maintaining the golden identity (#DEED00 / #EFFF00).
abstract final class AppColorsLight {
  // ─── Primary role ──────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1A1A1A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFDEED00);
  static const Color onPrimaryContainer = Color(0xFF2F3300);

  // ─── Secondary ─────────────────────────────────────────────────────────
  static const Color secondary = Color(0xFF5A5A5A);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8E8E8);
  static const Color onSecondaryContainer = Color(0xFF3A3A3A);

  // ─── Tertiary ──────────────────────────────────────────────────────────
  static const Color tertiary = Color(0xFFC3D000);
  static const Color onTertiary = Color(0xFF2F3300);
  static const Color tertiaryContainer = Color(0xFFEFFF00);
  static const Color onTertiaryContainer = Color(0xFF626900);

  // ─── Error ─────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // ─── Surface tiers ─────────────────────────────────────────────────────
  static const Color surface = Color(0xFFF8F8F2);
  static const Color onSurface = Color(0xFF1A1A1A);
  static const Color onSurfaceVariant = Color(0xFF5A5A48);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F2EA);
  static const Color surfaceContainer = Color(0xFFECECE3);
  static const Color surfaceContainerHigh = Color(0xFFE3E3DA);
  static const Color surfaceContainerHighest = Color(0xFFDADAD0);
  static const Color surfaceBright = Color(0xFFF8F8F2);

  // ─── Outline ───────────────────────────────────────────────────────────
  static const Color outline = Color(0xFF929277);
  static const Color outlineVariant = Color(0xFFD0D0B8);

  // ─── Inverse ───────────────────────────────────────────────────────────
  static const Color inverseSurface = Color(0xFF303030);
  static const Color onInverseSurface = Color(0xFFF2F2EA);
  static const Color inversePrimary = Color(0xFFDEED00);
}

/// Light M3 [ColorScheme].
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

TextTheme _buildLightTextTheme() {
  final sg = AppFonts.spaceGrotesk;
  final it = AppFonts.inter;

  return TextTheme(
    displayLarge: TextStyle(fontFamily: sg, fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -2.0, height: 1.0, color: AppColorsLight.primary),
    displayMedium: TextStyle(fontFamily: sg, fontSize: 48, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.05, color: AppColorsLight.primary),
    displaySmall: TextStyle(fontFamily: sg, fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.0, height: 1.1, color: AppColorsLight.primary),
    headlineLarge: TextStyle(fontFamily: sg, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.15, color: AppColorsLight.primary),
    headlineMedium: TextStyle(fontFamily: sg, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.2, color: AppColorsLight.primary),
    headlineSmall: TextStyle(fontFamily: sg, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.25, color: AppColorsLight.primary),
    titleLarge: TextStyle(fontFamily: it, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0, height: 1.3, color: AppColorsLight.primary),
    titleMedium: TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.3, color: AppColorsLight.primary),
    titleSmall: TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1, height: 1.4, color: AppColorsLight.primary),
    bodyLarge: TextStyle(fontFamily: it, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.5, color: AppColorsLight.onSurface),
    bodyMedium: TextStyle(fontFamily: it, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5, color: AppColorsLight.onSurface),
    bodySmall: TextStyle(fontFamily: it, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.5, color: AppColorsLight.onSurfaceVariant),
    labelLarge: TextStyle(fontFamily: sg, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1.4, color: AppColorsLight.onSurface),
    labelMedium: TextStyle(fontFamily: sg, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.0, height: 1.4, color: AppColorsLight.onSurface),
    labelSmall: TextStyle(fontFamily: sg, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5, height: 1.4, color: AppColorsLight.onSurfaceVariant),
  );
}

// -----------------------------------------------------------------------------
// § 10 · PUBLIC API
// -----------------------------------------------------------------------------

/// Builds the **dark** [ThemeData] — "The Electric Alchemist" (default).
ThemeData buildDarkTheme() {
  // Allow google_fonts to download missing font variants at runtime.
  GoogleFonts.config.allowRuntimeFetching = true;

  final textTheme = _buildTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme,

    // ── Global defaults ────────────────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.surface,
    canvasColor: AppColors.surface,
    cardColor: AppColors.surfaceContainerLow,
    shadowColor: AppColors.shadow(0.4),
    fontFamily: AppFonts.inter,

    // ── Typography ─────────────────────────────────────────────────────────
    textTheme: textTheme,
    primaryTextTheme: textTheme,

    // ── System UI ──────────────────────────────────────────────────────────
    appBarTheme: _appBarTheme(),

    // ── Navigation ─────────────────────────────────────────────────────────
    navigationBarTheme: _navigationBarTheme(),

    // ── Buttons (§5 Components) ────────────────────────────────────────────
    elevatedButtonTheme: _primaryButtonTheme(textTheme),
    outlinedButtonTheme: _secondaryButtonTheme(),
    textButtonTheme: _tertiaryButtonTheme(),
    filledButtonTheme: FilledButtonThemeData(
      // FilledButton → same as ElevatedButton (primary golden)
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryContainer),
        foregroundColor: WidgetStateProperty.all(AppColors.onPrimary),
        overlayColor: WidgetStateProperty.all(
          AppColors.onPrimary.withValues(alpha: 0.08),
        ),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
    ),

    // ── Input fields ───────────────────────────────────────────────────────
    inputDecorationTheme: _inputDecorationTheme(textTheme),

    // ── Cards ──────────────────────────────────────────────────────────────
    cardTheme: _cardTheme(),

    // ── Chips ──────────────────────────────────────────────────────────────
    chipTheme: _chipTheme(),

    // ── Divider ────────────────────────────────────────────────────────────
    dividerTheme: _dividerTheme(),
    dividerColor: Colors.transparent,

    // ── FAB ────────────────────────────────────────────────────────────────
    floatingActionButtonTheme: _fabTheme(),

    // ── Switch ─────────────────────────────────────────────────────────────
    switchTheme: _switchTheme(),

    // ── List Tile ──────────────────────────────────────────────────────────
    listTileTheme: _listTileTheme(textTheme),

    // ── Bottom Sheet ───────────────────────────────────────────────────────
    bottomSheetTheme: _bottomSheetTheme(),

    // ── Snack Bar ──────────────────────────────────────────────────────────
    snackBarTheme: _snackBarTheme(textTheme),

    // ── Dialog ─────────────────────────────────────────────────────────────
    dialogTheme: _dialogTheme(),

    // ── Progress Indicator ─────────────────────────────────────────────────
    progressIndicatorTheme: _progressIndicatorTheme(),

    // ── Badge ──────────────────────────────────────────────────────────────
    badgeTheme: _badgeTheme(),

    // ── Icons ──────────────────────────────────────────────────────────────
    iconTheme: _iconTheme(),
    primaryIconTheme: _iconTheme(),

    // ── Splash / Highlight ─────────────────────────────────────────────────
    // Subtle ink splash instead of the Material grey ring
    splashColor: AppColors.primary.withValues(alpha: 0.04),
    highlightColor: AppColors.primary.withValues(alpha: 0.02),
    hoverColor: AppColors.surfaceContainerHigh,
    focusColor: AppColors.primaryContainer.withValues(alpha: 0.12),
  );
}

/// Builds the **light** [ThemeData] — bright editorial variant.
ThemeData buildLightTheme() {
  GoogleFonts.config.allowRuntimeFetching = true;

  final textTheme = _buildLightTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: AppColorsLight.surface,
    canvasColor: AppColorsLight.surface,
    cardColor: AppColorsLight.surfaceContainerLow,
    shadowColor: AppColorsLight.primary.withValues(alpha: 0.1),
    fontFamily: AppFonts.inter,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsLight.surface,
      foregroundColor: AppColorsLight.primary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
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
          color: active
              ? AppColorsLight.onPrimaryContainer
              : AppColorsLight.primary.withValues(alpha: 0.4),
        );
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 64,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColorsLight.primaryContainer.withValues(alpha: 0.38);
          }
          return AppColorsLight.primaryContainer;
        }),
        foregroundColor: WidgetStateProperty.all(AppColorsLight.onPrimaryContainer),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(
          TextStyle(fontFamily: AppFonts.spaceGrotesk, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.1),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.lg),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        ),
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

/// Convenience alias — returns the dark theme (backward compatible).
ThemeData buildAppTheme() => buildDarkTheme();

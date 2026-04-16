import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// SHARED DESIGN TOKENS — Theme-agnostic primitives
// =============================================================================
//
// These tokens are imported by all theme variants (Electric Alchemist,
// Golden Standard). They define the geometry and typography system that
// remains constant regardless of color scheme.
//
// ┌─────────────────────────────┐
// │  AppSpacing  — size scale   │
// │  AppRadius   — border-radii │
// │  AppFonts    — font names   │
// └─────────────────────────────┘

// -----------------------------------------------------------------------------
// § 1 · SPACING TOKENS
// -----------------------------------------------------------------------------

/// Spacing + border-radius scale.
///
/// | Token | Value | Application                       |
/// |-------|-------|-----------------------------------|
/// | none  |   0   | Hard edges, brutalist sections    |
/// | xs    |   4   | Tight internal gaps               |
/// | sm    |   4   | Internal button padding           |
/// | md    |  12   | Standard card radius              |
/// | lg    |  16   | Card / section padding            |
/// | xl    |  24   | Main container margins (gutter)   |
/// | xxl   |  32   | Hero section padding              |
/// | xxxl  |  48   | Extra-large hero gaps             |
/// | full  | 9999  | Pills, chips, toggles             |
abstract final class AppSpacing {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 4;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

// -----------------------------------------------------------------------------
// § 2 · RADIUS TOKENS
// -----------------------------------------------------------------------------

/// Border-radius tokens matching the spacing scale.
abstract final class AppRadius {
  static const double none = 0;
  static const double sm = 4;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}

// -----------------------------------------------------------------------------
// § 3 · TYPOGRAPHY TOKENS
// -----------------------------------------------------------------------------

/// Font-family accessors backed by google_fonts.
///
/// | Font          | Role                          |
/// |---------------|-------------------------------|
/// | Space Grotesk | Display, Headlines, Labels    |
/// | Manrope       | Golden Standard headlines     |
/// | Inter         | Body, Titles, UI prose        |
abstract final class AppFonts {
  /// Space Grotesk — Electric Alchemist display/headline voice.
  static String get spaceGrotesk => GoogleFonts.spaceGrotesk().fontFamily!;

  /// Manrope — Golden Standard editorial headline voice.
  static String get manrope => GoogleFonts.manrope().fontFamily!;

  /// Inter — functional body / data voice (all themes).
  static String get inter => GoogleFonts.inter().fontFamily!;
}

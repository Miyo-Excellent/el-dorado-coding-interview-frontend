import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/app_bar_logo.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/app_bar_actions.dart';

// =============================================================================
// ORGANISM — ElDoradoSliverAppBar
// =============================================================================
//
// The single, canonical SliverAppBar for every primary screen in El Dorado.
//
// ┌──────────────────────────────────────────────┐
// │  Variant       │ Screen      │ Title          │
// ├──────────────────────────────────────────────┤
// │  branded       │ Home        │ "El Dorado"    │
// │  wallet        │ Wallet      │ "El Dorado"    │
// │  page          │ Activity    │ custom string  │
// │  page          │ Settings    │ custom string  │
// └──────────────────────────────────────────────┘
//
// Design invariants across ALL variants:
//   • pinned: true               — always visible
//   • scrolledUnderElevation: 0  — no shadow on scroll (No-Line rule)
//   • surfaceContainerLowest bg  — deepest surface tier for max contrast
//   • Space Grotesk / Electric Alchemist typography
//
// Usage:
// ```dart
// // ── Home ──────────────────────────────────────────────────────────────────
// const ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.branded)
//
// // ── Wallet ────────────────────────────────────────────────────────────────
// const ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.wallet)
//
// // ── Activity ──────────────────────────────────────────────────────────────
// const ElDoradoSliverAppBar(
//   variant: ElDoradoAppBarVariant.page,
//   title: 'ACTIVIDAD',
//   centerTitle: true,
//   titleSpacing: ElDoradoAppBarTitleSpacing.caps,   // 2 px letter-spacing
//   leadingAction: ElDoradoAppBarLeading.menu,
// )
//
// // ── Settings ──────────────────────────────────────────────────────────────
// const ElDoradoSliverAppBar(
//   variant: ElDoradoAppBarVariant.page,
//   title: 'Ajustes',
//   leadingAction: ElDoradoAppBarLeading.back,
//   onLeadingTap: _handleBack,
// )
// ```
// =============================================================================

/// Supported layout variants.
enum ElDoradoAppBarVariant {
  /// Home: branded logo + notification bell + user avatar.
  branded,

  /// Wallet: avatar leading + branded logo (smaller) + notification circle.
  wallet,

  /// Activity / Settings: optional leading icon + custom title text.
  page,
}

/// Controls the leading icon used in [ElDoradoAppBarVariant.page].
enum ElDoradoAppBarLeading {
  /// No leading icon (default for pages without navigation).
  none,

  /// Hamburger menu icon — used in Activity (tab-based navigation).
  menu,

  /// Back arrow — used in Settings and sub-pages.
  back,
}

/// Controls the typographic style of the [ElDoradoAppBarVariant.page] title.
enum ElDoradoAppBarTitleSpacing {
  /// Standard tight spacing for sentence-case headings.
  /// Inherits `headlineSmall` letter-spacing (-0.3 px).
  standard,

  /// Expanded spacing for ALL-CAPS labels (2 px letter-spacing).
  /// Use this with titles in ALL-CAPS (e.g. 'ACTIVIDAD').
  caps,
}

// =============================================================================
// Widget
// =============================================================================

/// **ORGANISM — ElDoradoSliverAppBar**
///
/// The single source of truth for all primary screen app bars.
/// See file-level comment for full usage documentation.
class ElDoradoSliverAppBar extends StatelessWidget {
  const ElDoradoSliverAppBar({
    super.key,
    required this.variant,

    // ── page variant ─────────────────────────────────────────────────────────
    this.title,
    this.centerTitle = false,
    this.titleSpacing = ElDoradoAppBarTitleSpacing.standard,
    this.leadingAction = ElDoradoAppBarLeading.none,
    this.onLeadingTap,

    // ── shared callbacks ─────────────────────────────────────────────────────
    this.onNotificationTap,
    this.onAvatarTap,

    // ── override slot ────────────────────────────────────────────────────────
    this.actions,
  });

  /// Which layout to render.
  final ElDoradoAppBarVariant variant;

  /// [page] only — The title string. Required when [variant] is `page`.
  final String? title;

  /// [page] only — Whether to centre the title text. Defaults to false.
  final bool centerTitle;

  /// [page] only — Typography style for the title.
  final ElDoradoAppBarTitleSpacing titleSpacing;

  /// [page] only — Which leading icon to show.
  final ElDoradoAppBarLeading leadingAction;

  /// Callback for the leading icon tap. Only used when [leadingAction] is not
  /// [ElDoradoAppBarLeading.none].
  final VoidCallback? onLeadingTap;

  /// Callback for the notification bell / circle icon.
  final VoidCallback? onNotificationTap;

  /// Callback for the user avatar.
  final VoidCallback? onAvatarTap;

  /// Override the default trailing actions list.
  /// If null, variant-specific defaults are rendered.
  final List<Widget>? actions;

  // ── constants ───────────────────────────────────────────────────────────────

  /// All variants share the same background: the deepest surface tier ensures
  /// maximum contrast against content scrolling beneath.
  static const _backgroundOpacity = 0.97;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = cs.surface.withValues(alpha: _backgroundOpacity);

    return switch (variant) {
      ElDoradoAppBarVariant.branded => _BrandedBar(
          bg: bg,
          onNotificationTap: onNotificationTap,
          onAvatarTap: onAvatarTap,
          actions: actions,
        ),
      ElDoradoAppBarVariant.wallet => _WalletBar(
          bg: bg,
          onNotificationTap: onNotificationTap,
          onAvatarTap: onAvatarTap,
          actions: actions,
        ),
      ElDoradoAppBarVariant.page => _PageBar(
          bg: bg,
          title: title ?? '',
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          leadingAction: leadingAction,
          onLeadingTap: onLeadingTap,
          actions: actions,
        ),
    };
  }
}

// =============================================================================
// Private sub-widgets — one per variant
// =============================================================================

/// **Home** — branded logo + notification bell + user avatar.
class _BrandedBar extends StatelessWidget {
  const _BrandedBar({
    required this.bg,
    this.onNotificationTap,
    this.onAvatarTap,
    this.actions,
  });

  final Color bg;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      scrolledUnderElevation: 0,
      backgroundColor: bg,
      automaticallyImplyLeading: false,
      title: const AppBarLogo(),
      actions: actions ??
          [
            AppBarActions(
              onNotificationTap: onNotificationTap,
              onAvatarTap: onAvatarTap,
            ),
          ],
    );
  }
}

/// **Wallet** — avatar leading + logo title (smaller) + notification circle.
class _WalletBar extends StatelessWidget {
  const _WalletBar({
    required this.bg,
    this.onNotificationTap,
    this.onAvatarTap,
    this.actions,
  });

  final Color bg;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      scrolledUnderElevation: 0,
      backgroundColor: bg,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.sm),
        child: GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            backgroundColor: cs.surfaceContainerHigh,
            child: Icon(
              Icons.person_outline,
              color: cs.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
      title: const AppBarLogo(size: AppBarLogoSize.title),
      actions: actions ??
          [
            _NotificationCircle(onTap: onNotificationTap),
          ],
    );
  }
}

/// **Page** (Activity / Settings / sub-pages) — leading icon + custom title.
///
/// Typography:
/// - [ElDoradoAppBarTitleSpacing.standard] → `headlineSmall` (-0.3 px) for
///   sentence-case headings (e.g. "Ajustes").
/// - [ElDoradoAppBarTitleSpacing.caps] → `labelLarge` uppercase with +2 px
///   letter-spacing for ALL-CAPS labels (e.g. "ACTIVIDAD").
class _PageBar extends StatelessWidget {
  const _PageBar({
    required this.bg,
    required this.title,
    required this.centerTitle,
    required this.titleSpacing,
    required this.leadingAction,
    this.onLeadingTap,
    this.actions,
  });

  final Color bg;
  final String title;
  final bool centerTitle;
  final ElDoradoAppBarTitleSpacing titleSpacing;
  final ElDoradoAppBarLeading leadingAction;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;

  IconData? get _leadingIcon => switch (leadingAction) {
        ElDoradoAppBarLeading.none => null,
        ElDoradoAppBarLeading.menu => Icons.menu,
        ElDoradoAppBarLeading.back => Icons.arrow_back,
      };

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    // Typography: caps variant overrides letter-spacing for ALL-CAPS headings.
    final titleStyle = titleSpacing == ElDoradoAppBarTitleSpacing.caps
        ? tt.labelLarge?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 2.0,
            color: cs.onSurface,
          )
        : tt.headlineSmall?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
            // Inherit the -0.3 defined in AppTheme for headlineSmall
          );

    final icon = _leadingIcon;

    return SliverAppBar(
      pinned: true,
      scrolledUnderElevation: 0,
      backgroundColor: bg,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: icon != null
          ? IconButton(
              icon: Icon(icon, color: cs.onSurface),
              onPressed: onLeadingTap,
            )
          : null,
      title: Text(title, style: titleStyle),
      actions: actions,
    );
  }
}

// =============================================================================
// Internal atoms
// =============================================================================

/// Wallet's golden-tinted notification circle (right action).
class _NotificationCircle extends StatelessWidget {
  const _NotificationCircle({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: AppSpacing.lg),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.notifications_outlined,
          color: cs.primaryContainer,
        ),
      ),
    );
  }
}

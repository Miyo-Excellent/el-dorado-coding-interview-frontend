import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/app_bar_logo.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/app_bar_actions.dart';

/// **ORGANISM — ElDoradoSliverAppBar**
///
/// A pre-configured `SliverAppBar` following "The Electric Alchemist" style:
/// pinned, zero scrolled-under-elevation, `surface` background.
///
/// Supports three layout variants:
/// - `ElDoradoAppBarVariant.branded` — logo title + notification/avatar actions (Home)
/// - `ElDoradoAppBarVariant.wallet`  — avatar leading + logo title + circle notification (Wallet)
/// - `ElDoradoAppBarVariant.page`    — optional leading icon + custom title text (Settings/Activity)
///
/// All variants share:
/// - Pinned behavior (stays visible on scroll)
/// - Zero scrolled-under-elevation (no shadow on scroll)
/// - Theme-aware background from `colorScheme.surface`
/// - Consistent height and padding
///
/// ```dart
/// // Home
/// ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.branded)
///
/// // Wallet
/// ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.wallet)
///
/// // Settings
/// ElDoradoSliverAppBar(
///   variant: ElDoradoAppBarVariant.page,
///   title: 'Ajustes',
///   leadingIcon: Icons.arrow_back,
/// )
///
/// // Activity
/// ElDoradoSliverAppBar(
///   variant: ElDoradoAppBarVariant.page,
///   title: 'ACTIVIDAD',
///   centerTitle: true,
///   titleLetterSpacing: 2,
///   leadingIcon: Icons.menu,
/// )
/// ```
enum ElDoradoAppBarVariant { branded, wallet, page }

class ElDoradoSliverAppBar extends StatelessWidget {
  const ElDoradoSliverAppBar({
    super.key,
    required this.variant,
    this.title,
    this.titleColor,
    this.titleLetterSpacing = 0,
    this.centerTitle = false,
    this.leadingIcon,
    this.onLeadingTap,
    this.onNotificationTap,
    this.onAvatarTap,
    this.backgroundOpacity = 1.0,
    this.actions,
  });

  final ElDoradoAppBarVariant variant;

  /// Used only for [ElDoradoAppBarVariant.page]. The [branded] variant
  /// always shows "El Dorado".
  final String? title;

  /// Color of the page title text. Defaults to `colorScheme.onSurface`
  /// if null, ensuring correct contrast in both light and dark mode.
  final Color? titleColor;
  final double titleLetterSpacing;
  final bool centerTitle;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  /// Custom trailing actions. If null, variant-specific defaults are used.
  final List<Widget>? actions;

  /// Used for glassmorphic semi-transparent bars (e.g. Activity: 0.8).
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final bg = cs.surface.withValues(alpha: backgroundOpacity);

    switch (variant) {
      // ── BRANDED (Home) ──────────────────────────────────────────────────
      case ElDoradoAppBarVariant.branded:
        return SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0,
          backgroundColor: bg,
          automaticallyImplyLeading: false,
          title: const AppBarLogo(),
          actions:
              actions ??
              [
                AppBarActions(
                  onNotificationTap: onNotificationTap,
                  onAvatarTap: onAvatarTap,
                ),
              ],
        );

      // ── WALLET ──────────────────────────────────────────────────────────
      case ElDoradoAppBarVariant.wallet:
        return SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0,
          backgroundColor: bg,
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
          actions:
              actions ?? [_WalletNotificationAction(onTap: onNotificationTap)],
        );

      // ── PAGE (Settings / Activity) ───────────────────────────────────────
      case ElDoradoAppBarVariant.page:
        final resolvedTitleColor = titleColor ?? cs.onSurface;
        return SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0,
          backgroundColor: bg,
          centerTitle: centerTitle,
          leading: leadingIcon != null
              ? IconButton(
                  icon: Icon(leadingIcon, color: resolvedTitleColor),
                  onPressed: onLeadingTap,
                )
              : null,
          title: Text(
            title ?? '',
            style: tt.headlineSmall?.copyWith(
              fontFamily: AppFonts.spaceGrotesk,
              fontWeight: FontWeight.w700,
              color: resolvedTitleColor,
              letterSpacing: titleLetterSpacing,
            ),
          ),
          actions: actions,
        );
    }
  }
}

// Internal atom for Wallet's golden circle notification.
class _WalletNotificationAction extends StatelessWidget {
  const _WalletNotificationAction({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: AppSpacing.lg),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.notifications_outlined,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}

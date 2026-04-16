import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../molecules/app_bar_logo.dart';
import '../molecules/app_bar_actions.dart';

/// **ORGANISM — ElDoradoSliverAppBar**
///
/// A pre-configured `SliverAppBar` following "The Electric Alchemist" style:
/// pinned, zero scrolled-under-elevation, `surface` background.
///
/// Supports three layout variants:
/// - `ElDoradoAppBarVariant.branded` — logo title + notification/avatar actions (Home)
/// - `ElDoradoAppBarVariant.wallet`  — avatar leading + logo title + circle notification (Wallet)
/// - `ElDoradoAppBarVariant.page`    — back-arrow leading + custom title text (Settings/Activity)
///
/// ```dart
/// // Home
/// ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.branded)
///
/// // Wallet
/// ElDoradoSliverAppBar(variant: ElDoradoAppBarVariant.wallet)
///
/// // Settings / Activity
/// ElDoradoSliverAppBar(
///   variant: ElDoradoAppBarVariant.page,
///   title: 'Ajustes',
///   titleColor: Theme.of(context).colorScheme.primaryContainer,
///   leadingIcon: Icons.arrow_back,
/// )
/// ```
enum ElDoradoAppBarVariant { branded, wallet, page }

class ElDoradoSliverAppBar extends StatelessWidget {
  const ElDoradoSliverAppBar({
    super.key,
    required this.variant,
    this.title,
    this.titleColor = AppColors.primary,
    this.titleLetterSpacing = 0,
    this.centerTitle = false,
    this.leadingIcon,
    this.onLeadingTap,
    this.onNotificationTap,
    this.onAvatarTap,
    this.backgroundOpacity = 1.0,
  });

  final ElDoradoAppBarVariant variant;

  /// Used only for [ElDoradoAppBarVariant.page]. The [branded] variant
  /// always shows "El Dorado".
  final String? title;
  final Color titleColor;
  final double titleLetterSpacing;
  final bool centerTitle;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  /// Used for glassmorphic semi-transparent bars (Activity: 0.8).
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final bg = Theme.of(context).colorScheme.surface.withValues(alpha: backgroundOpacity);

    switch (variant) {
      // ── BRANDED (Home) ──────────────────────────────────────────────────
      case ElDoradoAppBarVariant.branded:
        return SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0,
          backgroundColor: bg,
          automaticallyImplyLeading: false,
          title: const AppBarLogo(),
          actions: [
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
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          title: const AppBarLogo(size: AppBarLogoSize.title),
          actions: [
            _WalletNotificationAction(onTap: onNotificationTap),
          ],
        );

      // ── PAGE (Settings / Activity) ───────────────────────────────────────
      case ElDoradoAppBarVariant.page:
        return SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0,
          backgroundColor: bg,
          centerTitle: centerTitle,
          leading: leadingIcon != null
              ? IconButton(
                  icon: Icon(leadingIcon, color: titleColor),
                  onPressed: onLeadingTap,
                )
              : null,
          title: Text(
            title ?? '',
            style: tt.headlineSmall?.copyWith(
              fontFamily: AppFonts.spaceGrotesk,
              fontWeight: FontWeight.w700,
              color: titleColor,
              letterSpacing: titleLetterSpacing,
            ),
          ),
          actions: onNotificationTap != null || onAvatarTap == null
              ? null
              : null,
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

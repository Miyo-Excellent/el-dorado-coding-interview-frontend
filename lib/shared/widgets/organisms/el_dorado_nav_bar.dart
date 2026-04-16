import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Data model for a single [ElDoradoNavBar] destination.
class ElDoradoNavItem {
  const ElDoradoNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// **ORGANISM — ElDoradoNavBar**
///
/// The Electric Alchemist custom bottom navigation bar.
///
/// - Background: `surface` at 90% opacity + deep atmospheric shadow
/// - Active tab: rounded golden pill (#deed00) with glow
/// - Inactive tabs: white icon at 40% opacity
/// - No text labels — pure icon-pill navigation
///
/// Extracted from `app_shell.dart` to be independently testable and reusable.
///
/// ```dart
/// ElDoradoNavBar(
///   currentIndex: 0,
///   items: [
///     ElDoradoNavItem(icon: Icons.swap_horizontal_circle_outlined,
///                     selectedIcon: Icons.swap_horizontal_circle,
///                     label: 'Exchange'),
///     ...
///   ],
///   onTap: (i) => context.go(routes[i]),
/// )
/// ```
class ElDoradoNavBar extends StatelessWidget {
  const ElDoradoNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final int currentIndex;
  final List<ElDoradoNavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow.withValues(alpha: 0.95),
        boxShadow: AppShadows.navBar,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.md,
          AppSpacing.xl,
          AppSpacing.md + bottomPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final item = items[i];
            final active = i == currentIndex;

            return _NavPill(
              item: item,
              isActive: active,
              onTap: () => onTap(i),
            );
          }),
        ),
      ),
    );
  }
}

/// Internal atom — a single golden pill / inactive icon in the nav bar.
class _NavPill extends StatelessWidget {
  const _NavPill({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final ElDoradoNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: isActive
            ? const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md - 2,
              )
            : const EdgeInsets.all(AppSpacing.md - 2),
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.full),
                boxShadow: AppShadows.goldenGlow(opacity: 0.30),
              )
            : null,
        child: Icon(
          isActive ? item.selectedIcon : item.icon,
          size: 24,
          color: isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}


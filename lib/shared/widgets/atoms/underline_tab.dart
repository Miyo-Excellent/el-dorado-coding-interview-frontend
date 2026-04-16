import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — UnderlineTab**
///
/// A single tab item with an animated golden underline indicator.
/// Used inside [OfferTabBar] and any horizontal tab row.
///
/// Active state: golden text + 2 px golden pill underline.
/// Inactive state: `onSurfaceVariant` text, no underline.
///
/// ```dart
/// UnderlineTab(label: '💸 Mejor Precio',     isActive: true,  onTap: () {})
/// UnderlineTab(label: '⭐ Mejor Reputación', isActive: false, onTap: () {})
/// ```
class UnderlineTab extends StatelessWidget {
  const UnderlineTab({
    super.key,
    required this.label,
    required this.isActive,
    this.onTap,
    this.indicatorWidth = 80,
  });

  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final double indicatorWidth;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tab label
          Text(
            label,
            style: tt.labelLarge?.copyWith(
              fontFamily: AppFonts.spaceGrotesk,
              color: isActive
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          // Golden underline indicator (only for active tab)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: 2,
            width: isActive ? indicatorWidth : 0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
        ],
      ),
    );
  }
}

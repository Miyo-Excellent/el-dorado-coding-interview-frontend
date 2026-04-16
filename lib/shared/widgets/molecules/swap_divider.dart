import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/golden_icon_button.dart';

/// **MOLECULE — SwapDivider**
///
/// A horizontal swap row: a ghost divider line on both sides of a
/// centered [GoldenIconButton]. Used inside [ExchangeCard].
///
/// Previously a private `_SwapDivider` class — now public and reusable.
///
/// ```dart
/// SwapDivider(onSwap: () {})
/// const SwapDivider()
/// ```
class SwapDivider extends StatelessWidget {
  const SwapDivider({super.key, this.onSwap});

  final VoidCallback? onSwap;

  @override
  Widget build(BuildContext context) {
    final dividerColor = AppColors.outlineVariant.withValues(alpha: 0.4);

    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor, thickness: 1)),
        const SizedBox(width: AppSpacing.md),
        GoldenIconButton(
          icon: Icons.swap_vert,
          onTap: onSwap ?? () {},
          size: 44,
          iconSize: 22,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Divider(color: dividerColor, thickness: 1)),
      ],
    );
  }
}

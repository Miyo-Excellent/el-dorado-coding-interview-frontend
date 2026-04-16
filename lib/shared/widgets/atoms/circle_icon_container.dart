import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — CircleIconContainer**
///
/// A fixed-size circular container holding a centered [Icon].
/// Used as the leading icon in [TransactionRow] and [ActivityGroup] items.
///
/// ```dart
/// CircleIconContainer(icon: Icons.swap_horiz)
/// CircleIconContainer(icon: Icons.download, bgColor: Color(0x1ADEED00), iconColor: AppColors.primaryContainer)
/// ```
class CircleIconContainer extends StatelessWidget {
  const CircleIconContainer({
    super.key,
    required this.icon,
    this.size = 40,
    this.iconSize = 18,
    this.bgColor,
    this.iconColor = AppColors.primary,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color? bgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}

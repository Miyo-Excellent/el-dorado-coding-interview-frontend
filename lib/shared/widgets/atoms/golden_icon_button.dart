import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — GoldenIconButton**
///
/// A circular icon button using the `primaryContainer` (#deed00) fill
/// with a golden ambient glow shadow. Used for swap buttons and quick actions.
///
/// ```dart
/// GoldenIconButton(icon: Icons.swap_vert, onTap: () {})
/// GoldenIconButton(icon: Icons.add, size: 56, onTap: () {})
/// ```
class GoldenIconButton extends StatelessWidget {
  const GoldenIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
    this.iconSize = 22,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          shape: BoxShape.circle,
          boxShadow: AppShadows.goldenGlow(opacity: 0.20),
        ),
        child: Icon(
          icon,
          color: AppColors.onPrimary,
          size: iconSize,
        ),
      ),
    );
  }
}

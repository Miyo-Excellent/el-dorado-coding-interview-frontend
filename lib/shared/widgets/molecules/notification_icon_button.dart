import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **MOLECULE — NotificationIconButton**
///
/// A circular surface-container button with the golden notification bell.
/// Used in the Wallet app bar (different style from Home's transparent bell).
///
/// ```dart
/// const NotificationIconButton()
/// NotificationIconButton(onTap: () {})
/// ```
class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: AppSpacing.lg),
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.notifications_outlined,
          color: AppColors.primaryContainer,
        ),
      ),
    );
  }
}

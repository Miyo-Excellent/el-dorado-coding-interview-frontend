import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

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

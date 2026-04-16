import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/user_avatar_button.dart';

/// **MOLECULE — AppBarActions**
///
/// The standard right-side actions used in the Home screen app bar:
/// a notifications bell + a [UserAvatarButton] atom.
///
/// ```dart
/// AppBarActions(onNotificationTap: () {}, onAvatarTap: () {})
/// ```
class AppBarActions extends StatelessWidget {
  const AppBarActions({
    super.key,
    this.onNotificationTap,
    this.onAvatarTap,
  });

  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
          ),
          onPressed: onNotificationTap,
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          // ATOM: circular user avatar button
          child: UserAvatarButton(onTap: onAvatarTap),
        ),
      ],
    );
  }
}

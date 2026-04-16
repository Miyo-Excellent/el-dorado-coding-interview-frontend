import 'package:flutter/material.dart';

/// **ATOM — UserAvatarButton**
///
/// A small circular avatar button with a person icon.
/// Used in app bars as a tappable profile shortcut.
///
/// ```dart
/// const UserAvatarButton()
/// UserAvatarButton(onTap: () => context.push('/profile'))
/// ```
class UserAvatarButton extends StatelessWidget {
  const UserAvatarButton({super.key, this.onTap, this.radius = 16});

  final VoidCallback? onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: Icon(
          Icons.person_outline,
          size: radius * 1.125,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

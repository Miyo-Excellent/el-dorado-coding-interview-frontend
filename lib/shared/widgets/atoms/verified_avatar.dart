import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — VerifiedAvatar**
///
/// A large circular avatar showing initials, with an optional golden
/// verification badge (check icon in a golden filled circle with a
/// surface-colored border) positioned at the bottom-right.
///
/// Used in [UserProfileSection].
///
/// ```dart
/// VerifiedAvatar(initials: 'G', isVerified: true, radius: 32)
/// VerifiedAvatar(initials: 'A', isVerified: false)
/// ```
class VerifiedAvatar extends StatelessWidget {
  const VerifiedAvatar({
    super.key,
    required this.initials,
    this.isVerified = false,
    this.radius = 32,
    this.onTap,
  });

  final String initials;
  final bool isVerified;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.surfaceContainerHigh,
            child: Text(
              initials,
              style: tt.headlineSmall?.copyWith(fontSize: radius * 0.8125),
            ),
          ),
          if (isVerified)
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: const Icon(
                  Icons.check,
                  size: 10,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

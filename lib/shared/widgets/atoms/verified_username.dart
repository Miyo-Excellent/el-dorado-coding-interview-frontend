import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — VerifiedUsername**
///
/// An inline row: username text + optional golden verified checkmark icon.
/// Follows the design system's verified badge pattern.
///
/// ```dart
/// VerifiedUsername(username: 'glo_cop_usdt', isVerified: true)
/// VerifiedUsername(username: 'user_123')
/// ```
class VerifiedUsername extends StatelessWidget {
  const VerifiedUsername({
    super.key,
    required this.username,
    this.isVerified = false,
  });

  final String username;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          username,
          style: tt.titleSmall?.copyWith(color: AppColors.primary),
        ),
        if (isVerified) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.verified,
            size: 14,
            color: AppColors.primaryContainer,
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **MOLECULE — ProfileNameColumn**
///
/// Username in Space Grotesk bold paired with an optional
/// uppercase golden "VERIFIED" label below it.
/// Used in [UserProfileSection].
///
/// ```dart
/// ProfileNameColumn(username: 'glo_cop_usdt', isVerified: true)
/// ```
class ProfileNameColumn extends StatelessWidget {
  const ProfileNameColumn({
    super.key,
    required this.username,
    this.isVerified = false,
  });

  final String username;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: tt.titleLarge?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (isVerified) ...[
          const SizedBox(height: 2),
          Text(
            'VERIFIED',
            style: tt.labelSmall?.copyWith(
              color: AppColors.primaryContainer,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

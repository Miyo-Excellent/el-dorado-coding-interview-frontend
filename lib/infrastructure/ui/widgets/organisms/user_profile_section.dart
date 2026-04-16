import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/verified_avatar.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/profile_name_column.dart';

/// **ORGANISM — UserProfileSection**
///
/// Displays the authenticated user's profile. Composed of:
/// - [VerifiedAvatar] atom — large avatar with golden verification badge
/// - [ProfileNameColumn] molecule — username + VERIFIED label
/// - Optional "Ver Perfil" link
///
/// ```dart
/// UserProfileSection(
///   initials: 'G',
///   username: 'glo_cop_usdt',
///   isVerified: true,
///   onViewProfile: () {},
/// )
/// ```
class UserProfileSection extends StatelessWidget {
  const UserProfileSection({
    super.key,
    required this.initials,
    required this.username,
    this.isVerified = false,
    this.onViewProfile,
    this.onAvatarTap,
  });

  final String initials;
  final String username;
  final bool isVerified;
  final VoidCallback? onViewProfile;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              // ATOM: verified avatar with badge
              VerifiedAvatar(
                initials: initials,
                isVerified: isVerified,
                onTap: onAvatarTap,
              ),
              const SizedBox(width: AppSpacing.lg),
              // MOLECULE: username + VERIFIED label
              Flexible(
                child: ProfileNameColumn(
                  username: username,
                  isVerified: isVerified,
                ),
              ),
            ],
          ),
        ),
        // View profile link
        if (onViewProfile != null)
          TextButton(
            onPressed: onViewProfile,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primaryContainer,
              textStyle: tt.labelMedium,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Ver Perfil',
              style: tt.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.4),
              ),
            ),
          ),
      ],
    );
  }
}

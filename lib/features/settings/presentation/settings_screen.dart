import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/widgets.dart';

/// Settings screen.
///
/// All layout delegated to the shared atomic widget library.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // ── Static section data ──────────────────────────────────────────────────
  static final _sections = [
    SettingsSection(
      headline: 'CUENTA',
      items: [
        SettingItem(icon: Icons.person_outline,        label: 'Personal Information', onTap: () {}),
        SettingItem(icon: Icons.security,              label: 'Security / 2FA',       onTap: () {}),
        SettingItem(icon: Icons.verified_user_outlined, label: 'Verification Level',   onTap: () {}),
      ],
    ),
    SettingsSection(
      headline: 'PAGOS',
      items: [
        SettingItem(icon: Icons.credit_card_outlined,      label: 'Payment Methods', onTap: () {}),
        SettingItem(icon: Icons.account_balance_outlined,  label: 'Bank Accounts',   onTap: () {}),
      ],
    ),
    SettingsSection(
      headline: 'PREFERENCIAS',
      items: [
        SettingItem(icon: Icons.payments_outlined,   label: 'Currency', trailingLabel: 'USD',     onTap: () {}),
        SettingItem(icon: Icons.language_outlined,   label: 'Language', trailingLabel: 'English', onTap: () {}),
        SettingItem(icon: Icons.dark_mode_outlined,  label: 'Theme',    trailingLabel: 'Dark',    onTap: () {}),
      ],
    ),
    SettingsSection(
      headline: 'SOPORTE',
      items: [
        SettingItem(icon: Icons.help_center_outlined,  label: 'Help Center',      onTap: () {}),
        SettingItem(icon: Icons.description_outlined,  label: 'Terms of Service', onTap: () {}),
        SettingItem(icon: Icons.logout, label: 'Logout', isDestructive: true, showChevron: false, onTap: () {}),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // ── ATOM: Ambient Glow ───────────────────────────────────────
          const AmbientGlowBackground(),

          CustomScrollView(
            slivers: [
              // ── ORGANISM: Settings App Bar ───────────────────────────
              ElDoradoSliverAppBar(
                variant: ElDoradoAppBarVariant.page,
                title: 'Ajustes',
                titleColor: AppColors.primaryContainer,
                titleLetterSpacing: -0.5,
                leadingIcon: Icons.arrow_back,
                onLeadingTap: () {},
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.lg,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── ORGANISM: User Profile Section ───────────────
                      UserProfileSection(
                        initials: 'G',
                        username: 'glo_cop_usdt',
                        isVerified: true,
                        onViewProfile: () {},
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // ── ORGANISM: Settings Body ──────────────────────
                      SettingsBody(sections: _sections),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

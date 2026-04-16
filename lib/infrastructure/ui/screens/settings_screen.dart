import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/theme/theme_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';

/// Settings screen.
///
/// **MVVM pattern:**
/// - **ViewModel** → [ThemeCubit] for the theme toggle
/// - **View** → this widget
///
/// The theme toggle is the key integration point: tapping it
/// triggers [ThemeCubit.toggleTheme()], which persists to Hive
/// and rebuilds the entire MaterialApp reactively.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final themeCubit = context.read<ThemeCubit>();

        final sections = [
          SettingsSection(
            headline: 'CUENTA',
            items: [
              SettingItem(
                icon: Icons.person_outline,
                label: 'Personal Information',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.security,
                label: 'Security / 2FA',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.verified_user_outlined,
                label: 'Verification Level',
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            headline: 'PAGOS',
            items: [
              SettingItem(
                icon: Icons.credit_card_outlined,
                label: 'Payment Methods',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.account_balance_outlined,
                label: 'Bank Accounts',
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            headline: 'PREFERENCIAS',
            items: [
              SettingItem(
                icon: Icons.payments_outlined,
                label: 'Currency',
                trailingLabel: 'USD',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.language_outlined,
                label: 'Language',
                trailingLabel: 'English',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.dark_mode_outlined,
                label: 'Theme',
                trailingLabel: themeCubit.label,
                onTap: () => themeCubit.toggleTheme(),
              ),
            ],
          ),
          SettingsSection(
            headline: 'SOPORTE',
            items: [
              SettingItem(
                icon: Icons.help_center_outlined,
                label: 'Help Center',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.description_outlined,
                label: 'Terms of Service',
                onTap: () {},
              ),
              SettingItem(
                icon: Icons.logout,
                label: 'Logout',
                isDestructive: true,
                showChevron: false,
                onTap: () {},
              ),
            ],
          ),
        ];

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              // ── ATOM: Ambient Glow ───────────────────────────────────
              const AmbientGlowBackground(),

              CustomScrollView(
                slivers: [
                  // ── ORGANISM: Settings App Bar ────────────────────────
                  ElDoradoSliverAppBar(
                    variant: ElDoradoAppBarVariant.page,
                    title: 'Ajustes',
                    titleLetterSpacing: -0.5,
                    leadingIcon: Icons.arrow_back,
                    onLeadingTap: () {},
                    backgroundOpacity: 0.95,
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
                          // ── ORGANISM: User Profile Section ────────────
                          UserProfileSection(
                            initials: 'G',
                            username: 'glo_cop_usdt',
                            isVerified: true,
                            onViewProfile: () {},
                          ),
                          const SizedBox(height: AppSpacing.xxl),

                          // ── ORGANISM: Settings Body ──────────────────
                          SettingsBody(sections: sections),
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
      },
    );
  }
}

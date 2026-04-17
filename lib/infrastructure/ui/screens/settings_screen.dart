import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/theme/theme_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/router/app_router.dart';

/// Settings screen.
///
/// **MVVM pattern:**
/// - **ViewModel** → [ThemeCubit] for the theme variant
/// - **View** → this widget
///
/// The "Apariencia" setting opens a [ThemePickerBottomSheet] that lets the
/// user select any of the 4 available theme variants. The cubit persists
/// the selection to Hive and reactively rebuilds the entire MaterialApp.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppThemeVariant>(
      builder: (context, variant) {
        final sections = [
          SettingsSection(
            headline: 'CUENTA',
            items: [
              SettingItem(
                icon: Icons.person_outline,
                label: 'Personal Information',
                onTap: () => context.push(AppRoutes.personalInfo),
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
                onTap: () => context.push(AppRoutes.bankAccounts),
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
              // ── Theme picker — opens bottom sheet ─────────────────────
              SettingItem(
                icon: Icons.palette_outlined,
                label: 'Apariencia',
                trailingLabel: variant.isDark ? '🌙' : '☀️',
                onTap: () => ThemePickerBottomSheet.show(context),
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
              // ── ATOM: Ambient Glow ───────────────────────────────────────
              const AmbientGlowBackground(),

              RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 600));
                },
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: CustomScrollView(
                  slivers: [
                  // ── ORGANISM: Settings App Bar ────────────────────────────
                  const ElDoradoSliverAppBar(
                    variant: ElDoradoAppBarVariant.page,
                    title: 'Ajustes',
                    leadingAction: ElDoradoAppBarLeading.back,
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
                          // ── ORGANISM: User Profile Section ─────────────
                          UserProfileSection(
                            initials: 'G',
                            username: 'glo_cop_usdt',
                            isVerified: true,
                            onViewProfile: () {},
                          ),
                          const SizedBox(height: AppSpacing.xxl),

                          // ── Active Theme Chip ──────────────────────────
                          _ActiveThemeChip(variant: variant),
                          const SizedBox(height: AppSpacing.xxl),

                          // ── ORGANISM: Settings Body ────────────────────
                          SettingsBody(sections: sections),
                          const SizedBox(height: AppSpacing.xxl),
                        ],
                      ),
                    ),
                  ),
                ], // slivers
              ), // CustomScrollView
            ), // RefreshIndicator
          ], // children stack
        ), // Stack
      ); // return Scaffold
    }, // builder function
  ); // return BlocBuilder
} // build method
} // class

// =============================================================================
// LOCAL ATOM — _ActiveThemeChip
// =============================================================================

/// Shows the currently active theme as an informational chip.
class _ActiveThemeChip extends StatelessWidget {
  const _ActiveThemeChip({required this.variant});
  final AppThemeVariant variant;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final (bg, accent) = variant.previewColors;

    return GestureDetector(
      onTap: () => ThemePickerBottomSheet.show(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: cs.primary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Color swatch
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: cs.outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Center(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tema activo',
                    style: tt.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    variant.displayName,
                    style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant, size: 20),
          ],
        ),
      ),
    );
  }
}

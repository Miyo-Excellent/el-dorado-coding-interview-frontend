import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/setting_item_trailing.dart';

/// **MOLECULE — SettingItem**
///
/// A single tappable row inside a settings group. Composes:
/// - a leading icon (golden by default, red for destructive actions)
/// - a label text
/// - [SettingItemTrailing] atom — optional value label + optional chevron
///
/// ```dart
/// SettingItem(icon: Icons.person_outline, label: 'Personal Information')
/// SettingItem(icon: Icons.payments_outlined, label: 'Currency', trailingLabel: 'USD')
/// SettingItem(icon: Icons.logout, label: 'Logout', isDestructive: true, showChevron: false)
/// ```
class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.icon,
    required this.label,
    this.trailingLabel,
    this.isDestructive = false,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? trailingLabel;
  final bool isDestructive;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final iconColor = isDestructive ? AppColors.error : AppColors.primaryContainer;
    final labelColor = isDestructive ? AppColors.error : AppColors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        splashColor: AppColors.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Text(
                  label,
                  style: tt.bodyLarge?.copyWith(
                    color: labelColor,
                    fontWeight: isDestructive ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              // ATOM: trailing label + chevron
              SettingItemTrailing(label: trailingLabel, showChevron: showChevron),
            ],
          ),
        ),
      ),
    );
  }
}

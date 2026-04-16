import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/golden_icon_button.dart';

/// **MOLECULE — QuickActionButton**
///
/// A vertical column with a [GoldenIconButton] and a label beneath it.
/// Used in the Wallet screen for Recargar / Retirar / Cambiar.
///
/// ```dart
/// QuickActionButton(icon: Icons.add, label: 'Recargar', onTap: () {})
/// ```
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GoldenIconButton(icon: icon, onTap: onTap, size: 56, iconSize: 24),
        const SizedBox(height: AppSpacing.md - 2),
        Text(
          label,
          style: tt.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

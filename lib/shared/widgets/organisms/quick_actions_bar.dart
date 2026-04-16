import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../molecules/quick_action_button.dart';

/// Data class for a single quick action in [QuickActionsBar].
class QuickAction {
  const QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

/// **ORGANISM — QuickActionsBar**
///
/// A centered horizontal row of [QuickActionButton] molecules.
/// Accepts a list of [QuickAction] data objects and renders them
/// with equal spacing.
///
/// ```dart
/// QuickActionsBar(
///   actions: [
///     QuickAction(icon: Icons.add,          label: 'Recargar', onTap: () {}),
///     QuickAction(icon: Icons.arrow_upward,  label: 'Retirar',  onTap: () {}),
///     QuickAction(icon: Icons.swap_horiz,    label: 'Cambiar',  onTap: () {}),
///   ],
/// )
/// ```
class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key, required this.actions});

  final List<QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xxl),
          QuickActionButton(
            icon: actions[i].icon,
            label: actions[i].label,
            onTap: actions[i].onTap,
          ),
        ],
      ],
    );
  }
}

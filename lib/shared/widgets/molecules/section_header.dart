import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **MOLECULE — SectionHeader**
///
/// Editorial two-line header: an uppercase [AppLabel] sub-line paired
/// with a large [headlineSmall] title. Implements the "Power vs. Precision"
/// hierarchy from the design system.
///
/// ```dart
/// SectionHeader(label: 'MERCADO', title: 'Mejores Ofertas')
/// SectionHeader(label: 'ACTIVOS', title: 'Mis Activos', trailing: TextButton(...))
/// ```
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.trailing,
  });

  final String label;
  final String title;

  /// Optional widget aligned to the end (e.g. "Ver todos" TextButton).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final labelWidget = Text(
      label.toUpperCase(),
      style: tt.labelSmall?.copyWith(
        color: AppColors.onSurfaceVariant,
        letterSpacing: 1.5,
      ),
    );

    final titleWidget = Text(title, style: tt.headlineSmall);

    if (trailing != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelWidget,
                const SizedBox(height: 4),
                titleWidget,
              ],
            ),
          ),
          trailing!,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        const SizedBox(height: 4),
        titleWidget,
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **MOLECULE — MetricItem**
///
/// A small label + value column used inside the offer metrics bar
/// (Tasa / Tiempo / Éxito). The value color is configurable to highlight
/// success rates in golden.
///
/// ```dart
/// MetricItem(label: 'Tasa',   value: '3,608 COP')
/// MetricItem(label: 'Éxito',  value: '98%', valueColor: AppColors.primaryContainer)
/// MetricItem(label: 'Tiempo', value: '~4 min', align: CrossAxisAlignment.center)
/// ```
class MetricItem extends StatelessWidget {
  const MetricItem({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = AppColors.primary,
    this.align = CrossAxisAlignment.start,
  });

  final String label;
  final String value;
  final Color valueColor;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label,
          style: tt.bodySmall?.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: tt.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

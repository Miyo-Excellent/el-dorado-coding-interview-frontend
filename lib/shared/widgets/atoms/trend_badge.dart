import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — TrendBadge**
///
/// An inline row showing a trending icon + a percentage change label.
/// Used on the Wealth Card to communicate balance movement at a glance.
///
/// ```dart
/// TrendBadge(value: '+2.4% Today')
/// TrendBadge(value: '-1.2%', isPositive: false)
/// ```
class TrendBadge extends StatelessWidget {
  const TrendBadge({
    super.key,
    required this.value,
    this.isPositive = true,
  });

  final String value;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final color = isPositive
        ? AppColors.primaryFixedDim // #C3D000 — golden dim
        : AppColors.error;
    final icon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}

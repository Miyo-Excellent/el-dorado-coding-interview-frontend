import 'package:flutter/material.dart';

/// **ATOM — AppLabel**
///
/// Uppercase sub-header text in Space Grotesk (label-sm / label-md).
/// Used to pair with large headlines creating the "Power vs. Precision"
/// editorial hierarchy from the design system.
///
/// ```dart
/// AppLabel('MERCADO')
/// AppLabel('HOY', size: AppLabelSize.md)
/// ```
enum AppLabelSize { sm, md }

class AppLabel extends StatelessWidget {
  const AppLabel(
    this.text, {
    super.key,
    this.size = AppLabelSize.sm,
    this.color,
  });

  final String text;
  final AppLabelSize size;

  /// Defaults to [Theme.of(context).colorScheme.onSurfaceVariant] for sm, [Theme.of(context).colorScheme.onSurface] for md.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final style = size == AppLabelSize.sm ? tt.labelSmall : tt.labelMedium;
    final defaultColor = size == AppLabelSize.sm
        ? Theme.of(context).colorScheme.onSurfaceVariant
        : Theme.of(context).colorScheme.onSurface;

    return Text(
      text.toUpperCase(),
      style: style?.copyWith(color: color ?? defaultColor),
    );
  }
}

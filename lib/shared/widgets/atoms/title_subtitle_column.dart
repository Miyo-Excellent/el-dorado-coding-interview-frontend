import 'package:flutter/material.dart';

/// **ATOM — TitleSubtitleColumn**
///
/// A two-line vertical column: a bold primary title + a muted subtitle.
/// Used as the center copy slot in [TransactionRow] and similar list items.
///
/// ```dart
/// TitleSubtitleColumn(title: 'Cambio USDT a COP', subtitle: 'Today, 14:30')
/// ```
class TitleSubtitleColumn extends StatelessWidget {
  const TitleSubtitleColumn({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: tt.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(subtitle, style: tt.bodySmall),
      ],
    );
  }
}

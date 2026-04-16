import 'package:flutter/material.dart';

/// **MOLECULE — SectionTitleRow**
///
/// A horizontal row with a section title on the left and an optional
/// "Ver todo" / action link on the right.
/// Used in [RecentActivityList] and similar titled sections.
///
/// ```dart
/// SectionTitleRow(title: 'Actividad Reciente', onSeeAll: () {})
/// const SectionTitleRow(title: 'Mis Activos')   // no link
/// ```
class SectionTitleRow extends StatelessWidget {
  const SectionTitleRow({
    super.key,
    required this.title,
    this.linkLabel = 'Ver todo',
    this.onSeeAll,
  });

  final String title;
  final String linkLabel;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: tt.headlineSmall),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              linkLabel,
              style: tt.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
      ],
    );
  }
}

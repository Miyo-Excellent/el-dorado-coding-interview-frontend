import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../organisms/activity_group.dart';

/// **ORGANISM — ActivityFeed**
///
/// A vertically stacked list of [ActivityGroup] organisms,
/// each separated by `AppSpacing.xl` (No-Line rule).
///
/// Encapsulates the repetitive `ActivityGroup` + `SizedBox` pattern
/// from the Activity screen's `SliverList` body.
///
/// ```dart
/// ActivityFeed(
///   groups: [
///     ActivityGroupData(
///       dateLabel: 'Hoy',
///       items: [ ActivityItem(...), ... ],
///     ),
///     ActivityGroupData(
///       dateLabel: 'Ayer',
///       items: [ ActivityItem(...), ... ],
///     ),
///   ],
/// )
/// ```
class ActivityGroupData {
  const ActivityGroupData({
    required this.dateLabel,
    required this.items,
  });

  final String dateLabel;
  final List<ActivityItem> items;
}

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({super.key, required this.groups});

  final List<ActivityGroupData> groups;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < groups.length; i++) ...[
          ActivityGroup(
            dateLabel: groups[i].dateLabel,
            items: groups[i].items,
          ),
          if (i < groups.length - 1) const SizedBox(height: AppSpacing.xl),
        ],
      ],
    );
  }
}

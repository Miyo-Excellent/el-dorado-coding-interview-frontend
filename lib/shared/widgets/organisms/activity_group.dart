import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/app_label.dart';
import '../atoms/circle_icon_container.dart';
import '../atoms/amount_column.dart';
import '../molecules/activity_title_meta.dart';

/// Data class for a single transaction displayed in [ActivityGroup].
class ActivityItem {
  const ActivityItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.amount,
    this.amountColor,
    this.secondaryAmount,
    this.iconBgColor,
    this.iconColor,
    this.strikethrough = false,
  });

  final IconData icon;
  final Color? iconBgColor;
  final Color? iconColor;
  final String title;
  final String time;
  final String status;
  final Color statusColor;
  final String amount;
  final Color? amountColor;
  final String? secondaryAmount;
  final bool strikethrough;
}

/// **ORGANISM — ActivityGroup**
///
/// A date-labelled group of activity item cards. Composed of:
/// - [AppLabel] atom — date header
/// - Per-item: [CircleIconContainer] + [ActivityTitleMeta] + [AmountColumn]
///
/// ```dart
/// ActivityGroup(
///   dateLabel: 'Hoy',
///   items: [ ActivityItem(icon: Icons.swap_horiz, title: '…', …) ],
/// )
/// ```
class ActivityGroup extends StatelessWidget {
  const ActivityGroup({
    super.key,
    required this.dateLabel,
    required this.items,
  });

  final String dateLabel;
  final List<ActivityItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ATOM: date label
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: AppLabel(dateLabel, size: AppLabelSize.sm, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        Column(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              _ActivityItemCard(data: items[i]),
              if (i < items.length - 1) const SizedBox(height: AppSpacing.md),
            ],
          ],
        ),
      ],
    );
  }
}

/// Internal atom — a single activity item card.
/// Composes: [CircleIconContainer] + [ActivityTitleMeta] + [AmountColumn].
class _ActivityItemCard extends StatelessWidget {
  const _ActivityItemCard({required this.data});

  final ActivityItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            // ATOM: leading icon circle
            child: CircleIconContainer(
              icon: data.icon,
              size: 48,
              iconSize: 22,
              bgColor: data.iconBgColor,
              iconColor: data.iconColor,
            ),
          ),
          // MOLECULE: title + time·status meta
          Expanded(
            child: ActivityTitleMeta(
              title: data.title,
              time: data.time,
              status: data.status,
              statusColor: data.statusColor,
            ),
          ),
          // ATOM: amount column
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AmountColumn(
              amount: data.amount,
              amountColor: data.amountColor,
              secondaryAmount: data.secondaryAmount,
              strikethrough: data.strikethrough,
            ),
          ),
        ],
      ),
    );
  }
}

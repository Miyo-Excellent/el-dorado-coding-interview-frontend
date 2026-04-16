import 'package:flutter/material.dart';
import '../atoms/title_subtitle_column.dart';
import '../atoms/time_status_row.dart';

/// **MOLECULE — ActivityTitleMeta**
///
/// A two-line copy column used inside an activity item card:
/// - Bold title ([TitleSubtitleColumn] top slot)
/// - [TimeStatusRow]: time + bullet + colored status
///
/// ```dart
/// ActivityTitleMeta(
///   title: 'Cambio USDT a COP',
///   time: '14:30',
///   status: 'Completado',
///   statusColor: AppColors.primary,
/// )
/// ```
class ActivityTitleMeta extends StatelessWidget {
  const ActivityTitleMeta({
    super.key,
    required this.title,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  final String title;
  final String time;
  final String status;
  final Color statusColor;

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
        const SizedBox(height: 4),
        TimeStatusRow(
          time: time,
          status: status,
          statusColor: statusColor,
        ),
      ],
    );
  }
}

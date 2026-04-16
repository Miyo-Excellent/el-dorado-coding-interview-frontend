import 'package:flutter/material.dart';

/// **ATOM — TimeStatusRow**
///
/// An inline row: time text · bullet separator · colored status text.
/// Used as the meta line under a transaction title in [ActivityGroup].
///
/// ```dart
/// TimeStatusRow(time: '14:30', status: 'Completado', statusColor: AppColors.primary)
/// TimeStatusRow(time: '09:20', status: 'Cancelado',  statusColor: AppColors.error)
/// ```
class TimeStatusRow extends StatelessWidget {
  const TimeStatusRow({
    super.key,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  final String time;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(time, style: tt.bodySmall),
        Text(' • ', style: tt.bodySmall),
        Text(
          status,
          style: tt.bodySmall?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// **ATOM — StatusDot**
///
/// A small colored dot used to indicate online/offline presence on avatars.
/// Rendered with a contrasting border that matches the card background
/// so it "floats" visually (ghost border technique).
///
/// ```dart
/// StatusDot()                        // online (green)
/// StatusDot(color: Colors.orange)    // busy
/// ```
class StatusDot extends StatelessWidget {
  const StatusDot({
    super.key,
    this.color = Colors.green,
    this.size = 10,
    this.borderColor = AppColors.surfaceContainerLow,
  });

  final Color color;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
    );
  }
}

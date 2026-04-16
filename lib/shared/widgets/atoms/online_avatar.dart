import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'status_dot.dart';

/// **ATOM — OnlineAvatar**
///
/// A circular avatar showing text initials, with an optional overlaid
/// [StatusDot] indicating online presence.
///
/// Uses the ghost-border technique: the dot border color matches the
/// parent card background to create a "floating" visual.
///
/// ```dart
/// OnlineAvatar(initials: 'G', isOnline: true)
/// OnlineAvatar(initials: 'A', isOnline: false, radius: 28)
/// ```
class OnlineAvatar extends StatelessWidget {
  const OnlineAvatar({
    super.key,
    required this.initials,
    this.isOnline = false,
    this.radius = 20,
    this.dotBorderColor = AppColors.surfaceContainerLow,
  });

  final String initials;
  final bool isOnline;
  final double radius;
  final Color dotBorderColor;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.surfaceContainerHigh,
          child: Text(
            initials,
            style: tt.titleMedium?.copyWith(color: AppColors.primary),
          ),
        ),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: StatusDot(
              color: Colors.green,
              size: radius * 0.5,
              borderColor: dotBorderColor,
            ),
          ),
      ],
    );
  }
}

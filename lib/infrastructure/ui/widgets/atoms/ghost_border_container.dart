import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// **ATOM — GhostBorderContainer**
///
/// A rounded container with `surfaceContainerLow` background and a
/// 1px ghost border at 5% white opacity (per design system ambient rule).
/// Used as a card shell in [RecentActivityList].
///
/// ```dart
/// GhostBorderContainer(
///   child: Column(children: [ ... ]),
/// )
/// ```
class GhostBorderContainer extends StatelessWidget {
  const GhostBorderContainer({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.radius,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final r = radius ?? AppRadius.lg;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

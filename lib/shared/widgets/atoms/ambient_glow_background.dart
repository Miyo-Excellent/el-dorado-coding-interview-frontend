import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — AmbientGlowBackground**
///
/// A `Positioned.fill` radial gradient overlay that adds the golden "soul"
/// to dark screen backgrounds. Must be placed inside a `Stack`.
///
/// Used in Activity and Settings screens as the hero texture layer.
/// Mirrors the design system spec:
/// > "radial-gradient(circle at top left, #deed00 0%, #131313 40%) at 5% opacity"
///
/// ```dart
/// Stack(
///   children: [
///     AmbientGlowBackground(),
///     // ... screen content
///   ],
/// )
/// ```
class AmbientGlowBackground extends StatelessWidget {
  const AmbientGlowBackground({
    super.key,
    this.alignment = Alignment.topLeft,
    this.radius = 1.0,
    this.opacity = 0.05,
  });

  final Alignment alignment;
  final double radius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: alignment,
              radius: radius,
              colors: [
                AppColors.primaryContainer.withValues(alpha: opacity),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

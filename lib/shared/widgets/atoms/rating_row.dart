import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — RatingRow**
///
/// An inline row: star emoji + rating value + bullet divider + shield icon + tier text.
/// Used inside [SellerInfo] to display reputation metadata compactly.
///
/// ```dart
/// RatingRow(rating: '5.0', tier: 'Silver Tier')
/// ```
class RatingRow extends StatelessWidget {
  const RatingRow({
    super.key,
    required this.rating,
    required this.tier,
  });

  final String rating;
  final String tier;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final mutedColor = AppColors.onSurfaceVariant;

    return Row(
      children: [
        const Text('⭐', style: TextStyle(fontSize: 10)),
        const SizedBox(width: 2),
        Text(rating, style: tt.bodySmall),
        const SizedBox(width: 6),
        Text('•', style: TextStyle(color: mutedColor, fontSize: 10)),
        const SizedBox(width: 6),
        Icon(Icons.shield_outlined, size: 10, color: mutedColor),
        const SizedBox(width: 2),
        Text(tier, style: tt.bodySmall),
      ],
    );
  }
}

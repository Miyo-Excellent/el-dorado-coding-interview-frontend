import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// **MOLECULE — AssetAmountColumn**
///
/// A right-aligned two-line column: a bold amount in Space Grotesk
/// and a muted USD equivalence below it.
/// Used in [AssetCard].
///
/// ```dart
/// AssetAmountColumn(amount: '840.50', usdValue: '≈ \$840.50')
/// ```
class AssetAmountColumn extends StatelessWidget {
  const AssetAmountColumn({
    super.key,
    required this.amount,
    required this.usdValue,
  });

  final String amount;
  final String usdValue;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          amount,
          style: tt.titleMedium?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(usdValue, style: tt.bodySmall),
      ],
    );
  }
}

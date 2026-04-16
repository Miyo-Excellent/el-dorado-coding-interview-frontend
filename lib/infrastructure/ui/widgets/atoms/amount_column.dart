import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';

/// **ATOM — AmountColumn**
///
/// A right-aligned column showing a primary amount in Space Grotesk bold
/// and an optional secondary amount below it (e.g. a currency conversion).
///
/// Supports strikethrough decoration for cancelled/failed transactions.
///
/// ```dart
/// AmountColumn(amount: '-50.00 USDT', amountColor: AppColors.primary)
/// AmountColumn(amount: '-50.00 USDT', secondaryAmount: '+195,000 COP')
/// AmountColumn(amount: '-20.00 USDC', strikethrough: true, amountColor: AppColors.secondary)
/// ```
class AmountColumn extends StatelessWidget {
  const AmountColumn({
    super.key,
    required this.amount,
    this.amountColor,
    this.secondaryAmount,
    this.strikethrough = false,
  });

  final String amount;
  final Color? amountColor;
  final String? secondaryAmount;
  final bool strikethrough;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final resolvedColor =
        amountColor ?? Theme.of(context).colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          amount,
          style: tt.titleSmall?.copyWith(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w700,
            color: resolvedColor,
            decoration: strikethrough ? TextDecoration.lineThrough : null,
            decorationColor: resolvedColor,
          ),
        ),
        if (secondaryAmount != null) ...[
          const SizedBox(height: 2),
          Text(
            secondaryAmount!,
            style: tt.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ],
    );
  }
}

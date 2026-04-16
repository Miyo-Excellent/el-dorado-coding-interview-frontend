import 'package:flutter/material.dart';

/// **ATOM — BalanceDisplay**
///
/// A [RichText] hero showing a balance amount in `displayMedium` 48px
/// paired with a muted currency suffix in `titleLarge`.
/// Used in [WealthCard].
///
/// ```dart
/// BalanceDisplay(amount: '\$1,240.50', currency: 'USD')
/// ```
class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({
    super.key,
    required this.amount,
    required this.currency,
  });

  final String amount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$amount ',
            style: tt.displayMedium?.copyWith(fontSize: 48),
          ),
          TextSpan(
            text: currency,
            style: tt.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

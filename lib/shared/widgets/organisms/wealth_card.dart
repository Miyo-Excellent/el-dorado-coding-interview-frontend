import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/balance_display.dart';
import '../atoms/ambient_glow_background.dart';
import '../atoms/trend_badge.dart';

/// **ORGANISM — WealthCard**
///
/// The "Wealth Card" — The Electric Alchemist's signature balance hero.
/// Composed of:
/// - [AmbientGlowBackground] atom — radial golden glow texture
/// - An uppercase balance label
/// - [BalanceDisplay] atom — hero amount + currency RichText
/// - [TrendBadge] atom — percentage movement indicator
///
/// ```dart
/// WealthCard(amount: '\$1,240.50', currency: 'USD', trendValue: '+2.4% Today')
/// ```
class WealthCard extends StatelessWidget {
  const WealthCard({
    super.key,
    this.balanceLabel = 'TOTAL BALANCE',
    required this.amount,
    required this.currency,
    required this.trendValue,
    this.isPositiveTrend = true,
  });

  final String balanceLabel;
  final String amount;
  final String currency;
  final String trendValue;
  final bool isPositiveTrend;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xxxl,
      ),
      decoration: AppDecorations.wealthCard,
      child: Stack(
        children: [
          // ATOM: radial golden glow texture
          AmbientGlowBackground(opacity: 0.10),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Balance label
              Text(
                balanceLabel,
                style: tt.labelSmall?.copyWith(
                  letterSpacing: 2,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // ATOM: hero balance + currency
              BalanceDisplay(amount: amount, currency: currency),
              const SizedBox(height: AppSpacing.md),
              // ATOM: trend badge
              TrendBadge(value: trendValue, isPositive: isPositiveTrend),
            ],
          ),
        ],
      ),
    );
  }
}

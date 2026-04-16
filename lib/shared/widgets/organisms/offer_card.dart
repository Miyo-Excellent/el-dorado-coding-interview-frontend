import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../atoms/payment_method_chip.dart';
import '../molecules/metric_item.dart';
import '../molecules/seller_info.dart';

/// **ORGANISM — OfferCard**
///
/// A market offer card. Composed of:
/// - [SellerInfo] molecule (avatar, username, rating, tier)
/// - A [Wrap] of [PaymentMethodChip] atoms
/// - A metrics bar ([MetricItem] molecules: Tasa / Tiempo / Éxito)
///
/// ```dart
/// OfferCard(
///   sellerInitials: 'G',
///   sellerUsername: 'glo_cop_usdt',
///   sellerRating: '5.0',
///   sellerTier: 'Silver Tier',
///   paymentMethods: ['Nequi', 'Bancolombia', 'Plin'],
///   rate: '3,608 COP',
///   time: '~4 min',
///   successRate: '98%',
///   onTap: () {},
/// )
/// ```
class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.sellerInitials,
    required this.sellerUsername,
    required this.sellerRating,
    required this.sellerTier,
    required this.paymentMethods,
    required this.rate,
    required this.time,
    required this.successRate,
    this.isSellerOnline = true,
    this.isSellerVerified = false,
    this.onTap,
  });

  final String sellerInitials;
  final String sellerUsername;
  final String sellerRating;
  final String sellerTier;
  final List<String> paymentMethods;
  final String rate;
  final String time;
  final String successRate;
  final bool isSellerOnline;
  final bool isSellerVerified;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg + 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Seller info ──────────────────────────────────────────────
            SellerInfo(
              initials: sellerInitials,
              username: sellerUsername,
              rating: sellerRating,
              tier: sellerTier,
              isOnline: isSellerOnline,
              isVerified: isSellerVerified,
            ),
            const SizedBox(height: AppSpacing.lg),
            // ── Payment methods ──────────────────────────────────────────
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: paymentMethods
                  .map((m) => PaymentMethodChip(m))
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            // ── Metrics bar ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MetricItem(label: 'Tasa', value: rate),
                  MetricItem(
                    label: 'Tiempo',
                    value: time,
                    align: CrossAxisAlignment.center,
                  ),
                  MetricItem(
                    label: 'Éxito',
                    value: successRate,
                    valueColor: Theme.of(context).colorScheme.primaryContainer,
                    align: CrossAxisAlignment.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

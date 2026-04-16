import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// **ATOM — PaymentMethodChip**
///
/// A pill-shaped label showing a payment method name (Nequi, Bancolombia…).
/// Follows the "full" border-radius token (9999px) and the No-Line rule
/// (defined by background contrast, never by a border stroke).
///
/// ```dart
/// PaymentMethodChip('Nequi')
/// PaymentMethodChip('Bancolombia')
/// ```
class PaymentMethodChip extends StatelessWidget {
  const PaymentMethodChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurface,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}

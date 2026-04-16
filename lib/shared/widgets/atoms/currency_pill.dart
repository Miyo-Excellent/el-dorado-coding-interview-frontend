import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'currency_avatar.dart';

/// **ATOM — CurrencyPill**
///
/// A pill-shaped currency selector button: [CurrencyAvatar] + code text + chevron.
/// Used inside [CurrencyRow] molecules as the tappable currency switcher.
///
/// ```dart
/// CurrencyPill(
///   color: Color(0xFF26A17B),
///   symbol: '₮',
///   code: 'USDT',
///   onTap: () {},
/// )
/// ```
class CurrencyPill extends StatelessWidget {
  const CurrencyPill({
    super.key,
    required this.color,
    required this.symbol,
    required this.code,
    this.onTap,
  });

  final Color color;
  final String symbol;
  final String code;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencyAvatar(color: color, symbol: symbol),
            const SizedBox(width: 6),
            Text(
              code,
              style: tt.titleSmall?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.expand_more,
              size: 16,
              color: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

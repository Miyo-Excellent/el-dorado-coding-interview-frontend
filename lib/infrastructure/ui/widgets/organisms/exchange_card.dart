import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/currency_row.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/molecules/swap_divider.dart';

/// **ORGANISM — ExchangeCard**
///
/// The main exchange widget. Composed of:
/// - Two [CurrencyRow] molecules (TENGO / QUIERO)
/// - A [SwapDivider] molecule (the golden swap button + ghost lines)
/// - An optional limits hint text
/// - Background signature radial glow texture
///
/// ```dart
/// ExchangeCard(
///   fromAmount: '50.00', fromCurrency: 'USDT',
///   fromColor: Color(0xFF26A17B), fromSymbol: '₮',
///   toAmount: '180,400.00', toCurrency: 'COP',
///   toColor: Color(0xFFFFD100), toSymbol: '\$',
///   limitsText: 'Límites: 1.50 – 495.00 USDT',
/// )
/// ```
class ExchangeCard extends StatelessWidget {
  const ExchangeCard({
    super.key,
    required this.fromAmount,
    required this.fromCurrency,
    required this.fromColor,
    required this.fromSymbol,
    required this.toAmount,
    required this.toCurrency,
    required this.toColor,
    required this.toSymbol,
    this.limitsText,
    this.fromAmountController,
    this.toAmountController,
    this.fromFocusNode,
    this.toFocusNode,
    this.onFromAmountChanged,
    this.onToAmountChanged,
    this.onSwap,
    this.onFromCurrencyTap,
    this.onToCurrencyTap,
  });

  final String fromAmount;
  final String fromCurrency;
  final Color fromColor;
  final String fromSymbol;
  final String toAmount;
  final String toCurrency;
  final Color toColor;
  final String toSymbol;
  final String? limitsText;
  final TextEditingController? fromAmountController;
  final TextEditingController? toAmountController;
  final FocusNode? fromFocusNode;
  final FocusNode? toFocusNode;
  final ValueChanged<String>? onFromAmountChanged;
  final ValueChanged<String>? onToAmountChanged;
  final VoidCallback? onSwap;
  final VoidCallback? onFromCurrencyTap;
  final VoidCallback? onToCurrencyTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Stack(
        children: [
          // Signature radial glow
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.2,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MOLECULE: TENGO row
                CurrencyRow(
                  label: 'TENGO',
                  amount: fromAmount,
                  currencyCode: fromCurrency,
                  currencyColor: fromColor,
                  currencySymbol: fromSymbol,
                  isInput: true,
                  amountController: fromAmountController,
                  focusNode: fromFocusNode,
                  onAmountChanged: onFromAmountChanged,
                  onCurrencyTap: onFromCurrencyTap,
                ),
                const SizedBox(height: AppSpacing.sm),
                // MOLECULE: swap divider
                SwapDivider(onSwap: onSwap),
                const SizedBox(height: AppSpacing.sm),
                // MOLECULE: QUIERO row
                CurrencyRow(
                  label: 'QUIERO',
                  amount: toAmount,
                  currencyCode: toCurrency,
                  currencyColor: toColor,
                  currencySymbol: toSymbol,
                  isInput: true,
                  amountController: toAmountController,
                  focusNode: toFocusNode,
                  onAmountChanged: onToAmountChanged,
                  onCurrencyTap: onToCurrencyTap,
                ),
                if (limitsText != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    limitsText!,
                    style: tt.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

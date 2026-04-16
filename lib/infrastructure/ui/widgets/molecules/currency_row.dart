import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/currency_pill.dart';

/// **MOLECULE — CurrencyRow**
///
/// One half of the exchange widget (TENGO / QUIERO). Combines:
/// - an uppercase label
/// - a large amount field (Expanded)
/// - a [CurrencyPill] atom as the tappable currency selector
///
/// ```dart
/// CurrencyRow(
///   label: 'TENGO',
///   amount: '50.00',
///   currencyCode: 'USDT',
///   currencyColor: Color(0xFF26A17B),
///   currencySymbol: '₮',
/// )
/// ```
class CurrencyRow extends StatelessWidget {
  const CurrencyRow({
    super.key,
    required this.label,
    required this.amount,
    required this.currencyCode,
    required this.currencyColor,
    required this.currencySymbol,
    this.isInput = false,
    this.amountController,
    this.onAmountChanged,
    this.onCurrencyTap,
  });

  final String label;
  final String amount;
  final String currencyCode;
  final Color currencyColor;
  final String currencySymbol;
  final bool isInput;
  final TextEditingController? amountController;
  final ValueChanged<String>? onAmountChanged;
  final VoidCallback? onCurrencyTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Uppercase label
        Text(
          label,
          style: tt.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Amount display
            Expanded(
              child: isInput 
                ? TextField(
                    controller: amountController,
                    onChanged: onAmountChanged,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: tt.displaySmall?.copyWith(
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                : Text(
                    amount,
                    style: tt.displaySmall?.copyWith(
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            ),
            // ATOM: currency pill selector
            CurrencyPill(
              color: currencyColor,
              symbol: currencySymbol,
              code: currencyCode,
              onTap: onCurrencyTap,
            ),
          ],
        ),
      ],
    );
  }
}

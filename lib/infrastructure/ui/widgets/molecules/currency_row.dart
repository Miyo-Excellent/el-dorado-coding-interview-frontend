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
class CurrencyRow extends StatefulWidget {
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
  State<CurrencyRow> createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: _isFocused
                ? colorScheme.primaryContainer.withValues(alpha: 0.4)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Helper Text / Uppercase label
            Text(
              widget.label,
              style: tt.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Amount display
                Expanded(
                  child: widget.isInput
                      ? TextField(
                          controller: widget.amountController,
                          onChanged: widget.onAmountChanged,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: tt.displaySmall?.copyWith(
                            fontSize: 32,
                            color: colorScheme.primary,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            filled: false,
                            hoverColor: Colors.transparent,
                          ),
                        )
                      : Text(
                          widget.amount,
                          style: tt.displaySmall?.copyWith(
                            fontSize: 32,
                            color: colorScheme.primary,
                          ),
                        ),
                ),
                // ATOM: currency pill selector
                CurrencyPill(
                  color: widget.currencyColor,
                  symbol: widget.currencySymbol,
                  code: widget.currencyCode,
                  onTap: widget.onCurrencyTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


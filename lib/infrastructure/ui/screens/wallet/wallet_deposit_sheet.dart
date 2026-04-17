import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/organisms/numeric_keypad.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/primary_button.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/currency/currency_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/payment_method/payment_method_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/payment_method/payment_method_state.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/activity/activity_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/storage/hive_storage.dart';

class WalletDepositSheet extends StatefulWidget {
  const WalletDepositSheet({super.key});

  @override
  State<WalletDepositSheet> createState() => _WalletDepositSheetState();
}

class _WalletDepositSheetState extends State<WalletDepositSheet> {
  final _amountController = TextEditingController();
  String? _selectedCurrency;

  bool _isKeypadVisible = false;
  final FocusNode _amountFocusNode = FocusNode();

  String? _selectedPaymentMethod;

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _handleKeyPress(String key) {
    final t = _amountController.text;
    final currentOffset = _amountController.selection.baseOffset;
    final offset = currentOffset >= 0 ? currentOffset : t.length;

    final prefix = t.substring(0, offset);
    final suffix = t.substring(offset);
    final newText = prefix + key + suffix;

    _amountController.text = newText;
    _amountController.selection = TextSelection.collapsed(offset: offset + key.length);
  }

  void _handleDelete() {
    final t = _amountController.text;
    if (t.isEmpty) return;

    final currentOffset = _amountController.selection.baseOffset;
    final offset = currentOffset >= 0 ? currentOffset : t.length;

    if (offset == 0) return;

    final prefix = t.substring(0, offset - 1);
    final suffix = t.substring(offset);
    final newText = prefix + suffix;

    _amountController.text = newText;
    _amountController.selection = TextSelection.collapsed(offset: offset - 1);
  }

  Future<void> _onDeposit() async {
    if (_selectedCurrency == null || _amountController.text.isEmpty) return;

    final amountStr = _amountController.text.replaceAll(',', '.');
    final amount = double.tryParse(amountStr);

    if (amount == null || amount <= 0) return;

    final newTx = {
      'id': 'tx_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'DEPOSIT',
      'currency': _selectedCurrency!,
      'paymentMethod': _selectedPaymentMethod ?? 'UNKNOWN',
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
    };

    await HiveStorage.transactions.add(newTx);
    if (mounted) {
      context.read<WalletCubit>().refresh();
      context.read<ActivityCubit>().refresh();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Recargar Wallet',
            style: tt.headlineSmall?.copyWith(
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          BlocBuilder<CurrencyCubit, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyLoaded) {
                // Combine both lists (API returns FIAT & CRYPTO separately)
                final allCurrencies = [...state.fiatCurrencies, ...state.cryptoCurrencies];
                
                // Initialize selection
                if (_selectedCurrency == null && allCurrencies.isNotEmpty) {
                  _selectedCurrency = allCurrencies.first.symbol;
                }

                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Moneda (Solo API válidas)',
                    labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                      borderSide: BorderSide(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCurrency,
                      dropdownColor: colorScheme.surfaceContainer,
                      isExpanded: true,
                      items: allCurrencies.map((c) {
                        return DropdownMenuItem<String>(
                          value: c.symbol,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(c.iconUrl),
                                backgroundColor: Colors.transparent,
                                onBackgroundImageError: (e, s) => const Icon(Icons.monetization_on, size: 12),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text('${c.symbol} - ${c.name}'),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value;
                        });
                      },
                    ),
                  ),
                );
              } else if (state is CurrencyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Text('Error loading currencies');
              }
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _amountController,
            focusNode: _amountFocusNode,
            readOnly: true,
            showCursor: true,
            onTap: () {
              _amountFocusNode.requestFocus();
              setState(() {
                _isKeypadVisible = true;
              });
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
            ],
            decoration: InputDecoration(
              labelText: 'Monto a recargar',
              labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                borderSide: BorderSide(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              prefixIcon: Icon(Icons.attach_money, color: colorScheme.primary),
            ),
            style: tt.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
            builder: (context, state) {
              if (state is PaymentMethodLoaded) {
                if (_selectedPaymentMethod == null && state.methods.isNotEmpty) {
                  _selectedPaymentMethod = state.methods.first.id;
                }
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Método de pago',
                    labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                      borderSide: BorderSide(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPaymentMethod,
                      dropdownColor: colorScheme.surfaceContainer,
                      isExpanded: true,
                      items: state.methods.map((pm) {
                        final isStar = pm.id == 'eldorado';
                        return DropdownMenuItem<String>(
                          value: pm.id,
                          child: Row(
                            children: [
                              Icon(
                                isStar ? Icons.star : Icons.payments_outlined,
                                color: isStar ? colorScheme.primary : colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                pm.name,
                                style: TextStyle(
                                  fontWeight: isStar ? FontWeight.bold : FontWeight.normal,
                                  color: isStar ? colorScheme.primary : colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedPaymentMethod = value;
                          });
                        }
                      },
                    ),
                  ),
                );
              } else if (state is PaymentMethodLoading) {
                 return const Center(child: CircularProgressIndicator());
              } else {
                 return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Confirmar Recarga',
            onPressed: _onDeposit,
          ),
          if (_isKeypadVisible)
            NumericKeypad(
              onKeyPress: _handleKeyPress,
              onDelete: _handleDelete,
              onDone: () {
                setState(() {
                  _isKeypadVisible = false;
                });
                _amountFocusNode.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}

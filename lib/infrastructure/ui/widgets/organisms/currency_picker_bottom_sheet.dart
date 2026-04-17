import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/app_theme.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/currency/currency_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/home/home_state.dart';

class CurrencyPickerBottomSheet extends StatelessWidget {
  final bool isTengo;

  const CurrencyPickerBottomSheet({super.key, required this.isTengo});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.xl, right: AppSpacing.xl),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
          ),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, homeState) {
              return BlocBuilder<CurrencyCubit, CurrencyState>(
                builder: (context, currencyState) {
                  if (currencyState is CurrencyLoading || currencyState is CurrencyInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (currencyState is CurrencyError) {
                    return Center(child: Text('Error cargando monedas', style: TextStyle(color: Theme.of(context).colorScheme.error)));
                  }

                  if (currencyState is CurrencyLoaded) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seleccionar Moneda',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Expanded(
                          child: ListView(
                            controller: scrollController,
                            children: [
                              // Category: CRYPTO
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                child: Text(
                                  'CRYPTO',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              ...currencyState.cryptoCurrencies.map((currency) {
                                // Determine if this currency is the currently selected one for this field
                                bool isSelected = false;
                                if (isTengo) {
                                  isSelected = (homeState.type == 0 && homeState.cryptoCurrency.id == currency.id);
                                } else {
                                  isSelected = (homeState.type == 1 && homeState.cryptoCurrency.id == currency.id);
                                }

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF26A17B),
                                    backgroundImage: currency.iconUrl.isNotEmpty ? NetworkImage(currency.iconUrl) : null,
                                    radius: 12,
                                    child: currency.iconUrl.isEmpty ? Text(
                                      currency.symbolShort,
                                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                    ) : null,
                                  ),
                                  title: Text(currency.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  subtitle: Text(currency.symbol),
                                  trailing: isSelected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : null,
                                  onTap: () {
                                    context.read<HomeCubit>().selectCurrency(currency, isTengo: isTengo);
                                    Navigator.of(context).pop();
                                  },
                                );
                              }),
                              const SizedBox(height: AppSpacing.md),
                              // Category: FIAT
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                child: Text(
                                  'FIAT',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              ...currencyState.fiatCurrencies.map((currency) {
                                bool isSelected = false;
                                if (isTengo) {
                                  isSelected = (homeState.type == 1 && homeState.fiatCurrency.id == currency.id);
                                } else {
                                  isSelected = (homeState.type == 0 && homeState.fiatCurrency.id == currency.id);
                                }

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFFFFD100),
                                    backgroundImage: currency.iconUrl.isNotEmpty ? NetworkImage(currency.iconUrl) : null,
                                    radius: 12,
                                    child: currency.iconUrl.isEmpty ? Text(
                                      currency.symbolShort,
                                      style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                    ) : null,
                                  ),
                                  title: Text(currency.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  subtitle: Text(currency.symbol),
                                  trailing: isSelected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : null,
                                  onTap: () {
                                    context.read<HomeCubit>().selectCurrency(currency, isTengo: isTengo);
                                    Navigator.of(context).pop();
                                  },
                                );
                              }),
                              const SizedBox(height: AppSpacing.xl),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              );
            },
          ),
        );
      },
    );
  }
}

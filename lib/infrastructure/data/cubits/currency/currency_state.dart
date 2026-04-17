part of 'currency_cubit.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object?> get props => [];
}

class CurrencyInitial extends CurrencyState {
  const CurrencyInitial();
}

class CurrencyLoading extends CurrencyState {
  const CurrencyLoading();
}

class CurrencyLoaded extends CurrencyState {
  final List<CurrencyModel> currencies;
  final List<CurrencyModel> fiatCurrencies;
  final List<CurrencyModel> cryptoCurrencies;

  const CurrencyLoaded({
    required this.currencies,
    required this.fiatCurrencies,
    required this.cryptoCurrencies,
  });

  @override
  List<Object?> get props => [currencies, fiatCurrencies, cryptoCurrencies];
}

class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError({required this.message});

  @override
  List<Object?> get props => [message];
}

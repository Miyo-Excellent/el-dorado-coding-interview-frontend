import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/models/currency_model.dart';
import '../../../../../domain/usecases/get_currencies.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetCurrenciesUseCase getCurrenciesUseCase;

  CurrencyCubit({required this.getCurrenciesUseCase}) : super(const CurrencyInitial());

  Future<void> fetchCurrencies() async {
    emit(const CurrencyLoading());
    try {
      final currencies = await getCurrenciesUseCase.execute();
      if (currencies.isEmpty) {
        emit(const CurrencyError(message: 'No currencies found.'));
      } else {
        final fiatCurrencies = currencies.where((c) => c.isFiat).toList();
        final cryptoCurrencies = currencies.where((c) => c.isCrypto).toList();
        
        emit(CurrencyLoaded(
          currencies: currencies,
          fiatCurrencies: fiatCurrencies,
          cryptoCurrencies: cryptoCurrencies,
        ));
      }
    } catch (e) {
      emit(CurrencyError(message: e.toString()));
    }
  }
}

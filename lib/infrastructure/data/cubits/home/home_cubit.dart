import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_event.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_state.dart' as ex;
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/calculate_conversion.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/validate_offer_limits.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/currency_model.dart';
import 'home_state.dart';

/// Cubit that manages the home screen UI state.
///
/// Feeds entirely from [ExchangeBloc] which polls real-time market data.
class HomeCubit extends Cubit<HomeState> {
  final ExchangeBloc exchangeBloc;
  final CalculateConversion calculateConversion;
  final ValidateOfferLimits validateOfferLimits;
  StreamSubscription<ex.ExchangeState>? _exchangeSub;

  HomeCubit({
    required this.exchangeBloc,
    required this.calculateConversion,
    required this.validateOfferLimits,
  }) : super(HomeState()) {
    // 1. Subscribe to the raw data bloc
    _exchangeSub = exchangeBloc.stream.listen((exState) {
      _syncFromExchangeState(exState);
    });
    
    // 2. Fetch initial data from current state
    fetchRecommendations();
  }

  @override
  Future<void> close() {
    _exchangeSub?.cancel();
    return super.close();
  }

  /// Commands ExchangeBloc to check the API with the current filters.
  Future<void> fetchRecommendations() async {
    exchangeBloc.add(StartPolling(
      type: state.type,
      fiatCurrencyId: state.fiatCurrency.id,
      cryptoCurrencyId: state.cryptoCurrency.id,
      amount: state.amount,
    ));
    await Future.delayed(const Duration(milliseconds: 600));
  }

  /// Syncs UI state whenever ExchangeBloc emits new polled data
  void _syncFromExchangeState(ex.ExchangeState exState) {
    if (exState.status == ex.ExchangeStatus.error) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: exState.errorMessage,
        clearOffers: true,
      ));
      return;
    }

    if (exState.status == ex.ExchangeStatus.empty) {
      emit(state.copyWith(
        status: HomeStatus.empty,
        clearOffers: true,
        convertedAmount: Decimal.zero,
      ));
      return;
    }

    if (exState.status == ex.ExchangeStatus.loaded) {
      final activeRate = _getActiveRate(exState.byPrice, exState.byReputation);
      final converted = calculateConversion(
        amount: state.amount,
        rate: activeRate,
        type: state.type,
      );

      emit(state.copyWith(
        status: HomeStatus.loaded,
        byPrice: exState.byPrice,
        byReputation: exState.byReputation,
        convertedAmount: converted,
      ));
      return;
    }

    if (exState.status == ex.ExchangeStatus.loading) {
      if (state.status != HomeStatus.loaded) {
        emit(state.copyWith(status: HomeStatus.loading));
      }
    }
  }

  double _getActiveRate(OfferModel? byP, OfferModel? byR) {
    final active = state.selectedOfferTab == 0 ? byP : byR;
    return active?.fiatToCryptoExchangeRate ?? 0;
  }

  void changeFiatCurrency(CurrencyModel fiatCurrency) {
    emit(state.copyWith(fiatCurrency: fiatCurrency));
    fetchRecommendations();
  }

  void selectCurrency(CurrencyModel currency, {required bool isTengo}) {
    int newType = state.type;
    CurrencyModel newFiat = state.fiatCurrency;
    CurrencyModel newCrypto = state.cryptoCurrency;

    if (currency.isCrypto) {
      newType = isTengo ? 0 : 1;
      newCrypto = currency;
    } else {
      newType = isTengo ? 1 : 0;
      newFiat = currency;
    }

    if (newType != state.type || newFiat.id != state.fiatCurrency.id || newCrypto.id != state.cryptoCurrency.id) {
      emit(state.copyWith(type: newType, fiatCurrency: newFiat, cryptoCurrency: newCrypto));
      fetchRecommendations();
    }
  }

  void changeAmount(String amount) {
    final activeRate = _getActiveRate(state.byPrice, state.byReputation);
    final converted = calculateConversion(
      amount: amount,
      rate: activeRate,
      type: state.type,
    );
    // Removed fetchRecommendations() to avoid continuous API calling
    emit(state.copyWith(amount: amount, convertedAmount: converted));
  }

  void changeConvertedAmount(String newConvertedObj) {
    final cleanStr = newConvertedObj.replaceAll(',', '');
    final val = Decimal.tryParse(cleanStr) ?? Decimal.zero;
    final activeRate = _getActiveRate(state.byPrice, state.byReputation);
    if (activeRate == 0) return;

    final dRate = Decimal.parse(activeRate.toString());
    Decimal newBase = Decimal.zero;

    if (state.type == 0) {
      // CRYPTO -> FIAT
      // Crypto = Fiat / Rate
      newBase = (val.toRational() / dRate.toRational()).toDecimal(scaleOnInfinitePrecision: 8);
    } else {
      // FIAT -> CRYPTO
      newBase = val * dRate;
    }

    final String newAmountStr = (state.type == 0)
        ? newBase.toStringAsFixed(8).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '')
        : newBase.toStringAsFixed(2);
    
    emit(state.copyWith(
      amount: newAmountStr,
      convertedAmount: val,
    ));
    // Removed fetchRecommendations() 
  }

  /// Toggles the exchange direction (buy/sell).
  void toggleDirection() {
    final newType = state.type == 0 ? 1 : 0;
    emit(state.copyWith(type: newType));
    fetchRecommendations();
  }

  /// Updates the selected offer tab and recalculates the conversion amount.
  void changeOfferTab(int tabIndex) {
    emit(state.copyWith(selectedOfferTab: tabIndex));

    final activeRate = _getActiveRate(state.byPrice, state.byReputation);
    final converted = calculateConversion(
      amount: state.amount,
      rate: activeRate,
      type: state.type,
    );
    emit(state.copyWith(convertedAmount: converted));
  }

}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_event.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/blocs/exchange/exchange_state.dart' as ex;
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/calculate_conversion.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/validate_offer_limits.dart';
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
  }) : super(const HomeState()) {
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
    // Stop polling when home cubit shuts down if needed or keep it global
    return super.close();
  }

  /// Commands ExchangeBloc to check the API with the current filters.
  Future<void> fetchRecommendations() async {
    exchangeBloc.add(StartPolling(
      type: state.type,
      fiatCurrencyId: state.fiatCurrencyId,
      amount: state.amount,
    ));
    // Provide brief visual feedback
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
        convertedAmount: 0,
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

    // Pass-through loading status
    if (exState.status == ex.ExchangeStatus.loading) {
      // Avoid flashing loading state if we already have valid data (silent background update)
      if (state.status != HomeStatus.loaded) {
        emit(state.copyWith(status: HomeStatus.loading));
      }
    }
  }

  /// Determine which rate to use based on the selected tab
  double _getActiveRate(OfferModel? byP, OfferModel? byR) {
    final active = state.selectedOfferTab == 0 ? byP : byR;
    return active?.fiatToCryptoExchangeRate ?? 0;
  }

  /// Updates the fiat currency.
  void changeFiatCurrency(String fiatCurrencyId) {
    emit(state.copyWith(fiatCurrencyId: fiatCurrencyId));
    fetchRecommendations();
  }

  /// Updates the input amount.
  void changeAmount(String amount) {
    emit(state.copyWith(amount: amount));
    fetchRecommendations();
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

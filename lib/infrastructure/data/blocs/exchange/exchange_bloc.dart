import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_recommendations.dart';
import 'exchange_event.dart';
import 'exchange_state.dart';

/// BLoC that continuously polls the API for exchange recommendations.
class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final GetRecommendations getRecommendations;
  
  Timer? _timer;
  
  // Cache the last requested query parameters to use on each tick
  int _lastType = 1;
  String _lastFiatCurrencyId = 'USD';
  String _lastCryptoCurrencyId = 'BTC';
  String _lastAmount = '1';

  ExchangeBloc({required this.getRecommendations})
    : super(const ExchangeState()) {
    on<FetchRecommendations>(_onFetchRecommendations);
    on<StartPolling>(_onStartPolling);
    on<StopPolling>(_onStopPolling);
    on<TimerTick>(_onTimerTick);
  }

  void _onStartPolling(StartPolling event, Emitter<ExchangeState> emit) {
    _lastType = event.type;
    _lastFiatCurrencyId = event.fiatCurrencyId;
    _lastCryptoCurrencyId = event.cryptoCurrencyId;
    _lastAmount = event.amount;

    // Immediately fetch when starting
    add(FetchRecommendations(
      type: _lastType,
      fiatCurrencyId: _lastFiatCurrencyId,
      cryptoCurrencyId: _lastCryptoCurrencyId,
      amount: _lastAmount,
    ));

    // Cancel any existing timer to avoid multiple loops
    _timer?.cancel();
    
    // Start periodic timer every 10 seconds checking the API
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      add(const TimerTick());
    });
  }

  void _onStopPolling(StopPolling event, Emitter<ExchangeState> emit) {
    _timer?.cancel();
    _timer = null;
  }

  void _onTimerTick(TimerTick event, Emitter<ExchangeState> emit) {
    add(FetchRecommendations(
      type: _lastType,
      fiatCurrencyId: _lastFiatCurrencyId,
      cryptoCurrencyId: _lastCryptoCurrencyId,
      amount: _lastAmount,
    ));
  }

  Future<void> _onFetchRecommendations(
    FetchRecommendations event,
    Emitter<ExchangeState> emit,
  ) async {
    // Only yield loading state if we don't have previous valid data,
    // otherwise the screen will flash "loading" every 10 seconds.
    if (state.status != ExchangeStatus.loaded) {
      emit(state.copyWith(status: ExchangeStatus.loading));
    }
    
    // Always store the last requested params manually fetched
    _lastType = event.type;
    _lastFiatCurrencyId = event.fiatCurrencyId;
    _lastCryptoCurrencyId = event.cryptoCurrencyId;
    _lastAmount = event.amount;

    final parsedAmount = double.tryParse(_lastAmount.replaceAll(',', '.')) ?? 0;
    if (parsedAmount <= 0) {
      emit(
        state.copyWith(
          status: ExchangeStatus.empty,
          clearOffers: true,
        ),
      );
      return;
    }

    final response = await getRecommendations(
      type: _lastType,
      cryptoCurrencyId: _lastCryptoCurrencyId,
      fiatCurrencyId: _lastFiatCurrencyId,
      amount: _lastAmount,
    );

    if (response.isError) {
      emit(
        state.copyWith(
          status: ExchangeStatus.error,
          errorMessage: response.errorMessage ?? 'Error desconocido',
          clearOffers: true,
        ),
      );
      return;
    }

    if (response.isEmpty) {
      emit(
        state.copyWith(
          status: ExchangeStatus.empty,
          clearOffers: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ExchangeStatus.loaded,
        byPrice: response.byPrice,
        byReputation: response.byReputation,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

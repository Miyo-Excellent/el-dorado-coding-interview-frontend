import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_recommendations.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';
import 'exchange_event.dart';
import 'exchange_state.dart';

/// BLoC that manages the exchange/home screen state.
///
/// Uses [GetRecommendations] use case (MVVM: ViewModel layer).
/// Reacts to user events and emits new states.
class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final GetRecommendations getRecommendations;

  ExchangeBloc({required this.getRecommendations})
    : super(const ExchangeState()) {
    on<FetchRecommendations>(_onFetchRecommendations);
    on<FiatCurrencyChanged>(_onFiatCurrencyChanged);
    on<AmountChanged>(_onAmountChanged);
    on<DirectionToggled>(_onDirectionToggled);
    on<OfferTabChanged>(_onOfferTabChanged);
  }

  Future<void> _onFetchRecommendations(
    FetchRecommendations event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(state.copyWith(status: ExchangeStatus.loading));

    final response = await getRecommendations(
      type: state.type,
      fiatCurrencyId: state.fiatCurrencyId,
      amount: state.amount,
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
          convertedAmount: 0,
        ),
      );
      return;
    }

    final converted = _calculateConversion(
      amount: state.amount,
      rate: response.byPrice!.fiatToCryptoExchangeRate,
      type: state.type,
    );

    emit(
      state.copyWith(
        status: ExchangeStatus.loaded,
        byPrice: response.byPrice,
        byReputation: response.byReputation,
        convertedAmount: converted,
      ),
    );
  }

  void _onFiatCurrencyChanged(
    FiatCurrencyChanged event,
    Emitter<ExchangeState> emit,
  ) {
    emit(state.copyWith(fiatCurrencyId: event.fiatCurrencyId));
    add(const FetchRecommendations());
  }

  void _onAmountChanged(AmountChanged event, Emitter<ExchangeState> emit) {
    emit(state.copyWith(amount: event.amount));
    add(const FetchRecommendations());
  }

  void _onDirectionToggled(
    DirectionToggled event,
    Emitter<ExchangeState> emit,
  ) {
    final newType = state.type == 0 ? 1 : 0;
    emit(state.copyWith(type: newType));
    add(const FetchRecommendations());
  }

  void _onOfferTabChanged(OfferTabChanged event, Emitter<ExchangeState> emit) {
    emit(state.copyWith(selectedOfferTab: event.tabIndex));

    // Recalculate conversion using the newly active offer's rate
    final OfferModel? activeOffer = event.tabIndex == 0
        ? state.byPrice
        : state.byReputation;
    if (activeOffer != null) {
      final converted = _calculateConversion(
        amount: state.amount,
        rate: activeOffer.fiatToCryptoExchangeRate,
        type: state.type,
      );
      emit(state.copyWith(convertedAmount: converted));
    }
  }

  double _calculateConversion({
    required String amount,
    required double rate,
    required int type,
  }) {
    final inputAmount = double.tryParse(amount) ?? 0;
    if (rate == 0) return 0;

    // CRYPTO → FIAT: fiat = crypto × rate
    // FIAT → CRYPTO: crypto = fiat / rate
    return type == 0 ? inputAmount * rate : inputAmount / rate;
  }
}

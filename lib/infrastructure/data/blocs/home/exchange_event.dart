import 'package:equatable/equatable.dart';

/// Events for [ExchangeBloc].
sealed class ExchangeEvent extends Equatable {
  const ExchangeEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch recommendations for the current pair + amount.
final class FetchRecommendations extends ExchangeEvent {
  const FetchRecommendations();
}

/// User changed the fiat currency selection.
final class FiatCurrencyChanged extends ExchangeEvent {
  final String fiatCurrencyId;
  const FiatCurrencyChanged(this.fiatCurrencyId);

  @override
  List<Object?> get props => [fiatCurrencyId];
}

/// User changed the input amount.
final class AmountChanged extends ExchangeEvent {
  final String amount;
  const AmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

/// User toggled the conversion direction (CRYPTO→FIAT ↔ FIAT→CRYPTO).
final class DirectionToggled extends ExchangeEvent {
  const DirectionToggled();
}

/// User selected a different offer tab (byPrice / byReputation).
final class OfferTabChanged extends ExchangeEvent {
  final int tabIndex;
  const OfferTabChanged(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

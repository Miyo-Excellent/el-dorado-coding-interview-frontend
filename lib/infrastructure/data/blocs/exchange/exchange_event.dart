import 'package:equatable/equatable.dart';

abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched to manually fetch immediately.
class FetchRecommendations extends ExchangeEvent {
  final int type;
  final String fiatCurrencyId;
  final String amount;

  const FetchRecommendations({
    required this.type,
    required this.fiatCurrencyId,
    required this.amount,
  });

  @override
  List<Object?> get props => [type, fiatCurrencyId, amount];
}

/// Dispatched by the Bloc's periodic timer.
class TimerTick extends ExchangeEvent {
  const TimerTick();
}

/// Starts the periodic 10-second polling.
class StartPolling extends ExchangeEvent {
  final int type;
  final String fiatCurrencyId;
  final String amount;

  const StartPolling({
    required this.type,
    required this.fiatCurrencyId,
    required this.amount,
  });

  @override
  List<Object?> get props => [type, fiatCurrencyId, amount];
}

/// Stops the periodic polling.
class StopPolling extends ExchangeEvent {
  const StopPolling();
}

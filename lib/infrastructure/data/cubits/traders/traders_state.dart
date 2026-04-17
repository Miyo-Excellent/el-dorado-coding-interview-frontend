import 'package:equatable/equatable.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';

enum TradersStatus { initial, loading, loaded, error }

class TradersState extends Equatable {
  final TradersStatus status;
  final List<OfferModel> offers;
  final String errorMessage;

  const TradersState({
    this.status = TradersStatus.initial,
    this.offers = const [],
    this.errorMessage = '',
  });

  TradersState copyWith({
    TradersStatus? status,
    List<OfferModel>? offers,
    String? errorMessage,
  }) {
    return TradersState(
      status: status ?? this.status,
      offers: offers ?? this.offers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, offers, errorMessage];
}

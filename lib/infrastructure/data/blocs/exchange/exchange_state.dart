import 'package:equatable/equatable.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/offer_model.dart';

/// Possible statuses for the exchange data fetch.
enum ExchangeStatus { initial, loading, loaded, empty, error }

/// State for [ExchangeBloc]. Contains pure data from the API.
class ExchangeState extends Equatable {
  final ExchangeStatus status;

  /// Best price offer (may be null if no data).
  final OfferModel? byPrice;

  /// Best reputation offer (may be null if no data).
  final OfferModel? byReputation;

  /// Error message (only when status == error).
  final String errorMessage;

  const ExchangeState({
    this.status = ExchangeStatus.initial,
    this.byPrice,
    this.byReputation,
    this.errorMessage = '',
  });

  ExchangeState copyWith({
    ExchangeStatus? status,
    OfferModel? byPrice,
    OfferModel? byReputation,
    String? errorMessage,
    bool clearOffers = false,
  }) {
    return ExchangeState(
      status: status ?? this.status,
      byPrice: clearOffers ? null : (byPrice ?? this.byPrice),
      byReputation: clearOffers ? null : (byReputation ?? this.byReputation),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    byPrice,
    byReputation,
    errorMessage,
  ];
}

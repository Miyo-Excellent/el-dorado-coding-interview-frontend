import 'package:equatable/equatable.dart';
import 'offer_model.dart';

/// Top-level API response wrapper.
///
/// Handles all three response cases:
/// - **Success with data:** `data.byPrice` and `data.byReputation` are present.
/// - **Empty data:** `data` is `{}` — no offers available.
/// - **Error:** `error` field is present (always HTTP 200).
class RecommendationResponse extends Equatable {
  final OfferModel? byPrice;
  final OfferModel? byReputation;
  final String? errorCode;
  final String? errorMessage;

  const RecommendationResponse({
    this.byPrice,
    this.byReputation,
    this.errorCode,
    this.errorMessage,
  });

  /// Whether the response contains valid offer data.
  bool get hasOffers => byPrice != null;

  /// Whether the response is an API error.
  bool get isError => errorCode != null;

  /// Whether the response has empty data (no liquidity).
  bool get isEmpty => !hasOffers && !isError;

  /// Factory from raw JSON map.
  factory RecommendationResponse.fromJson(Map<String, dynamic> json) {
    // Case C — Error response
    if (json.containsKey('error')) {
      final error = json['error'] as Map<String, dynamic>;
      return RecommendationResponse(
        errorCode: error['code'] as String?,
        errorMessage: error['message'] as String?,
      );
    }

    // Case A/B — Success or empty data
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null || !data.containsKey('byPrice')) {
      return const RecommendationResponse(); // Case B — empty
    }

    return RecommendationResponse(
      byPrice: OfferModel.fromJson(data['byPrice'] as Map<String, dynamic>),
      byReputation: data.containsKey('byReputation')
          ? OfferModel.fromJson(data['byReputation'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [byPrice, byReputation, errorCode, errorMessage];
}

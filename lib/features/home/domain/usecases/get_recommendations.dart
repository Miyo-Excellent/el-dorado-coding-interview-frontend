import '../../data/models/recommendation_response.dart';
import '../repositories/recommendation_repository.dart';

/// Use case: Fetch exchange rate recommendations from the P2P marketplace.
///
/// Single responsibility — encapsulates the business rule for fetching
/// recommendations with validated parameters.
class GetRecommendations {
  final RecommendationRepository repository;

  const GetRecommendations({required this.repository});

  /// Execute the use case.
  ///
  /// Returns a [RecommendationResponse] that may contain offers, be empty,
  /// or contain an error.
  Future<RecommendationResponse> call({
    required int type,
    required String fiatCurrencyId,
    required String amount,
  }) {
    return repository.getRecommendations(
      type: type,
      fiatCurrencyId: fiatCurrencyId,
      amount: amount,
    );
  }
}

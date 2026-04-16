import 'package:el_dorado_coding_interview_frontend/domain/models/recommendation_response.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/recommendation_repository.dart';

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
    String? amount,
    String? amountCurrencyId,
  }) {
    return repository.getRecommendations(
      type: type,
      fiatCurrencyId: fiatCurrencyId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );
  }
}

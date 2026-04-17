import 'package:el_dorado_coding_interview_frontend/domain/models/recommendation_response.dart';

/// Abstract repository contract for recommendations.
///
/// Part of the domain layer — implementations live in `data/`.
abstract class RecommendationRepository {
  /// Fetch rate recommendations for a currency pair.
  Future<RecommendationResponse> getRecommendations({
    required int type,
    required String fiatCurrencyId,
    required String cryptoCurrencyId,
    String? amount,
    String? amountCurrencyId,
  });
}

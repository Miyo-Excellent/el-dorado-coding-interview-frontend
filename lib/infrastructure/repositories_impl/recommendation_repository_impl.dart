import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/recommendation_remote_datasource.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/recommendation_response.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/recommendation_repository.dart';

/// Concrete implementation of [RecommendationRepository].
///
/// Delegates to [RecommendationRemoteDataSource] for API calls.
class RecommendationRepositoryImpl implements RecommendationRepository {
  final RecommendationRemoteDataSource remoteDataSource;

  const RecommendationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RecommendationResponse> getRecommendations({
    required int type,
    required String fiatCurrencyId,
    required String cryptoCurrencyId,
    String? amount,
    String? amountCurrencyId,
  }) {
    return remoteDataSource.getRecommendations(
      type: type,
      fiatCurrencyId: fiatCurrencyId,
      cryptoCurrencyId: cryptoCurrencyId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );
  }
}

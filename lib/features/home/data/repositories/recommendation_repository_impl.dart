import '../../data/datasources/recommendation_remote_datasource.dart';
import '../../data/models/recommendation_response.dart';
import '../../domain/repositories/recommendation_repository.dart';

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
    required String amount,
  }) {
    return remoteDataSource.getRecommendations(
      type: type,
      fiatCurrencyId: fiatCurrencyId,
      amount: amount,
    );
  }
}

import 'package:dio/dio.dart';
import '../models/recommendation_response.dart';

/// Remote data source for the El Dorado public recommendations API.
///
/// Wraps [Dio] calls and returns parsed [RecommendationResponse].
class RecommendationRemoteDataSource {
  final Dio dio;

  const RecommendationRemoteDataSource({required this.dio});

  static const String _endpoint = '/orderbook/public/recommendations';

  /// Fetch recommendations for a given currency pair and amount.
  ///
  /// - [type]: `0` = CRYPTO→FIAT, `1` = FIAT→CRYPTO
  /// - [fiatCurrencyId]: 'COP', 'BRL', 'PEN', 'USD', 'VES'
  /// - [amount]: positive number (as string)
  /// - [cryptoCurrencyId]: defaults to 'TATUM-TRON-USDT'
  Future<RecommendationResponse> getRecommendations({
    required int type,
    required String fiatCurrencyId,
    required String amount,
    String cryptoCurrencyId = 'TATUM-TRON-USDT',
  }) async {
    // Determine amountCurrencyId based on type
    final amountCurrencyId =
        type == 0 ? cryptoCurrencyId : fiatCurrencyId;

    try {
      final response = await dio.get(
        _endpoint,
        queryParameters: {
          'type': type,
          'cryptoCurrencyId': cryptoCurrencyId,
          'fiatCurrencyId': fiatCurrencyId,
          'amount': amount,
          'amountCurrencyId': amountCurrencyId,
        },
      );

      return RecommendationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      // Network / timeout errors
      return RecommendationResponse(
        errorCode: 'NETWORK_ERROR',
        errorMessage: e.message ?? 'Connection error',
      );
    } catch (e) {
      return RecommendationResponse(
        errorCode: 'UNKNOWN_ERROR',
        errorMessage: e.toString(),
      );
    }
  }
}

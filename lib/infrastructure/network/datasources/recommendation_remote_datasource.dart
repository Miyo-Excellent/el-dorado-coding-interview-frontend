import 'package:dio/dio.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/recommendation_response.dart';

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
    required String cryptoCurrencyId,
    String? amount,
    String? amountCurrencyId,
  }) async {
    // Map standard 'USDT' to the specific testnet ID required by this staging API.
    // Map missing cryptos (like BTC) so they don't break the staging API but can still be clicked.
    String finalCryptoId = cryptoCurrencyId;
    if (cryptoCurrencyId == 'USDT' || cryptoCurrencyId == 'TATUM-TRON-USDT') {
      finalCryptoId = 'TATUM-TRON-USDT';
    } else {
      // The staging API does not currently support any crypto other than TATUM-TRON-USDT.
      // (e.g. BITGO-BTC returns 500 INVALID_REQUEST from the server).
      // Return empty safely to mimic lack of liquidity.
      return const RecommendationResponse();
    }

    // Determine amountCurrencyId based on type if not explicitly provided
    String resolvedAmountCurrencyId = amountCurrencyId ?? (type == 0 ? finalCryptoId : fiatCurrencyId);

    try {
      final response = await dio.get(
        _endpoint,
        queryParameters: {
          'type': type,
          'cryptoCurrencyId': finalCryptoId,
          'fiatCurrencyId': fiatCurrencyId,
          if (amount != null && amount.isNotEmpty) 'amount': amount,
          'amountCurrencyId': resolvedAmountCurrencyId,
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

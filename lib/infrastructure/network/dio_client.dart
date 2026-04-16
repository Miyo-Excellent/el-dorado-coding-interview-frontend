import 'package:dio/dio.dart';

/// Singleton Dio client configured for the El Dorado public API.
///
/// Base URL: AWS API Gateway → CloudFront CDN (Europe).
/// All responses return HTTP 200 — error handling is done via JSON body.
class DioClient {
  DioClient._();

  static const String _baseUrl =
      'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage';

  static Dio? _instance;

  /// Pre-configured [Dio] instance.
  ///
  /// Timeouts tuned for the observed ~650 ms latency.
  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
        },
      ),
    )..interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
          logPrint: (obj) => obj, // silent in release; override in debug
        ),
      );
    return _instance!;
  }

  /// Reset the singleton — useful for testing.
  static void reset() {
    _instance?.close();
    _instance = null;
  }
}

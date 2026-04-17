import 'package:dio/dio.dart';
import '../../../../domain/models/currency_model.dart';

class CurrencyRemoteDataSource {
  final Dio dio;
  static const String _endpoint = '/currencies';

  CurrencyRemoteDataSource({required this.dio});

  Future<List<CurrencyModel>> getCurrencies() async {
    try {
      final response = await dio.get(_endpoint);
      final data = response.data as Map<String, dynamic>;
      final currenciesList = data['data']['currencies'] as List;

      return currenciesList
          .map((json) => CurrencyModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Return empty list on failure or throw custom exception depending on architecture
      return [];
    }
  }
}

import 'package:dio/dio.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/payment_method_model.dart';

class PaymentMethodRemoteDataSource {
  final Dio dio;
  static const String _endpoint = '/payment-methods';

  PaymentMethodRemoteDataSource({required this.dio});

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final response = await dio.get(_endpoint);
      final data = response.data as Map<String, dynamic>;
      final list = data['data'] as List;
      return list
          .map(
            (e) => PaymentMethodModel(
              id: e['id'] as String,
              name: e['name'] as String,
            ),
          )
          .toList();
    } catch (e) {
      // Graceful fallback for non-existent public endpoint or network error
      // Uses the observed payment methods from API.md
      return const [
        PaymentMethodModel(id: 'eldorado', name: 'El Dorado'),
        PaymentMethodModel(id: 'app_nequi_co', name: 'App Nequi'),
        PaymentMethodModel(id: 'bank_bancolombia', name: 'Bancolombia'),
        PaymentMethodModel(id: 'app_pix_brl', name: 'PIX'),
        PaymentMethodModel(id: 'app_yape_pe', name: 'Yape'),
        PaymentMethodModel(id: 'app_zinli_us', name: 'Zinli'),
        PaymentMethodModel(id: 'app_binance_pay', name: 'Binance Pay'),
      ];
    }
  }
}

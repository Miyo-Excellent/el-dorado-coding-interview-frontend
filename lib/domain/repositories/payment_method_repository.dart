import 'package:el_dorado_coding_interview_frontend/domain/models/payment_method_model.dart';

abstract class PaymentMethodRepository {
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

import 'package:el_dorado_coding_interview_frontend/domain/models/payment_method_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/payment_method_repository.dart';

class GetPaymentMethodsUseCase {
  final PaymentMethodRepository repository;

  GetPaymentMethodsUseCase(this.repository);

  Future<List<PaymentMethodModel>> call() async {
    return await repository.getPaymentMethods();
  }
}

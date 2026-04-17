import 'package:el_dorado_coding_interview_frontend/domain/models/payment_method_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/payment_method_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/payment_method_remote_datasource.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final PaymentMethodRemoteDataSource remoteDataSource;

  PaymentMethodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    return await remoteDataSource.getPaymentMethods();
  }
}

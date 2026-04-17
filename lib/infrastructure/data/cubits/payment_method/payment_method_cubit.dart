import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_payment_methods.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/payment_method/payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;

  PaymentMethodCubit({required this.getPaymentMethodsUseCase}) : super(PaymentMethodInitial());

  Future<void> fetchPaymentMethods() async {
    emit(PaymentMethodLoading());
    try {
      final methods = await getPaymentMethodsUseCase();
      emit(PaymentMethodLoaded(methods));
    } catch (e) {
      emit(PaymentMethodError(e.toString()));
    }
  }
}

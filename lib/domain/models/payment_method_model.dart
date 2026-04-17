import 'package:equatable/equatable.dart';

class PaymentMethodModel extends Equatable {
  final String id;
  final String name;

  const PaymentMethodModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

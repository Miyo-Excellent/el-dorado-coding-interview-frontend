import 'package:equatable/equatable.dart';

class PersonalInformationModel extends Equatable {
  final String fullName;
  final String email;
  final String phone;

  const PersonalInformationModel({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  factory PersonalInformationModel.empty() => const PersonalInformationModel(
        fullName: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+1 555-0192',
      );

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) =>
      PersonalInformationModel(
        fullName: json['fullName'] as String? ?? 'John Doe',
        email: json['email'] as String? ?? 'john.doe@example.com',
        phone: json['phone'] as String? ?? '+1 555-0192',
      );

  Map<dynamic, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phone': phone,
      };

  @override
  List<Object?> get props => [fullName, email, phone];
}

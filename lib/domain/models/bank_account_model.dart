import 'package:equatable/equatable.dart';

class BankAccountModel extends Equatable {
  final String id;
  final String bankName;
  final String alias;
  final String accountNumber;
  final String type; // e.g., Ahorros, Corriente
  final bool isDefault;
  final int colorIndex; // 0-7, maps to a palette of card gradients

  const BankAccountModel({
    required this.id,
    required this.bankName,
    required this.alias,
    required this.accountNumber,
    required this.type,
    this.isDefault = false,
    this.colorIndex = 0,
  });

  BankAccountModel copyWith({
    String? id,
    String? bankName,
    String? alias,
    String? accountNumber,
    String? type,
    bool? isDefault,
    int? colorIndex,
  }) =>
      BankAccountModel(
        id: id ?? this.id,
        bankName: bankName ?? this.bankName,
        alias: alias ?? this.alias,
        accountNumber: accountNumber ?? this.accountNumber,
        type: type ?? this.type,
        isDefault: isDefault ?? this.isDefault,
        colorIndex: colorIndex ?? this.colorIndex,
      );

  factory BankAccountModel.fromJson(Map<dynamic, dynamic> json) =>
      BankAccountModel(
        id: json['id'] as String,
        bankName: json['bankName'] as String,
        alias: json['alias'] as String,
        accountNumber: json['accountNumber'] as String,
        type: json['type'] as String,
        isDefault: json['isDefault'] as bool? ?? false,
        colorIndex: json['colorIndex'] as int? ?? 0,
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'bankName': bankName,
        'alias': alias,
        'accountNumber': accountNumber,
        'type': type,
        'isDefault': isDefault,
        'colorIndex': colorIndex,
      };

  @override
  List<Object?> get props =>
      [id, bankName, alias, accountNumber, type, isDefault, colorIndex];
}

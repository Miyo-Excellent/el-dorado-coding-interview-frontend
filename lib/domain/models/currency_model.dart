import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final String id;
  final int type; // 0 = FIAT, 1 = CRYPTO
  final String symbol;
  final String symbolShort;
  final String name;
  final String iconUrl;
  final String? cardColor;

  const CurrencyModel({
    required this.id,
    required this.type,
    required this.symbol,
    required this.symbolShort,
    required this.name,
    required this.iconUrl,
    this.cardColor,
  });

  bool get isFiat => type == 0;
  bool get isCrypto => type == 1;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as String? ?? '',
      type: json['type'] as int? ?? 0,
      symbol: json['symbol'] as String? ?? '',
      symbolShort: json['symbolShort'] as String? ?? '',
      name: json['name'] as String? ?? '',
      iconUrl: json['iconUrl'] as String? ?? '',
      cardColor: json['cardColor'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, type, symbol, symbolShort, name, iconUrl, cardColor];
}

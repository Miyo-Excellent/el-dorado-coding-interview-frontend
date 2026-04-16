import 'package:equatable/equatable.dart';
import 'offer_maker_stats_model.dart';

/// Represents a single P2P offer from the El Dorado recommendations API.
///
/// All monetary values (`fiatToCryptoExchangeRate`, limits) come as [String]
/// from the API — we parse them to [double] for calculation convenience.
class OfferModel extends Equatable {
  final String offerId;
  final String userId;
  final String username;
  final int offerStatus;
  final int offerType;
  final String createdAt;
  final String description;
  final String cryptoCurrencyId;
  final String chain;
  final String fiatCurrencyId;

  // Limits — parsed from String
  final double cryptoMaxLimit;
  final double cryptoMinLimit;
  final double cryptoMarketSize;
  final double cryptoAvailableSize;
  final double fiatMaxLimit;
  final double fiatMinLimit;
  final double fiatMarketSize;
  final double fiatAvailableSize;

  final bool isDepleted;

  /// The core exchange rate — always stored as [double] after parsing from String.
  final double fiatToCryptoExchangeRate;

  /// Raw rate string as returned by the API.
  final String fiatToCryptoExchangeRateRaw;

  final OfferMakerStatsModel? offerMakerStats;
  final List<String> paymentMethods;
  final bool paused;
  final String userStatus; // 'ONLINE' | 'OFFLINE' | 'AWAY'
  final int userLastSeen;
  final bool allowsThirdPartyPayments;
  final String visibility;
  final bool orderRequestEnabled;
  final bool offerTransactionsEnabled;
  final String escrow;

  const OfferModel({
    required this.offerId,
    required this.userId,
    required this.username,
    required this.offerStatus,
    required this.offerType,
    required this.createdAt,
    required this.description,
    required this.cryptoCurrencyId,
    required this.chain,
    required this.fiatCurrencyId,
    required this.cryptoMaxLimit,
    required this.cryptoMinLimit,
    required this.cryptoMarketSize,
    required this.cryptoAvailableSize,
    required this.fiatMaxLimit,
    required this.fiatMinLimit,
    required this.fiatMarketSize,
    required this.fiatAvailableSize,
    required this.isDepleted,
    required this.fiatToCryptoExchangeRate,
    required this.fiatToCryptoExchangeRateRaw,
    this.offerMakerStats,
    required this.paymentMethods,
    required this.paused,
    required this.userStatus,
    required this.userLastSeen,
    required this.allowsThirdPartyPayments,
    required this.visibility,
    required this.orderRequestEnabled,
    required this.offerTransactionsEnabled,
    required this.escrow,
  });

  /// Whether the seller is currently online.
  bool get isOnline => userStatus == 'ONLINE';

  /// Formatted rate for display (e.g., "3,608").
  String get formattedRate {
    if (fiatToCryptoExchangeRate >= 1000) {
      final parts = fiatToCryptoExchangeRate.toStringAsFixed(0);
      return parts.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]},',
      );
    }
    return fiatToCryptoExchangeRate.toStringAsFixed(2);
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final limits = json['limits'] as Map<String, dynamic>? ?? {};
    final crypto = limits['crypto'] as Map<String, dynamic>? ?? {};
    final fiat = limits['fiat'] as Map<String, dynamic>? ?? {};
    final rateRaw = json['fiatToCryptoExchangeRate'] as String? ?? '0';

    return OfferModel(
      offerId: json['offerId'] as String? ?? '',
      userId: user['id'] as String? ?? '',
      username: user['username'] as String? ?? '',
      offerStatus: json['offerStatus'] as int? ?? 0,
      offerType: json['offerType'] as int? ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      description: json['description'] as String? ?? '',
      cryptoCurrencyId: json['cryptoCurrencyId'] as String? ?? '',
      chain: json['chain'] as String? ?? '',
      fiatCurrencyId: json['fiatCurrencyId'] as String? ?? '',
      cryptoMaxLimit: double.tryParse(crypto['maxLimit'] as String? ?? '0') ?? 0,
      cryptoMinLimit: double.tryParse(crypto['minLimit'] as String? ?? '0') ?? 0,
      cryptoMarketSize: double.tryParse(crypto['marketSize'] as String? ?? '0') ?? 0,
      cryptoAvailableSize: double.tryParse(crypto['availableSize'] as String? ?? '0') ?? 0,
      fiatMaxLimit: double.tryParse(fiat['maxLimit'] as String? ?? '0') ?? 0,
      fiatMinLimit: double.tryParse(fiat['minLimit'] as String? ?? '0') ?? 0,
      fiatMarketSize: double.tryParse(fiat['marketSize'] as String? ?? '0') ?? 0,
      fiatAvailableSize: double.tryParse(fiat['availableSize'] as String? ?? '0') ?? 0,
      isDepleted: json['isDepleted'] as bool? ?? false,
      fiatToCryptoExchangeRate: double.tryParse(rateRaw) ?? 0,
      fiatToCryptoExchangeRateRaw: rateRaw,
      offerMakerStats: json['offerMakerStats'] != null
          ? OfferMakerStatsModel.fromJson(
              json['offerMakerStats'] as Map<String, dynamic>)
          : null,
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      paused: json['paused'] as bool? ?? false,
      userStatus: json['user_status'] as String? ?? 'OFFLINE',
      userLastSeen:
          int.tryParse(json['user_lastSeen'] as String? ?? '999') ?? 999,
      allowsThirdPartyPayments:
          json['allowsThirdPartyPayments'] as bool? ?? false,
      visibility: json['visibility'] as String? ?? 'PUBLIC',
      orderRequestEnabled: json['orderRequestEnabled'] as bool? ?? false,
      offerTransactionsEnabled: json['offerTransactionsEnabled'] as bool? ?? false,
      escrow: json['escrow'] as String? ?? 'INTERNAL_V2',
    );
  }

  @override
  List<Object?> get props => [
        offerId,
        userId,
        username,
        offerStatus,
        offerType,
        fiatToCryptoExchangeRate,
        paymentMethods,
        userStatus,
        visibility,
        escrow,
      ];
}

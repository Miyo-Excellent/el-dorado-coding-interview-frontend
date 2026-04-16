import 'package:equatable/equatable.dart';

/// Seller statistics and score data from the P2P marketplace.
class OfferMakerStatsModel extends Equatable {
  final String userId;
  final double rating;
  final double userRating;
  final double releaseTime;
  final double payTime;
  final double responseTime;
  final int totalOffersCount;
  final int totalTransactionCount;
  final int marketMakerTransactionCount;
  final int marketTakerTransactionCount;
  final int uniqueTradersCount;
  final double marketMakerOrderTime;
  final double marketMakerSuccessRatio;
  final String tierNameCode; // 'NO_TIER' | 'SILVER' | 'GOLD'
  final double mmScoreValue;
  final String userStatus;

  const OfferMakerStatsModel({
    required this.userId,
    required this.rating,
    required this.userRating,
    required this.releaseTime,
    required this.payTime,
    required this.responseTime,
    required this.totalOffersCount,
    required this.totalTransactionCount,
    required this.marketMakerTransactionCount,
    required this.marketTakerTransactionCount,
    required this.uniqueTradersCount,
    required this.marketMakerOrderTime,
    required this.marketMakerSuccessRatio,
    required this.tierNameCode,
    required this.mmScoreValue,
    required this.userStatus,
  });

  /// Human-readable tier label.
  String get tierLabel {
    switch (tierNameCode) {
      case 'GOLD':
        return 'Gold Tier';
      case 'SILVER':
        return 'Silver Tier';
      default:
        return 'Base Tier';
    }
  }

  /// Success ratio as a percentage string (e.g., "98%").
  String get successRatePercent =>
      '${(marketMakerSuccessRatio * 100).round()}%';

  /// Average order time as a display string (e.g., "~4 min").
  String get orderTimeDisplay => '~${marketMakerOrderTime.round()} min';

  factory OfferMakerStatsModel.fromJson(Map<String, dynamic> json) {
    final mmScore = json['mmScore'] as Map<String, dynamic>? ?? {};
    final tier = mmScore['tier'] as Map<String, dynamic>? ?? {};

    return OfferMakerStatsModel(
      userId: json['userId'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      userRating: (json['userRating'] as num?)?.toDouble() ?? 0,
      releaseTime: (json['releaseTime'] as num?)?.toDouble() ?? 0,
      payTime: (json['payTime'] as num?)?.toDouble() ?? 0,
      responseTime: (json['responseTime'] as num?)?.toDouble() ?? 0,
      totalOffersCount: json['totalOffersCount'] as int? ?? 0,
      totalTransactionCount: json['totalTransactionCount'] as int? ?? 0,
      marketMakerTransactionCount:
          json['marketMakerTransactionCount'] as int? ?? 0,
      marketTakerTransactionCount:
          json['marketTakerTransactionCount'] as int? ?? 0,
      uniqueTradersCount: json['uniqueTradersCount'] as int? ?? 0,
      marketMakerOrderTime:
          (json['marketMakerOrderTime'] as num?)?.toDouble() ?? 0,
      marketMakerSuccessRatio:
          (json['marketMakerSuccessRatio'] as num?)?.toDouble() ?? 0,
      tierNameCode: tier['nameCode'] as String? ?? 'NO_TIER',
      mmScoreValue: (mmScore['score'] as num?)?.toDouble() ?? 0,
      userStatus: json['user_status'] as String? ?? 'OFFLINE',
    );
  }

  @override
  List<Object?> get props => [
        userId,
        rating,
        totalTransactionCount,
        marketMakerSuccessRatio,
        tierNameCode,
        mmScoreValue,
      ];
}

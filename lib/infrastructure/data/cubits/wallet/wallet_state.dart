import 'package:equatable/equatable.dart';

/// State for the wallet screen.
class WalletState extends Equatable {
  final double totalBalanceUsd;
  final String trendText;
  final bool isPositiveTrend;
  final List<WalletAsset> assets;

  const WalletState({
    this.totalBalanceUsd = 1240.50,
    this.trendText = '+2.4% Today',
    this.isPositiveTrend = true,
    this.assets = const [],
  });

  String get formattedBalance {
    final parts = totalBalanceUsd.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return '\$$intPart.${parts[1]}';
  }

  WalletState copyWith({
    double? totalBalanceUsd,
    String? trendText,
    bool? isPositiveTrend,
    List<WalletAsset>? assets,
  }) {
    return WalletState(
      totalBalanceUsd: totalBalanceUsd ?? this.totalBalanceUsd,
      trendText: trendText ?? this.trendText,
      isPositiveTrend: isPositiveTrend ?? this.isPositiveTrend,
      assets: assets ?? this.assets,
    );
  }

  @override
  List<Object?> get props => [totalBalanceUsd, trendText, isPositiveTrend, assets];
}

/// Immutable asset entry for the wallet.
class WalletAsset extends Equatable {
  final String name;
  final String subtitle;
  final String amount;
  final String usdValue;
  final int iconColor;
  final String? iconUrl;

  const WalletAsset({
    required this.name,
    required this.subtitle,
    required this.amount,
    required this.usdValue,
    required this.iconColor,
    this.iconUrl,
  });

  @override
  List<Object?> get props => [name, amount, usdValue, iconUrl];
}

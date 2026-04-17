import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_wallet_data.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_state.dart';

/// Cubit managing wallet screen state.
///
/// Currently provides static demo data. In production, this would
/// connect to a wallet repository for real balance data.
class WalletCubit extends Cubit<WalletState> {
  final GetWalletData getWalletData;

  WalletCubit({required this.getWalletData}) : super(const WalletState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final json = await getWalletData();
      final assetsJson = json['assets'] as List<dynamic>? ?? [];
      final assets = assetsJson.map((e) => WalletAsset(
        name: e['name'] as String,
        subtitle: e['subtitle'] as String,
        amount: e['amount'] as String,
        usdValue: e['usdValue'] as String,
        iconColor: e['iconColor'] as int,
        iconUrl: e['iconUrl'] as String?,
      )).toList();

      emit(state.copyWith(
        totalBalanceUsd: json['totalBalanceUsd'] as double? ?? 0.0,
        trendText: json['trendText'] as String? ?? '',
        isPositiveTrend: json['isPositiveTrend'] as bool? ?? true,
        assets: assets,
      ));
    } catch (_) {
      // Intentionally ignoring error state for this simple implementation
    }
  }

  /// Refresh wallet balances.
  Future<void> refresh() async {
    await _loadInitialData();
  }
}

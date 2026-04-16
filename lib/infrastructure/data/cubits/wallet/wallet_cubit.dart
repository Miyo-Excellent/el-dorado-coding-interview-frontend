import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/wallet/wallet_state.dart';

/// Cubit managing wallet screen state.
///
/// Currently provides static demo data. In production, this would
/// connect to a wallet repository for real balance data.
class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(const WalletState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    emit(
      state.copyWith(
        totalBalanceUsd: 1240.50,
        trendText: '+2.4% Today',
        isPositiveTrend: true,
        assets: const [
          WalletAsset(
            name: 'USDT',
            subtitle: 'Tether',
            amount: '840.50',
            usdValue: '≈ \$840.50',
            iconColor: 0xFF26A17B,
          ),
          WalletAsset(
            name: 'COP',
            subtitle: 'Peso Colombiano',
            amount: '1,440,000',
            usdValue: '≈ \$400.00',
            iconColor: 0xFFFFD100,
          ),
        ],
      ),
    );
  }

  /// Refresh wallet balances.
  void refresh() {
    _loadInitialData();
  }
}

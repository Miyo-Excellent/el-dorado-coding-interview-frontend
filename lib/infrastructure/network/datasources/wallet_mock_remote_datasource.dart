import '../../../../infrastructure/storage/hive_storage.dart';

/// Simulates a remote data source fetching the user's wallet balances.
///
/// In a real environment, this would use Dio to fetch from the backend.
/// For the interview/demo, it returns static dummy data mapped into models.
class WalletMockRemoteDataSource {
  const WalletMockRemoteDataSource();

  Future<Map<String, dynamic>> fetchWalletData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    double usdtBase = 840.50;
    double copBase = 1440000.00;
    double vesBase = 0.00;

    // Apply local transactions
    final txs = HiveStorage.transactions.values.toList();
    for (final rawTx in txs) {
      final tx = Map<String, dynamic>.from(rawTx);
      final type = tx['type'].toString();
      final fiatSymbol = tx['fiatSymbol']?.toString() ?? 'COP';
      
      final double amt = double.tryParse(tx['amount'].toString()) ?? 0.0;
      final double convAmt = double.tryParse(tx['convertedAmount'].toString()) ?? 0.0;

      if (type == 'SELL_CRYPTO') {
        usdtBase -= amt;
        if (fiatSymbol == 'COP') copBase += convAmt;
        if (fiatSymbol == 'VES') vesBase += convAmt;
      } else if (type == 'BUY_CRYPTO') {
        usdtBase += convAmt;
        if (fiatSymbol == 'COP') copBase -= amt;
        if (fiatSymbol == 'VES') vesBase -= amt;
      }
    }

    // Define approximate USD equivalent ratios
    final double copToUsdRaw = copBase / 3600.0; // Simulated peg
    final double vesToUsdRaw = vesBase / 36.0;   // Simulated peg

    final List<Map<String, dynamic>> assets = [];
    
    // Always include USDT and COP. Only include VES if > 0 or if there are transactions.
    assets.add({
      'name': 'USDT',
      'subtitle': 'Tether',
      'amount': usdtBase.toStringAsFixed(2),
      'usdValue': '≈ \$${usdtBase.toStringAsFixed(2)}',
      'iconColor': 0xFF26A17B,
    });

    assets.add({
      'name': 'COP',
      'subtitle': 'Peso Colombiano',
      'amount': copBase.toStringAsFixed(2),
      'usdValue': '≈ \$${copToUsdRaw.toStringAsFixed(2)}',
      'iconColor': 0xFFFFD100,
    });

    if (vesBase != 0.0) {
      assets.add({
        'name': 'VES',
        'subtitle': 'Bolívar Venezolano',
        'amount': vesBase.toStringAsFixed(2),
        'usdValue': '≈ \$${vesToUsdRaw.toStringAsFixed(2)}',
        'iconColor': 0xFFFF2000,
      });
    }

    final double totalBalance = usdtBase + copToUsdRaw + vesToUsdRaw;
    
    return {
      'totalBalanceUsd': totalBalance,
      'trendText': '+2.4% Today',
      'isPositiveTrend': true,
      'assets': assets,
    };
  }
}

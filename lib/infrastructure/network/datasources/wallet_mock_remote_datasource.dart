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

    Map<String, double> balances = {
      'USDT': 840.50,
      'COP': 1440000.00,
    };

    // Apply local transactions
    final txs = HiveStorage.transactions.values.toList();
    for (final rawTx in txs) {
      final tx = Map<String, dynamic>.from(rawTx);
      final type = tx['type'].toString();
      final fiatSymbol = tx['fiatSymbol']?.toString() ?? 'COP';
      
      final double amt = double.tryParse(tx['amount'].toString()) ?? 0.0;
      final double convAmt = double.tryParse(tx['convertedAmount'].toString()) ?? 0.0;

      if (type == 'SELL_CRYPTO') {
        balances['USDT'] = (balances['USDT'] ?? 0) - amt;
        balances[fiatSymbol] = (balances[fiatSymbol] ?? 0) + convAmt;
      } else if (type == 'BUY_CRYPTO') {
        balances['USDT'] = (balances['USDT'] ?? 0) + convAmt;
        balances[fiatSymbol] = (balances[fiatSymbol] ?? 0) - amt;
      } else if (type == 'DEPOSIT') {
        final currencySymbol = tx['currency']?.toString() ?? 'COP';
        balances[currencySymbol] = (balances[currencySymbol] ?? 0) + amt;
      }
    }

    // Define approximate USD equivalent ratios for mock logic
    double getUsdRatio(String sym) {
      if (sym == 'USDT' || sym == 'USD' || sym == 'USDC') return 1.0;
      if (sym == 'COP') return 1 / 3600.0;
      if (sym == 'VES') return 1 / 36.0;
      if (sym == 'BTC') return 60000.0;
      if (sym == 'ETH') return 3000.0;
      return 0.5; // fallback ratio
    }

    final List<Map<String, dynamic>> assets = [];
    double totalBalanceUsd = 0.0;
    
    balances.forEach((symbol, balance) {
      if (balance > 0 || symbol == 'USDT' || symbol == 'COP') {
        final ratio = getUsdRatio(symbol);
        final usdVal = balance * ratio;
        totalBalanceUsd += usdVal;

        int color = 0xFF26A17B; // default
        String? iconUrl;
        
        if (symbol == 'USDT') {
          color = 0xFF31A383;
          iconUrl = 'https://cdn.eldorado.io/api/assets/crypto_currencies/currency_usdt.png';
        } else if (symbol == 'COP') {
          color = 0xFFFFD100;
          iconUrl = 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_cop.png';
        } else if (symbol == 'VES') {
          color = 0xFFFF2000;
          iconUrl = 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_ves.png';
        } else if (symbol == 'BTC') {
          color = 0xFFFF8300;
          iconUrl = 'https://cdn.eldorado.io/api/assets/crypto_currencies/currency_btc.png';
        } else if (symbol == 'ETH') {
          color = 0xFF627EEA;
          iconUrl = 'https://cdn.eldorado.io/api/assets/crypto_currencies/currency_eth.png';
        } else if (symbol == 'USDC') {
          color = 0xFF2196F3;
          iconUrl = 'https://cdn.eldorado.io/api/assets/crypto_currencies/currency_usdc.png';
        } else if (symbol == 'ARS') {
          color = 0xFF2196F3; // Default blueish
          iconUrl = 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_ars.png';
        } else if (symbol == 'PEN') {
          color = 0xFFE53935; // Default redish
          iconUrl = 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_pen.png';
        } else if (symbol == 'BRL') {
          color = 0xFF4CAF50; // Default green
          iconUrl = 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_brl.png';
        } else if (symbol == 'USD') {
          color = 0xFF26A17B;
          iconUrl = 'https://cdn.eldorado.io/api/assets/fiat_currencies/currency_usd.png';
        }

        assets.add({
          'name': symbol,
          'subtitle': 'Billetera $symbol',
          'amount': balance.toStringAsFixed(2),
          'usdValue': '≈ \$${usdVal.toStringAsFixed(2)}',
          'iconColor': color,
          'iconUrl': iconUrl,
        });
      }
    });

    return {
      'totalBalanceUsd': totalBalanceUsd,
      'trendText': '+2.4% Today',
      'isPositiveTrend': true,
      'assets': assets,
    };
  }
}

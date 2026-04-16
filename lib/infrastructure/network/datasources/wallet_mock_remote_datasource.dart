/// Simulates a remote data source fetching the user's wallet balances.
///
/// In a real environment, this would use Dio to fetch from the backend.
/// For the interview/demo, it returns static dummy data mapped into models.
class WalletMockRemoteDataSource {
  const WalletMockRemoteDataSource();

  Future<Map<String, dynamic>> fetchWalletData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Return dummy JSON response
    return {
      'totalBalanceUsd': 1240.50,
      'trendText': '+2.4% Today',
      'isPositiveTrend': true,
      'assets': [
        {
          'name': 'USDT',
          'subtitle': 'Tether',
          'amount': '840.50',
          'usdValue': '≈ \$840.50',
          'iconColor': 0xFF26A17B,
        },
        {
          'name': 'COP',
          'subtitle': 'Peso Colombiano',
          'amount': '1,440,000',
          'usdValue': '≈ \$400.00',
          'iconColor': 0xFFFFD100,
        },
      ]
    };
  }
}

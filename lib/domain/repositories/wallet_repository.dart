/// Interface for Wallet repository.
abstract class WalletRepository {
  Future<Map<String, dynamic>> getWalletData();
}

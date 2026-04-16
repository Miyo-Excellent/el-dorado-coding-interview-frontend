import 'package:el_dorado_coding_interview_frontend/domain/repositories/wallet_repository.dart';

class GetWalletData {
  final WalletRepository repository;

  const GetWalletData(this.repository);

  Future<Map<String, dynamic>> call() {
    return repository.getWalletData();
  }
}

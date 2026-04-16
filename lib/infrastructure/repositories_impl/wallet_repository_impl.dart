import 'package:el_dorado_coding_interview_frontend/domain/repositories/wallet_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/wallet_mock_remote_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletMockRemoteDataSource dataSource;

  const WalletRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getWalletData() {
    return dataSource.fetchWalletData();
  }
}

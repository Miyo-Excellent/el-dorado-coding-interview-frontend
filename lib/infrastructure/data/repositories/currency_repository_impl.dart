import '../../../../domain/models/currency_model.dart';
import '../../../../domain/repositories/currency_repository.dart';
import '../../network/datasources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    return await remoteDataSource.getCurrencies();
  }
}

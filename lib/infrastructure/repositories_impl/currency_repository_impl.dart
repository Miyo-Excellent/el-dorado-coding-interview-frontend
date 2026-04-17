import 'package:el_dorado_coding_interview_frontend/domain/models/currency_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/currency_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    return await remoteDataSource.getCurrencies();
  }
}

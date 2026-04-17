import '../models/currency_model.dart';
import '../repositories/currency_repository.dart';

class GetCurrenciesUseCase {
  final CurrencyRepository repository;

  GetCurrenciesUseCase(this.repository);

  Future<List<CurrencyModel>> execute() async {
    return await repository.getCurrencies();
  }
}

import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/bank_account_repository.dart';

class GetBankAccountsUseCase {
  final BankAccountRepository repository;

  GetBankAccountsUseCase(this.repository);

  Future<List<BankAccountModel>> call() {
    return repository.getBankAccounts();
  }
}

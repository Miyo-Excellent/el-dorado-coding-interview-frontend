import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/bank_account_repository.dart';

class AddBankAccountUseCase {
  final BankAccountRepository repository;

  AddBankAccountUseCase(this.repository);

  Future<void> call(BankAccountModel account) {
    return repository.addBankAccount(account);
  }
}

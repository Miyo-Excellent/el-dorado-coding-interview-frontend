import 'package:el_dorado_coding_interview_frontend/domain/repositories/bank_account_repository.dart';

class DeleteBankAccountUseCase {
  final BankAccountRepository repository;

  DeleteBankAccountUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteBankAccount(id);
  }
}

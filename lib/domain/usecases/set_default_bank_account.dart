import 'package:el_dorado_coding_interview_frontend/domain/repositories/bank_account_repository.dart';

class SetDefaultBankAccountUseCase {
  final BankAccountRepository repository;

  SetDefaultBankAccountUseCase({required this.repository});

  Future<void> call(String id) => repository.setDefaultAccount(id);
}

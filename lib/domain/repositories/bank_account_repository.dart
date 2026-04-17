import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';

abstract class BankAccountRepository {
  Future<List<BankAccountModel>> getBankAccounts();
  Future<void> addBankAccount(BankAccountModel account);
  Future<void> deleteBankAccount(String id);
  Future<void> setDefaultAccount(String id);
}

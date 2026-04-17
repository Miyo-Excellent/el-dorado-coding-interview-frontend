import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/repositories/bank_account_repository.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/network/datasources/bank_account_local_datasource.dart';

class BankAccountRepositoryImpl implements BankAccountRepository {
  final BankAccountLocalDataSource localDataSource;

  BankAccountRepositoryImpl({required this.localDataSource});

  @override
  Future<List<BankAccountModel>> getBankAccounts() {
    return localDataSource.getBankAccounts();
  }

  @override
  Future<void> addBankAccount(BankAccountModel account) {
    return localDataSource.addBankAccount(account);
  }

  @override
  Future<void> deleteBankAccount(String id) {
    return localDataSource.deleteBankAccount(id);
  }

  @override
  Future<void> setDefaultAccount(String id) {
    return localDataSource.setDefaultAccount(id);
  }
}

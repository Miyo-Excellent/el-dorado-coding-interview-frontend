import 'dart:convert';
import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/storage/hive_storage.dart';

abstract class BankAccountLocalDataSource {
  Future<List<BankAccountModel>> getBankAccounts();
  Future<void> addBankAccount(BankAccountModel account);
  Future<void> deleteBankAccount(String id);
  Future<void> setDefaultAccount(String id);
}

class BankAccountLocalDataSourceImpl implements BankAccountLocalDataSource {
  static const String _banksKey = 'user_banks';

  @override
  Future<List<BankAccountModel>> getBankAccounts() async {
    final data = HiveStorage.banks.get(_banksKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data as String);
      return jsonList
          .map((e) => BankAccountModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> addBankAccount(BankAccountModel account) async {
    final currentList = await getBankAccounts();
    currentList.add(account);
    await _persist(currentList);
  }

  @override
  Future<void> deleteBankAccount(String id) async {
    final currentList = await getBankAccounts();
    currentList.removeWhere((e) => e.id == id);
    await _persist(currentList);
  }

  @override
  Future<void> setDefaultAccount(String id) async {
    final currentList = await getBankAccounts();
    final updated = currentList.map((acct) {
      return acct.copyWith(isDefault: acct.id == id);
    }).toList();
    await _persist(updated);
  }

  Future<void> _persist(List<BankAccountModel> list) async {
    final String jsonString =
        jsonEncode(list.map((e) => e.toJson()).toList());
    await HiveStorage.banks.put(_banksKey, jsonString);
  }
}

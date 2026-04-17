import 'package:equatable/equatable.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_bank_accounts.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/add_bank_account.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/delete_bank_account.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/set_default_bank_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BankAccountState extends Equatable {
  const BankAccountState();

  @override
  List<Object> get props => [];
}

class BankAccountInitial extends BankAccountState {}

class BankAccountLoading extends BankAccountState {}

class BankAccountLoaded extends BankAccountState {
  final List<BankAccountModel> accounts;

  const BankAccountLoaded(this.accounts);

  @override
  List<Object> get props => [accounts];
}

class BankAccountError extends BankAccountState {
  final String message;

  const BankAccountError(this.message);

  @override
  List<Object> get props => [message];
}

class BankAccountCubit extends Cubit<BankAccountState> {
  final GetBankAccountsUseCase getBankAccountsUseCase;
  final AddBankAccountUseCase addBankAccountUseCase;
  final DeleteBankAccountUseCase deleteBankAccountUseCase;
  final SetDefaultBankAccountUseCase setDefaultBankAccountUseCase;

  BankAccountCubit({
    required this.getBankAccountsUseCase,
    required this.addBankAccountUseCase,
    required this.deleteBankAccountUseCase,
    required this.setDefaultBankAccountUseCase,
  }) : super(BankAccountInitial());

  Future<void> fetchAccounts() async {
    try {
      emit(BankAccountLoading());
      final accounts = await getBankAccountsUseCase();
      emit(BankAccountLoaded(accounts));
    } catch (e) {
      emit(BankAccountError(e.toString()));
    }
  }

  Future<void> addAccount(BankAccountModel account) async {
    try {
      emit(BankAccountLoading());
      await addBankAccountUseCase(account);
      final accounts = await getBankAccountsUseCase();
      emit(BankAccountLoaded(accounts));
    } catch (e) {
      emit(BankAccountError(e.toString()));
    }
  }

  Future<void> deleteAccount(String id) async {
    try {
      emit(BankAccountLoading());
      await deleteBankAccountUseCase(id);
      final accounts = await getBankAccountsUseCase();
      emit(BankAccountLoaded(accounts));
    } catch (e) {
      emit(BankAccountError(e.toString()));
    }
  }

  Future<void> setDefault(String id) async {
    try {
      await setDefaultBankAccountUseCase(id);
      final accounts = await getBankAccountsUseCase();
      emit(BankAccountLoaded(accounts));
    } catch (e) {
      emit(BankAccountError(e.toString()));
    }
  }
}

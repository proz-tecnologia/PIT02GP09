import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class TransactionsBloc extends Bloc<TransactionsPageEvent, TransactionsPageState> {
  final TransactionsPageRepository repository;
  final String? id;
  UserModel? userModel;

  TransactionsBloc(
    {required this.repository,
     required this.id,
     this.userModel,}
  ) : super(TransactionsPageStateEmpty()) {
    log('transactions page bloc created');
    on<OnTransactionsInitState>(getUserData);
  }

  Future<void> getUserData(
    TransactionsPageEvent event,
    Emitter<TransactionsPageState> emitter) async {
    try {
      emitter(TransactionsPageStateLoading());      
      final categories = Modular.get<HomeBloc>().userModel!.categories;
      final userModel = await repository.getUserData(userID: id!);
      List<FinancialTransaction>? transactions = [];
      if (categories.isNotEmpty) {
        transactions = await repository.getTransactions(userID: id!, categories: categories);
      } else {
        log(transactions.runtimeType.toString());
        transactions = await repository.getTransactions(userID: id!);
        log(transactions.runtimeType.toString());
      }

      if (transactions!.isNotEmpty) {
        emitter(TransactionsPageStateSuccess(user: userModel,
                                             transactions: transactions));
      } else {
        emitter(TransactionsPageStateEmpty());
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(TransactionsPageStateError(erro: e));
    }
  }

}
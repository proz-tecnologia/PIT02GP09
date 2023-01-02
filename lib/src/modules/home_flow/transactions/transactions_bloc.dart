
import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_state.dart';
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
    log(id.toString());
    on<OnTransactionsPageEmpty>(getUserData);
  }

  Future<void> getUserData(TransactionsPageEvent event, Emitter<TransactionsPageState> emitter) async {
    try {
      emitter(TransactionsPageStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      final transactions = await repository.getTransactions(userID: id!);

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
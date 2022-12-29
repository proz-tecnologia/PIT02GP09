
import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class CreateTransactionBloc extends Bloc<CreateTransactionEvent, CreateTransactionState> {

  final CreateTransactionRepository repository;
  final String? _id;
  UserModel userModel;
  
  CreateTransactionBloc(
    this.repository,
    this._id,
    this.userModel,
  ) : super(CreateTransactionStateEmpty()) {
    log('Create Transaction bloc created');
    on<OnNewTransaction>(createTransaction);
  }

  Future<void> createTransaction(
    CreateTransactionEvent event, 
    Emitter<CreateTransactionState> emitter,
  ) async {
    try {
      emitter(CreateTransactionStateLoading());

      log(event.newTransaction!.value.toString());
      log(userModel.userModelDocID.toString());

      final transaction = event.newTransaction;
      final updatedTransaction = transaction!.copyWith(userID: _id);

      UserModel? myUser;

      await repository.createTransaction(transaction: updatedTransaction);

      if (transaction.type == TransactionTypes.expense) {
        myUser = userModel.copyWith(balance: userModel.balance - updatedTransaction.value);
      } else if (transaction.type == TransactionTypes.receive) { // n usar "else" p facilitar futura adapt p novos tipos
        myUser = userModel.copyWith(balance: userModel.balance + updatedTransaction.value);
      }

      log(myUser!.balance.toString());
      log(myUser.userModelDocID.toString());

      Modular.get<HomeBloc>().userModel = myUser;

      // atualizar usuario no Firebase
      await repository.updateBalance(userModel: myUser);

      emitter(CreateTransactionStateSuccess(userModel: myUser));
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreateTransactionError(erro: e));
    }

  }

}
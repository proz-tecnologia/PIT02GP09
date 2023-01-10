import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

class CreateTransactionBloc extends Bloc<CreateTransactionEvent, CreateTransactionState> {

  final CreateTransactionRepository repository;
  final String? _id;
  UserModel userModel;
  
  CreateTransactionBloc(
    this.repository,
    this._id,
    this.userModel,
  ) : super(CreateTransactionStateNoWallets()) {
    log('Create Transaction bloc created');
    on<OnInitState>(getUserData);
    on<OnNewTransaction>(createTransaction);
  }

  Future<void> getUserData(
    CreateTransactionEvent event,
    Emitter<CreateTransactionState> emitter) async {
    try {
      emitter(CreateTransactionStateLoading());
      final userModel = await repository.getUserData(userID: _id!);
      List<WalletModel>? wallets = await repository.getWallets(userID: _id!);      

      if (wallets.isNotEmpty) {
        log(wallets.length.toString());
        emitter(CreateTransactionStateEmpty(userModel: userModel, wallets: wallets));
      } else {
        log('sem carteiras');
        emitter(CreateTransactionStateNoWallets());
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreateTransactionError(erro: e));
    }
  }

  Future<void> createTransaction(    
    CreateTransactionEvent event, 
    Emitter<CreateTransactionState> emitter 
  ) async {
    try {
      emitter(CreateTransactionStateLoading());

      List<WalletModel>? wallets = await repository.getWallets(userID: _id!);

      if (wallets.isNotEmpty) {
        log(wallets.length.toString());

        // criar transacao --------------------------------------------------------------------
        final transaction = event.newTransaction;
        final updatedTransaction = transaction!.copyWith(userID: _id);      

        await repository.createTransaction(transaction: updatedTransaction);

        // atualizar usuario ------------------------------------------------------------------
        UserModel? myUser;

        if (transaction.type == TransactionTypes.expense) {
          myUser = userModel.copyWith(balance: userModel.balance - updatedTransaction.value);
        } else if (transaction.type == TransactionTypes.receive) { // n usar "else" p facilitar futura adapt p novos tipos
          myUser = userModel.copyWith(balance: userModel.balance + updatedTransaction.value);
        }

        await repository.updateBalance(userModel: myUser!);

        if (transaction.category != null &&
            !userModel.categories.contains(transaction.category)) {
          myUser.categories.add(transaction.category!);
          await repository.createCategory(newCategory: transaction.category!, userModel: myUser);
        }
        
       await updatePages(myUser);

       // emitter(CreateTransactionStateSuccess());
      } else {
        log('sem carteiras');
        emitter(CreateTransactionStateNoWallets());
      }     
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreateTransactionError(erro: e));
    }
  }

  Future<void> updatePages(UserModel myUser) async {
    Modular.get<HomeBloc>().userModel = myUser;
    Modular.get<HomeBloc>().add(OnHomePageEmpty());
    Modular.get<TransactionsBloc>().add(OnTransactionsInitState());
  }

}
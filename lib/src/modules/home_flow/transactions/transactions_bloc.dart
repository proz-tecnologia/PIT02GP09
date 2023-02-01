import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

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
    on<OnTransactionsDelete>(deleteTransaction);
  }

  Future<void> getUserData(
    TransactionsPageEvent event,
    Emitter<TransactionsPageState> emitter) async {
    try {
      emitter(TransactionsPageStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      List<FinancialTransaction>? transactions = [];
      if (event.categories != null &&
          event.categories!.isNotEmpty) {
        transactions = await repository.getTransactions(userID: id!, categories: event.categories);
      } else {
        transactions = await repository.getTransactions(userID: id!);
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

  Future<void> deleteTransaction(
    TransactionsPageEvent event,
    Emitter<TransactionsPageState> emitter
    ) async {
      log('funcao deleteTransaction chamada');
      try {
        emitter(TransactionsPageStateLoading());

        final transactions = await repository.getTransactions(userID: id!);
        final userModel = await repository.getUserData(userID: id!);

        int count = 0; // contagem de transacoes da mesma categoria

        for (int i=0; i < transactions!.length; i++) {
          if (transactions[i].category == event.transaction!.category!) {
            count += 1;
          }
        }

        // deletar transacao ------------------------------------------------------------------
        final transactionDocID = event.transaction!.id;
        await repository.deleteTransaction(docID: transactionDocID!);

        // atualizar carteira -----------------------------------------------------------------
        double value = 0;
        List<WalletModel>? wallets = await repository.getWallets(userID: id!);

        for (int i=0; i < wallets.length; i++) {
          if (wallets[i].id == event.transaction!.walletID) {
            if (event.transaction!.type == TransactionTypes.receive) {
              value = wallets[i].value -= event.transaction!.value;
            } else {
              value = wallets[i].value += event.transaction!.value;
            }
          }

        }
        await repository.updateWallet(walletID: event.transaction!.walletID, value: value);

        // atualizar usuario ------------------------------------------------------------------ 
        UserModel myUser = userModel;
        //final updatedTransactions = await repository.getTransactions(userID: id!);
        double updatedBalance = 0;

        for (int i=0; i < wallets.length; i++) {
          updatedBalance += wallets[i].value;
        }
        log(updatedBalance.toString());
        myUser = myUser.copyWith(balance: updatedBalance);            

        await repository.updateBalance(userModel: myUser);

        // atualizar categorias ---------------------------------------------------------------
        log(count.toString());

        log(event.transaction!.category!);
        log(userModel.categories.toString());
        if (event.transaction!.category != null &&
            userModel.categories.contains(event.transaction!.category) &&
            count == 1) {
          log('passou');
          myUser.categories.remove(event.transaction!.category!);
          await repository.deleteCategory(category: event.transaction!.category!, userModel: myUser);
        }                
        
        await updatePages(myUser);

        emitter(TransactionsPageStateUpdate());
        
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
        emitter(TransactionsPageStateError(erro: e));
      }
    }

  Future<void> updatePages(UserModel myUser) async {
    Modular.get<HomeBloc>().userModel = myUser;
    Modular.get<HomeBloc>().add(OnHomePageEmpty());
    Modular.get<TransactionsBloc>().add(OnTransactionsInitState());
  }

}
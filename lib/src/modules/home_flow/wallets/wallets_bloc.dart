import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsPageState> {

  final WalletsRepository repository;
  final String? id;
  UserModel? userModel;

  WalletsBloc(
    {required this.repository,
     required this.id,
     this.userModel,}
  ) : super(WalletsPageStateEmpty()) {
    log('wallets page bloc created');
    on<OnWalletsPageEmpty>(getUserData);
    on<OnWalletsPageSuccess>(getUserData);
    on<OnWalletsDelete>(deleteWallet);
  }

  Future<void> getUserData(
    WalletsEvent event,
    Emitter<WalletsPageState> emitter) async {
    try {
      emitter(WalletsPageStateLoading());
      final userModel = await repository.getUserData(userID: id!);
      List<WalletModel>? wallets = await repository.getWallets(userID: id!);      

      if (wallets != null && wallets.isNotEmpty) {
        log(wallets.length.toString());
        emitter(WalletsPageStateSuccess(user: userModel,
                                    wallets: wallets));
      } else {
        log('sem carteiras');
        emitter(WalletsPageStateEmpty());
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(WalletsPageStateError(erro: e));
    }
  }

  Future<void> deleteWallet(
    WalletsEvent event,
    Emitter<WalletsPageState> emitter
    ) async {
      log('funcao deleteWallet chamada');
      try {
        emitter(WalletsPageStateLoading());
        
        final userModel = await repository.getUserData(userID: id!);
        UserModel myUser = userModel;
        final walletDocID = event.wallet!.id;        
        final transactions = await repository.getTransactions(userID: id!, walletID: walletDocID!) ;

        // deletar carteira e suas transacoes -----------------------------------------------------------
        await repository.deleteWallet(docID: walletDocID);
        
        if (transactions != null && transactions.isNotEmpty) {
          for (int i=0; i < transactions.length; i++) {
            int count = 0; // contagem de transacoes da mesma categoria
            for (int j=0; j < transactions.length; j++) {
                if (transactions[i].category == transactions[j].category!) {
                  count += 1;
                }
            }
            // atualizar categorias
            if (count == 1) {
              myUser.categories.remove(transactions[i].category!);
              await repository.deleteCategory(category: transactions[i].category!, userModel: myUser);
            }

            await repository.deleteTransaction(docID: transactions[i].id!);
          }
        }

        // atualizar usuario ----------------------------------------------------------------------------        
        List<WalletModel>? wallets = await repository.getWallets(userID: id!);
        double updatedBalance = 0;

        if (wallets != null && wallets.isNotEmpty) {
          for (int i=0; i < wallets.length; i++) {
            updatedBalance += wallets[i].value;
          }
        }

        myUser = myUser.copyWith(balance: updatedBalance);            

        await repository.updateBalance(userModel: myUser);
        
        await updatePages(myUser);
        
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
        emitter(WalletsPageStateError(erro: e));
      }
    }

    Future<void> updatePages(UserModel myUser) async {
    Modular.get<HomeBloc>().userModel = myUser;
    Modular.get<HomeBloc>().add(OnHomePageEmpty());
    Modular.get<WalletsBloc>().add(OnWalletsPageEmpty());
    Modular.get<TransactionsBloc>().add(OnTransactionsInitState());
  }

}
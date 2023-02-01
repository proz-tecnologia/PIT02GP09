import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_respository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {

  final CreateWalletRepository repository;
  final String? id;
  UserModel userModel;
  
  CreateWalletBloc({
    required this.repository,
    required this.id,
    required this.userModel,
  }) : super(CreateWalletStateEmpty()) {
    log('Create Transaction bloc created');
    on<OnNewWallet>(createWallet);
  }

  Future<void> createWallet(    
    CreateWalletEvent event, 
    Emitter<CreateWalletState> emitter 
  ) async {
    try {
      emitter(CreateWalletStateLoading());

      // criar carteira ---------------------------------------------------------------------
      final wallet = event.newWallet;
      final updatedWallet = wallet!.copyWith(userID: id);      

      await repository.createWallet(wallet: updatedWallet);

      // atualizar usuario ------------------------------------------------------------------
      UserModel myUser = userModel;

      await repository.updateBalanceNewWallet(userModel: myUser, walletValue: event.newWallet!.value);
      
      Modular.get<HomeBloc>().userModel = myUser;

      emitter(CreateWalletStateSuccess(userModel: myUser));
      
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(CreateWalletStateError(erro: e));
    }
  }

}
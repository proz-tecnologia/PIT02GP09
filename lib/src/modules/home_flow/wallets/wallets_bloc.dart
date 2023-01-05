import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

}
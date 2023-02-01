
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

abstract class WalletsEvent {
  final WalletModel? wallet;

  WalletsEvent({
    this.wallet,
  });
}

class OnWalletsPageEmpty extends WalletsEvent {}

class OnWalletsPageSuccess extends WalletsEvent {}

class OnWalletsDelete extends WalletsEvent {

  OnWalletsDelete({super.wallet});
}
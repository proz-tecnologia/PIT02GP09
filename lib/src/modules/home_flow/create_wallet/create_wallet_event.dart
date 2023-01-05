import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';

abstract class CreateWalletEvent {
  final WalletModel? newWallet;

  CreateWalletEvent({
    required this.newWallet,
  });
}

class OnNewWallet extends CreateWalletEvent {
  OnNewWallet({required super.newWallet});
}
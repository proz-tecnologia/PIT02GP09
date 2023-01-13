import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class CreateWalletRepository extends Repository {

  CreateWalletRepository({required super.sharedPreferences});

  Future<void> createWallet({required WalletModel wallet});
  Future<void> updateBalanceNewWallet({required UserModel userModel, required double walletValue});
  Future<void> updateWalletValue({required WalletModel wallet});

}

import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class WalletsRepository extends Repository {

  WalletsRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});
  Future<List<WalletModel>?> getWallets({required String userID});

}
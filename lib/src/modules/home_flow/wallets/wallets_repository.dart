
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class WalletsRepository extends Repository {

  WalletsRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});
  Future<List<WalletModel>?> getWallets({required String userID});
  Future<void> deleteWallet({required String docID});
  Future<void> deleteTransactions({required String walletID});
  Future<List<FinancialTransaction>?> getTransactions({required String userID, required String walletID});
  Future<void> updateBalance({required UserModel userModel});
  Future<void> deleteTransaction({required String docID});
  Future<void> deleteCategory({required String category, required UserModel userModel});

}
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class CreateTransactionRepository extends Repository {

  CreateTransactionRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});
  Future<void> createTransaction({required FinancialTransaction transaction});
  Future<void> updateBalance({required UserModel userModel});
  Future<void> createCategory({required String newCategory, required UserModel userModel});
  Future<List<WalletModel>> getWallets({required String userID});

}
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class TransactionsPageRepository extends Repository {

  List<FinancialTransaction>? transactions;

  TransactionsPageRepository({required super.sharedPreferences,
                              this.transactions});

  Future<UserModel> getUserData({required String userID});
  Future<List<FinancialTransaction>?> getTransactions({
    required String userID,
    List<String>? categories});

}
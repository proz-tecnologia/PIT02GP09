import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class HomePageRepository extends Repository {

  HomePageRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});
  Future<List<FinancialTransaction>?> getTransactions({
    required String userID,
    List<String>? categories});
  Future<double> getMonthPlanning({
    required String userID,
    required int currentMonth});

}
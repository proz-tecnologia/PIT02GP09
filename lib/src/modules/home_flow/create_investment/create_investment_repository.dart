import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class CreateInvestmentRepository extends Repository {

  CreateInvestmentRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});
  Future<void> createInvestment({required InvestmentModel investment});

}
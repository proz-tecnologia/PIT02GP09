import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class InvestmentsRepository extends Repository {

  List<InvestmentModel>? investments;

  InvestmentsRepository({required super.sharedPreferences,
                              this.investments});

  Future<UserModel> getUserData({required String userID});
  Future<List<InvestmentModel>?> getInvestments({required String userID,});
}
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class CreatePlanningRepository extends Repository {

  CreatePlanningRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});
  Future<void> createPlanning({required PlanningModel planning});

}
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class PlanningsRepository extends Repository {

  List<PlanningModel>? plannings;

  PlanningsRepository({required super.sharedPreferences,
                           this.plannings});

  Future<UserModel> getUserData({required String userID});
  Future<List<PlanningModel>?> getPlannings({required String userID});
  Future<void> deletePlanning({required String docID});

}
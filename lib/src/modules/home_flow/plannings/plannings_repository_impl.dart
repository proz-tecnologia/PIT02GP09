
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanningsRepositoryImpl implements PlanningsRepository {

  @override
  List<PlanningModel>? plannings;

  @override
  final SharedPreferences sharedPreferences;

  PlanningsRepositoryImpl({required this.sharedPreferences});

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserData({required String userID}) async {
    final response = await FirebaseFirestore.instance
    .collection('users')
    .where('userModelID', isEqualTo: userID)
    .get();
    final document = response.docs.first.data();   
    final userData = UserModel.fromMap(document);
    return userData;
  }

  @override
  Future<List<PlanningModel>?> getPlannings({required String userID}) async {
    var firebasePlannings = 
        _firestore
        .collection('plannings')
        .where('userID', isEqualTo: userID);

    final filteredPlannings = await firebasePlannings.orderBy('finalDate', descending: true).get();

    final plannings = 
    filteredPlannings.docs
    .map(
      (e) => PlanningModel.fromMap(
        Map<String, dynamic>.from(
          e.data(),
        ),
      ),
    ).toList();
    return plannings;
  }
  
}
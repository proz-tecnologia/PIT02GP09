import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePlanningRepositoryImpl implements CreatePlanningRepository {

  @override
  final SharedPreferences sharedPreferences;
  
  CreatePlanningRepositoryImpl({required this.sharedPreferences});
  
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
  Future<void> createPlanning({required PlanningModel planning}) async {

    // cria planejamento e automaticamente gera um id
    final response = await _firestore
    .collection('plannings')
    .add(planning.toMap());

    // update no planejamento criado anteriormente adicionando o id gerado na criacao
    await _firestore
    .collection('plannings')
    .doc(response.id)
    .update({'id' : response.id});

    return Future.delayed(const Duration(seconds: 2));
  }


}
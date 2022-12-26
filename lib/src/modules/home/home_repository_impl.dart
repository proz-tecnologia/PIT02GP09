import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageRepositoryImpl implements HomePageRepository {

  @override
  final SharedPreferences sharedPreferences;

  HomePageRepositoryImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getUserData({required String userID}) async {
    log(userID);
    final response = await FirebaseFirestore.instance
    .collection('users')
    .where('userModelID', isEqualTo: userID)
    .get();
    final document = response.docs.first.data();   
    final userData = UserModel.fromMap(document);
    log(userData.userModelID);
    return userData;
  }
  
}
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/login_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFlowRepositoryImpl implements LoginFlowRepository {

  @override
  List<LoginModel> usersLogin = <LoginModel>[];
  @override
  late final SharedPreferences sharedPreferences;

  LoginFlowRepositoryImpl({required this.sharedPreferences}) {
    init();
  }

  // FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance; 

  @override
  Future<void> init() async {
    final users = sharedPreferences.getString(SharedPreferencesKeys.users);

    if (users != null && users.isNotEmpty) {
      final usersDecode = jsonDecode(users);

      final decodedUsers =
          (usersDecode as List).map((e) => LoginModel.fromJson(e)).toList();
      usersLogin.addAll(decodedUsers);
    }
  }

  @override
  Future<void> addUser({required LoginModel user}) async {
    late final SharedPreferences sharedPrefers;
    sharedPrefers = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));
    usersLogin.add(user);

    final newUsersJson = usersLogin.map((e) => e.toJson()).toList();

    sharedPrefers.setString(
        SharedPreferencesKeys.users, jsonEncode(newUsersJson));
  }

  @override
  Future<void> createUserData({required UserModel user}) async {
    final response = await _firestore
    .collection('users')
    .add(user.toMap());

    await _firestore
    .collection('users')
    .doc(response.id).update({'userModelDocID':response.id});    
  } 

  @override
  Future<List<LoginModel>> getUser() async {
    final users = sharedPreferences.getString(SharedPreferencesKeys.users);

    if (users != null && users.isNotEmpty) {
      final usersDecode = jsonDecode(users);

      final decodedUsers =
          (usersDecode as List).map((e) => LoginModel.fromJson(e)).toList();
      usersLogin.addAll(decodedUsers);
    }

    return usersLogin;
  }

  @override
  Future<String> getUserSession() async {
    return sharedPreferences
        .getString(SharedPreferencesKeys.userSession)
        .toString();
  }
}
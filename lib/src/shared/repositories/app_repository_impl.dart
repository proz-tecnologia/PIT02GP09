
import 'dart:convert';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/login_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/app_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepositoryImpl implements AppRepository {

  @override
  List<LoginModel> usersLogin = <LoginModel>[];
  @override
  final SharedPreferences sharedPreferences;

  AppRepositoryImpl({required this.sharedPreferences}) {
    init();
  }

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
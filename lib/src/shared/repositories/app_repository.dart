
import 'dart:convert';

import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/shared_preferences_keys.dart';

class AppRepository extends Repository {

  List<UserModel> usersLogin = <UserModel>[];

  AppRepository({required super.sharedPreferences}) {
    init();
  }

  Future<void> init() async {
    final users = sharedPreferences.getString(SharedPreferencesKeys.users);

    if (users != null && users.isNotEmpty) {
      final usersDecode = jsonDecode(users);

      final decodedUsers =
          (usersDecode as List).map((e) => UserModel.fromJson(e)).toList();
      usersLogin.addAll(decodedUsers);
    }
  }

  Future<List<UserModel>> getUser() async {
    final users = sharedPreferences.getString(SharedPreferencesKeys.users);

    if (users != null && users.isNotEmpty) {
      final usersDecode = jsonDecode(users);

      final decodedUsers =
          (usersDecode as List).map((e) => UserModel.fromJson(e)).toList();
      usersLogin.addAll(decodedUsers);
    }

    return usersLogin;
  }

  Future<String> getUserSession() async {
    return sharedPreferences
        .getString(SharedPreferencesKeys.userSession)
        .toString();
  }

  
}
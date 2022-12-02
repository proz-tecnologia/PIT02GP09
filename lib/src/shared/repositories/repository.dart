// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

import '../../utils/shared_preferences_keys.dart';

class Repository {
  List<UserModel> usersLogin = <UserModel>[];
  final SharedPreferences sharedPreferences;

  Repository({required this.sharedPreferences}) {
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

  Future<void> addUser({required UserModel user}) async {
    late final SharedPreferences sharedPrefers;
    sharedPrefers = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));
    usersLogin.add(user);

    final newUsersJson = usersLogin.map((e) => e.toJson()).toList();

    sharedPrefers.setString(
        SharedPreferencesKeys.users, jsonEncode(newUsersJson));
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

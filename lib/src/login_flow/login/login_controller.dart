import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import '../../models/user_model.dart';
import 'login_state.dart';

class LoginController {
  Future<LoginState> login({
    required String mail,
    required String password,
  }) async {
    List<UserModel> usersLogin = <UserModel>[];

    late final SharedPreferences sharedPrefers;
    sharedPrefers = await SharedPreferences.getInstance();

    final users = sharedPrefers.getString(SharedPreferencesKeys.users);
    await Future.delayed(const Duration(seconds: 3));

    if (users != null && users.isNotEmpty) {
      final usersDecode = jsonDecode(users);

      final decodedUsers =
          (usersDecode as List).map((e) => UserModel.fromJson(e)).toList();
      usersLogin.addAll(decodedUsers);
      for (var i = 0; i < usersLogin.length; i++) {
        while (mail.trim().contains(usersLogin[i].email.trim())) {
          if (usersLogin[i].password.contains(password.trim())) {
            await sharedPrefers.setString(
                SharedPreferencesKeys.userSession, usersLogin[i].name);
            return LoginStateSuccess();
          } else {
            return LoginStateEmpty();
          }
        }
      }
    }
    return LoginStateEmpty();
  }
}

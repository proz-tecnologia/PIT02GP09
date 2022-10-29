
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import 'login_state.dart';

class LoginController {
  LoginState state = LoginStateEmpty();

  Future<LoginState> login({
    required String mail,
    required String password,
  }) async {
    final sharedPrefers = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));

    await sharedPrefers.setBool(SharedPreferencesKeys.userData, true);
    return LoginStateSuccess();
  }
}

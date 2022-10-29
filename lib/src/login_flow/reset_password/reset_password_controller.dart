
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import 'reset_password_state.dart';

class ResetPasswordController {
  ResetPasswordState state = ResetPasswordStateEmpty();

  Future<ResetPasswordState> login({
    required String mail,
    required String password,
  }) async {
    final sharedPrefers = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));

    await sharedPrefers.setBool(SharedPreferencesKeys.userData, true);
    return ResetPasswordStateSuccess();
  }
}

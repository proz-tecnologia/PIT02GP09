
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import 'sign_up_state.dart';

class SignUpController {
  SignUpState state = SignUpStateEmpty();

  Future<SignUpState> register({
    required String name,
    required String mail,
    required String password,
  }) async {
    final sharedPrefers = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));

    await sharedPrefers.setBool(SharedPreferencesKeys.userData, true);
    return SignUpStateSuccess();
  }
}

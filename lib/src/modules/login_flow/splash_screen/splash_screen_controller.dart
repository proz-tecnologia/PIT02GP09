import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import 'splash_screen_state.dart';

class SplashScreenController {
  SplashScreenController();

  Future<SplashScreenState> isAuthenticated() async {
    final sharedPrefers = await SharedPreferences.getInstance();

    final String? userSession =
        sharedPrefers.getString(SharedPreferencesKeys.userSession);
    if (userSession != null && userSession.isNotEmpty) {
      return SplashScreenStateAuthenticated();
    } else {
      return SplashScreenStateUnauthenticated();
    }
  }
}

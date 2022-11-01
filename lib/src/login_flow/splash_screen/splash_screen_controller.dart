import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/shared_preferences_keys.dart';
import 'splash_screen_state.dart';

class SplashScreenController {
  /* 
  Checar armazenamento;
  Verificar se existem dados do usuário;
  if(existemDados)
  updateState(SplashStateAuthenticaded)
  else
  updateState(SplashStateY=Unauthenicated) */

  SplashScreenController();

  Future<SplashScreenState> isAuthenticated() async {
    final sharedPrefers = await SharedPreferences.getInstance();

    //APAGAR A LINHA ABAIXO
    await sharedPrefers.setString(SharedPreferencesKeys.userData, '');

    final String? userData =
        sharedPrefers.getString(SharedPreferencesKeys.userData);

    if (userData != null && userData.isNotEmpty) {
      return SplashScreenStateAuthenticated(userData);
    } else {
      return SplashScreenStateUnauthenticated();
    }
  }
}

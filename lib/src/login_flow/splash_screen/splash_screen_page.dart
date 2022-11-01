import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/consts_routes.dart';
import '../../../utils/consts.dart';
import '../../../utils/shared_preferences_keys.dart';
import '../../home/home_page.dart';
import 'splash_screen_controller.dart';
import 'splash_screen_state.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  SplashScreenController controller = SplashScreenController();
  
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      late final SharedPreferences sharedPrefers;
      sharedPrefers = await SharedPreferences.getInstance();
      await controller.isAuthenticated().then((value) async {
        if (value.runtimeType == SplashScreenStateAuthenticated) {
          final userSession =
              sharedPrefers.getString(SharedPreferencesKeys.userSession);

          Navigator.popAndPushNamed(
            context,
            ConstsRoutes.homePage,
            arguments: HomeArguments(name: userSession!),
          );
        } else if (value.runtimeType == SplashScreenStateUnauthenticated) {
          Navigator.popAndPushNamed(
            context,
            ConstsRoutes.loginPage,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 191,
              width: 205,
              child: Image(
                image: AssetImage(Consts.pathImageSplashScreen),
              ),
            ),
            Text(
              Consts.textTitleSplashScreen,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

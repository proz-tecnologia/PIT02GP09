import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../routes/consts_routes.dart';
import '../../../utils/consts.dart';
import 'splash_screen_bloc.dart';
import 'splash_screen_event.dart';
import 'splash_screen_state.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Modular.get<SplashScreenBloc>().add(OnIsAuthenticated());
    _navigateToHome();
  }
  _navigateToHome() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      final bloc = Modular.get<SplashScreenBloc>();
      if (bloc.state is SplashScreenStateAuthenticated) {
        Modular.to.navigate(ConstsRoutes.homePage);
      } else if (bloc.state is SplashScreenStateUnauthenticated) {
        Modular.to.navigate(ConstsRoutes.loginFlowModule);
        
      }
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

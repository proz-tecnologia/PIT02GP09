// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'modules/home/home_bloc.dart';
import 'modules/login_flow/login/login_bloc.dart';
import 'modules/login_flow/reset_password/reset_password_bloc.dart';
import 'modules/login_flow/sign_up/sign_up_bloc.dart';
import 'modules/login_flow/splash_screen/splash_screen_page.dart';
import 'modules/not_found_page/not_found_page.dart';
import 'routes/consts_routes.dart';

class AppModule extends Module {
  final SharedPreferences sharedPref;
  AppModule({
    required this.sharedPref,
  });
  
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => Repository(sharedPreferences: sharedPref)),
        Bind.singleton(
            (i) => LoginBloc(repository: i(), sharedPreferences: sharedPref)),
        Bind.singleton(
            (i) => SignUpBloc(repository: i(), sharedPreferences: sharedPref)),
        Bind.singleton((i) => HomeBloc(repo: i())),
        Bind.singleton((i) => ResetPasswordBloc(repo: i(), sharedPreferences:sharedPref )),
      ];

  @override
  List<ModularRoute> get routes => [
        //rota [/]
        ChildRoute(
          ConstsRoutes.rootRoute,
          child: (context, args) => const SplashScreenPage(),
        ),
        ModuleRoute(ConstsRoutes.loginFlowModule, module: LoginFlowModule( // equivalent to AutenthicationModule
                                                            sharedPref: sharedPref,
                                                          )),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}

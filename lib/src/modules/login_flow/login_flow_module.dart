// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login/login_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/reset_password/reset_password_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/sign_up/sign_up_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/sign_up/sign_up_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../not_found_page/not_found_page.dart';
import 'login/login_page.dart';
import 'reset_password/reset_password_bloc.dart';

class LoginFlowModule extends Module { // equivalent to AutenthicationModule

  final SharedPreferences sharedPref;

  LoginFlowModule({
    required this.sharedPref,
  });
  
  @override
  List<Bind<Object>> get binds => [
    Bind.factory((i) => LoginFlowRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.singleton(
            (i) => LoginBloc(repository: i(), sharedPreferences: sharedPref)),
    Bind.singleton(
            (i) => SignUpBloc(repository: i(), sharedPreferences: sharedPref)),
    Bind.singleton((i) => HomeBloc(repository: i())),
    Bind.singleton((i) => ResetPasswordBloc(repo: i(), sharedPreferences:sharedPref )),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ConstsRoutes.rootRoute,
            child: (context, args) => const LoginPage()),
        ChildRoute(ConstsRoutes.signUpPage,
            child: (context, args) => const SignUpPage()),
        ChildRoute(ConstsRoutes.resetPasswordPage,
            child: (context, args) => const ResetPasswordPage()),
        ModuleRoute(ConstsRoutes.homePageModule, module: HomePageModule( // equivalent to AutenthicationModule
                                                            sharedPref: sharedPref,
                                                          )),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}

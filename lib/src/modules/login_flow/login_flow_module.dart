import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login/login_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/reset_password/reset_password_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/sign_up/sign_up_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';

class LoginFlowModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ConstsRoutes.rootRoute,
            child: (context, args) => const LoginPage()),

        ChildRoute(ConstsRoutes.signUpPage,
            child: (context, args) => const SignUpPage()),

        ChildRoute(ConstsRoutes.homePage,
            child: (context, args) => const HomePage()),
            
        ChildRoute(ConstsRoutes.resetPasswordPage,
            child: (context, args) => const ResetPasswordPage()),
      ];
}

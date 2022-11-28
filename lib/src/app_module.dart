import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_module.dart';

import 'modules/login_flow/splash_screen/splash_screen_page.dart';
import 'modules/not_found_page/not_found_page.dart';
import 'routes/consts_routes.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        //rota [/]
        ChildRoute(
          ConstsRoutes.rootRoute,
          child: (context, args) => const SplashScreenPage(),
        ),
        ModuleRoute(ConstsRoutes.loginFlowModule, module: LoginFlowModule()),
        WildcardRoute(child: (context, args) =>const NotFoundPage()),
      ];
}

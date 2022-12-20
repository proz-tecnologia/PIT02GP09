import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/not_found_page/not_found_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModule extends Module {

  final SharedPreferences sharedPref;

  HomeModule({
    required this.sharedPref,
  });

  @override
  List<Bind<Object>> get binds => [
    Bind.factory((i) => HomeRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.singleton((i) => HomeBloc(repository: i())),
  ];

  @override
  List<ModularRoute> get routes => [
        //rota [/]
        ChildRoute(
          ConstsRoutes.rootRoute,
          child: (context, args) => const HomePage(),
        ),
        ModuleRoute(ConstsRoutes.loginFlowModule,
                    module: LoginFlowModule(sharedPref: sharedPref)),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];


}
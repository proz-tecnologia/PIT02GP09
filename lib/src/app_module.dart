// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_controller.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/splash_screen/splash_screen_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/app_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/app_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Bind.lazySingleton<AppController>((i) => AppController()),
    Bind.factory<AppRepository>((i) => AppRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.singleton(
            (i) => SplashScreenBloc(repository: i.get<AppRepository>(), sharedPreferences: sharedPref)),        
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
        ModuleRoute(ConstsRoutes.homePageModule, module: HomePageModule( // equivalent to AutenthicationModule
                                                            sharedPref: sharedPref,
                                                          )),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}

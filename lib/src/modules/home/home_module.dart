import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/widgets/login_flow_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/not_found_page/not_found_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageModule extends Module { // equivalent to AutenthicationModule

  final SharedPreferences sharedPref;

  HomePageModule({
    required this.sharedPref,
  });
  
  @override
  List<Bind<Object>> get binds => [
    Bind.factory((i) => LoginFlowRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.singleton((i) => HomeBloc(repo: i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ConstsRoutes.rootRoute,
            child: (context, args) => const HomePage()),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}
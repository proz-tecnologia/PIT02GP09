import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_controller.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository_impl.dart';
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
    Bind.factory<HomePageRepository>((i) => HomePageRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.singleton<HomeBloc>(
            (i) => HomeBloc(repository: i.get<HomePageRepository>(),
                            id: i.get<AppController>().user!.uid)),
    Bind.factory<CreateTransactionRepository>(
            (i) => CreateTransactionRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.factory(
            (i) => CreateTransactionBloc(i.get<CreateTransactionRepository>(),
                                         i.get<AppController>().user!.uid,
                                         i.get<HomeBloc>().userModel!))
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ConstsRoutes.rootRoute,
            child: (context, args) => const HomePage()),
        ChildRoute(ConstsRoutes.createTransactionPage,
            child: (context, args) => const CreateTransactionPage()),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}
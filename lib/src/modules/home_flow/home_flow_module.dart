import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_controller.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_respository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_repository.impl.dart';
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
    Bind.factory<TransactionsPageRepository>(
            (i) => TransactionsPageRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => TransactionsBloc(repository: i.get<TransactionsPageRepository>(),
                                    id: i.get<AppController>().user!.uid,
                                    userModel: i.get<HomeBloc>().userModel!)),
    Bind.factory<CreateTransactionRepository>(
            (i) => CreateTransactionRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => CreateTransactionBloc(i.get<CreateTransactionRepository>(),
                                         i.get<AppController>().user!.uid,
                                         i.get<HomeBloc>().userModel!)),    
    Bind.factory<WalletsRepository>(
            (i) => WalletsRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => WalletsBloc(repository: i.get<WalletsRepository>(),
                               id: i.get<AppController>().user!.uid,
                               userModel: i.get<HomeBloc>().userModel!)),
    Bind.factory<CreateWalletRepository>(
            (i) => CreateWalletRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => CreateWalletBloc(repository: i.get<CreateWalletRepository>(),
                                    id: i.get<AppController>().user!.uid,
                                    userModel: i.get<HomeBloc>().userModel!)),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ConstsRoutes.rootRoute,
            child: (context, args) => const HomePage()),
        ChildRoute(ConstsRoutes.transactionsPage,
            child: (context, args) => const TransactionsPage()),
        ChildRoute(ConstsRoutes.createTransactionPage,
            child: (context, args) => const CreateTransactionPage()),        
        ChildRoute(ConstsRoutes.walletsPage,
            child: (context, args) => const WalletsPage()),
        ChildRoute(ConstsRoutes.createWalletPage,
            child: (context, args) => const CreateWalletPage()),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}
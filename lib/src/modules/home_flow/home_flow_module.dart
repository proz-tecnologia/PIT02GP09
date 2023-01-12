import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_controller.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_repository_impl.dart';
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
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_repository_impl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_repository_impl.dart';
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
    // ---------------------------------------------------------------------------------------- HOME
    Bind.factory<HomePageRepository>(
            (i) => HomePageRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.singleton<HomeBloc>(
            (i) => HomeBloc(repository: i.get<HomePageRepository>(),
                            id: i.get<AppController>().user!.uid)),
    // --------------------------------------------------------------------------------- TRANSACTIONS 
    Bind.factory<TransactionsPageRepository>(
            (i) => TransactionsPageRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => TransactionsBloc(repository: i.get<TransactionsPageRepository>(),
                                    id: i.get<AppController>().user!.uid,
                                    userModel: i.get<HomeBloc>().userModel!)),
    // -------------------------------------------------------------------------- CREATE TRANSACTIONS
    Bind.factory<CreateTransactionRepository>(
            (i) => CreateTransactionRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.factory(
            (i) => CreateTransactionBloc(i.get<CreateTransactionRepository>(),
                                         i.get<AppController>().user!.uid,
                                         i.get<HomeBloc>().userModel!)),
    // ------------------------------------------------------------------------------------- WALLETS    
    Bind.factory<WalletsRepository>(
            (i) => WalletsRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => WalletsBloc(repository: i.get<WalletsRepository>(),
                               id: i.get<AppController>().user!.uid,
                               userModel: i.get<HomeBloc>().userModel!)),
    // ------------------------------------------------------------------------------- CREATE WALLET
    Bind.factory<CreateWalletRepository>(
            (i) => CreateWalletRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.factory(
            (i) => CreateWalletBloc(repository: i.get<CreateWalletRepository>(),
                                    id: i.get<AppController>().user!.uid,
                                    userModel: i.get<HomeBloc>().userModel!)),
    // --------------------------------------------------------------------------------- INVESTMENTS
    Bind.factory<InvestmentsRepository>(
            (i) => InvestmentsRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.lazySingleton(
            (i) => InvestmentsBloc(repository: i.get<InvestmentsRepository>(),
                                    id: i.get<AppController>().user!.uid,
                                    userModel: i.get<HomeBloc>().userModel!)),
    // --------------------------------------------------------------------------- CREATE INVESTMENT
    Bind.factory<CreateInvestmentRepository>(
            (i) => CreateInvestmentRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.factory(
            (i) => CreateInvestmentBloc(repository: i.get<CreateInvestmentRepository>(),
                                        id: i.get<AppController>().user!.uid,
                                        userModel: i.get<HomeBloc>().userModel!)),
    // ----------------------------------------------------------------------------------- PLANNINGS
    Bind.factory<PlanningsRepository>(
            (i) => PlanningsRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.factory(
            (i) => PlanningsBloc(repository: i.get<PlanningsRepository>(),
                                        id: i.get<AppController>().user!.uid,
                                        userModel: i.get<HomeBloc>().userModel!)),
    // ---------------------------------------------------------------------------- CREATE PLANNINGS
    Bind.factory<CreatePlanningRepository>(
            (i) => CreatePlanningRepositoryImpl(sharedPreferences: sharedPref)),
    Bind.factory(
            (i) => CreatePlanningBloc(repository: i.get<CreatePlanningRepository>(),
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
        ChildRoute(ConstsRoutes.investmentsPage,
            child: (context, args) => const InvestmentsPage()),
        ChildRoute(ConstsRoutes.createInvestmentPage,
            child: (context, args) => const CreateInvestmentPage()),
        ChildRoute(ConstsRoutes.planningsPage,
            child: (context, args) => const PlanningsPage()),
        ChildRoute(ConstsRoutes.createPlanningPage,
            child: (context, args) => const CreatePlanningPage()),
        WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}
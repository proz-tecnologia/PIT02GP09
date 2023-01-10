// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/formatters.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';
import 'home_bloc.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = Modular.get<HomeBloc>();
  String? name;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    Modular.get<HomeBloc>().add(OnHomePageEmpty());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeStateEmpty) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Homepage Empty'),
                actions: [
                  IconButton(
                    onPressed: () {                
                      Modular.get<HomeBloc>().add(OnHomePageLogout());
                      Modular.to.popAndPushNamed(ConstsRoutes.loginFlowModule);
                    },
                    icon: const Icon(Icons.logout))
                ],
              ),
            );
          } else if (state is HomeStateSuccess) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Page  Olá ${state.user.userModelName}'),
                actions: [
                  IconButton(
                    onPressed: () {                
                      Modular.get<HomeBloc>().add(OnHomePageLogout());
                      Modular.to.popAndPushNamed(ConstsRoutes.loginFlowModule);
                    },
                    icon: const Icon(Icons.logout))
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    Text('Seu saldo é de ${Formatters.formatToReal(state.user.balance)} reais'),
                    
                    IconButton(
                    onPressed: () {
                      Modular.to.pushNamed(ConstsRoutes.transactionsPage);
                    },
                    icon: const Icon(Icons.monetization_on)),

                    IconButton(
                    onPressed: () {
                      Modular.to.pushNamed(ConstsRoutes.walletsPage);
                    },
                    icon: const Icon(Icons.wallet))

                  ],
                ),
              ),
            );

          } else if (state is HomeStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is HomeStateError) {
            log(state.toString());
            log(state.erro.toString());
            log(state.runtimeType.toString());
            return Text(state.erro.toString());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

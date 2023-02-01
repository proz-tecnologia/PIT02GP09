
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/consts.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/formatters.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {

  final bloc = Modular.get<WalletsBloc>();

  @override
  void initState() {
    bloc.add(OnWalletsPageEmpty());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<WalletsBloc, WalletsPageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is WalletsPageStateEmpty) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Wallets page Empty'),
              ),
              body: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Modular.to.pushReplacementNamed(ConstsRoutes.homePageModule);
                      },
                      icon: const Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () {
                        Modular.to.pushReplacementNamed(ConstsRoutes.createWalletPage);
                      },
                      icon: const Icon(Icons.add),
                    ),
                    

                    Center(
                        child: Text('Não há carteiras.',
                                      style: Theme.of(context).textTheme.titleLarge,),
                      ),

                      const SizedBox(
                        height: 191,
                        width: 205,
                        child: Image(
                          image: AssetImage(Consts.pathImageEmptyBox),
                        ),
                      ),
                    
                  ],
                ),
              ),
            );

          } else if (state is WalletsPageStateSuccess) {
            return Scaffold(              
              body: Padding(
                padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                child: Column(
                  children: [

                    IconButton(
                          onPressed: (() {
                            Modular.to.pushReplacementNamed(ConstsRoutes.homePageModule);
                          }),
                        icon: const Icon(Icons.home),          
                        ),

                    IconButton(
                      onPressed: () {
                        Modular.to.pushReplacementNamed(ConstsRoutes.createWalletPage);
                      },
                      icon: const Icon(Icons.add)),

                    Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.wallets!.length,
                            itemBuilder: (context, i) {                            
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(state.wallets![i].name.toString(),
                                             style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        const Divider(),
                                        Text(Formatters.formatToReal(state.wallets![i].value)),
                                        const Divider(),
                                        IconButton(
                                          onPressed: (() async {
                                            bloc.add(OnWalletsDelete(wallet: state.wallets![i]));
                                          }),
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                  ],
                ),
              ),
            );

          } else if (state is WalletsPageStateLoading) {
            log(state.toString());
            return const ShowLoader();
            
          } else if (state is WalletsPageStateError) {
            log(state.toString());
            log(state.erro.toString());
            log(state.runtimeType.toString());
            return Text(state.erro.toString());
          }
          return Container();
        }
      ),
    );
  }
}
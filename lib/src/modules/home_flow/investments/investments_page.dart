import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {

  final bloc = Modular.get<InvestmentsBloc>();

  @override
  void initState() {
    bloc.add(OnInvestmentsInitState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<InvestmentsBloc, InvestmentsPageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is InvestmentsPageStateEmpty) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Investments page Empty'),
              ),
              body: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Modular.to.popAndPushNamed(ConstsRoutes.homePageModule);
                      },
                      icon: const Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () {
                        Modular.to.popAndPushNamed(ConstsRoutes.createInvestmentPage);
                      },
                      icon: const Icon(Icons.add),
                    ),
                    
                    const Center(
                      child: Text('Não há investimentos.'),
                    ),
                    
                  ],
                ),
              ),
            );

          } else if (state is InvestmentsPageStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is InvestmentsPageStateSuccess) {
            log(state.investments!.length.toString());
            return Scaffold(              
              body: Column(
                children: [

                  IconButton(
                        onPressed: (() {
                          Modular.to.popAndPushNamed(ConstsRoutes.homePageModule);
                        }),
                      icon: const Icon(Icons.home),
                      ),

                  IconButton(
                    onPressed: () {
                      Modular.to.popAndPushNamed(ConstsRoutes.createInvestmentPage);
                    },
                    icon: const Icon(Icons.add)),

                  Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.investments!.length,
                          itemBuilder: (context, i) {
                            
                            return Card(
                              child: Column(
                                children: [
                                  Text(state.investments![i].name),
                                  const Divider(),
                                  Text('Data inicial: ${state.investments![i].formattedDate}'),
                                  const Divider(),
                                  Text('Valor inicial: R\$ ${state.investments![i].initialValue.toStringAsFixed(2)}'),
                                  const Divider(),
                                  Text('Taxa diária de rendimento: ${state.investments![i].incomeRateByDay.toStringAsFixed(2)}%'),
                                  const Divider(),
                                  Text('Rendimento hoje: +R\$ ${(state.investments![i].currentValue -
                                                                state.investments![i].getValueAtTime(
                                                                    DateTime.now().subtract(const Duration(days:1)))).toStringAsFixed(2)}',
                                        style: const TextStyle(color: Colors.green),),
                                  const Divider(),
                                  Text('Valor atual: R\$ ${state.investments![i].currentValue.toStringAsFixed(2)}'),                                  
                                ],
                              ),
                            );

                          }
                        ),
                      ),
                ],
              ),
            );

          } else if (state is InvestmentsPageStateError) {
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
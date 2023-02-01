import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/investments/investments_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/consts.dart';
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                      
                      Center(
                        child: Text('Não há investimentos.',
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
              ),
            );

          } else if (state is InvestmentsPageStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is InvestmentsPageStateSuccess) {
            log(state.investments!.length.toString());
            return Scaffold(              
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
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

                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.investments!.length,
                      itemBuilder: (context, i) {
                              
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(                              
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.investments![i].name,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Divider(),
                                  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    const Text('Data inicial:'),
                                                    Text(state.investments![i].formattedDate), 
                                                    const Divider(),
                                                    const Text('Valor inicial:'),
                                                    Text('R\$ ${state.investments![i].initialValue.toStringAsFixed(2)}'),
                                                  ],
                                                ),
                                                // const Divider(),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    const Text('Taxa diária de rendimento:'),
                                                    Text('${state.investments![i].incomeRateByDay.toStringAsFixed(2)}%'),
                                                    const Divider(),
                                                    const Text('Rendimento hoje:'),
                                                    Text('+R\$ ${(state.investments![i].currentValue -
                                                                                  state.investments![i].getValueAtTime(
                                                                                      DateTime.now().subtract(const Duration(days:1)))).toStringAsFixed(2)}',
                                                          style: const TextStyle(color: Colors.green)),
                                                    const Divider(),
                                                    const Text('Valor atual:'),
                                                    Text('R\$ ${state.investments![i].currentValue.toStringAsFixed(2)}'),
                                                  ],
                                                ),                                  
                                              
                                            IconButton(
                                              onPressed: (() {
                                                bloc.add(OnInvestmentsDelete(investment: state.investments![i]));
                                              }),
                                            icon: const Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );

                            }
                          ),
                        
                  ],
                ),
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
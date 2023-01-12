import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/plannings/plannings_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class PlanningsPage extends StatefulWidget {
  const PlanningsPage({super.key});

  @override
  State<PlanningsPage> createState() => _PlanningsPageState();
}

class _PlanningsPageState extends State<PlanningsPage> {

  final bloc = Modular.get<PlanningsBloc>();

  @override
  void initState() {
    bloc.add(OnPlanningsInitState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PlanningsBloc, PlanningsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is PlanningsStateEmpty) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Plannings page Empty'),
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
                        Modular.to.popAndPushNamed(ConstsRoutes.createPlanningPage);
                      },
                      icon: const Icon(Icons.add),
                    ),
                    
                    const Center(
                      child: Text('Não há planejamentos.'),
                    ),
                    
                  ],
                ),
              ),
            );

          } else if (state is PlanningsStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is PlanningsStateSuccess) {
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
                      Modular.to.popAndPushNamed(ConstsRoutes.createPlanningPage);
                    },
                    icon: const Icon(Icons.add)),

                  Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.plannings!.length,
                          itemBuilder: (context, i) {
                            
                            return Card(
                              child: Column(
                                children: [
                                  Text(state.plannings![i].name),
                                  const Divider(),
                                  Text('Nome: ${state.plannings![i].name}'),
                                  const Divider(),
                                  Text('Valor: R\$ ${state.plannings![i].value.toStringAsFixed(2)}'),
                                  const Divider(),
                                  Text('Data limite: ${state.plannings![i].formattedDate}'),                                 
                                ],
                              ),
                            );

                          }
                        ),
                      ),
                ],
              ),
            );

          } else if (state is PlanningsStateError) {
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
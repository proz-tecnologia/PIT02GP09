import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/formatters.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';


class TransactionsPage extends StatefulWidget {
  
  const TransactionsPage({super.key});

  @override
  
  State<TransactionsPage> createState() => _TransactionsPageState();
}


class _TransactionsPageState extends State<TransactionsPage> {

  final bloc = Modular.get<TransactionsBloc>();

  @override
  void initState() {
    bloc.add(OnTransactionsPageEmpty());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TransactionsBloc, TransactionsPageState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TransactionsPageStateEmpty) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Transactions page Empty'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Modular.to.pushReplacementNamed(ConstsRoutes.loginFlowModule);
                    },
                    icon: const Icon(Icons.logout))
                ],
              ),
            );
          } else if (state is TransactionsPageStateSuccess) {
            return Scaffold(              
              body: Column(
                children: [

                  IconButton(
                        onPressed: (() {
                          Modular.to.pushReplacementNamed(ConstsRoutes.homePageModule);
                        }),
                      icon: const Icon(Icons.home),          
                      ),

                  IconButton(
                    onPressed: () {
                      Modular.to.pushReplacementNamed(ConstsRoutes.createTransactionPage);
                    },
                    icon: const Icon(Icons.add)),

                  Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: bloc.repository.transactions!.length,
                          itemBuilder: (context, i) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(bloc.repository.transactions![i].type.toString()),
                                  const Divider(),
                                  Text(Formatters.formatToReal(bloc.repository.transactions![i].value)),
                                  const Divider(),
                                  Text(DateFormat('dd/MM/yy').format(bloc.repository.transactions![i].date)),

                                  /*
                                  IconButton(
                                    onPressed: (() {
                                      movementsCubit.deleteTransaction(
                                        transaction: movementsCubit.myTransactions[i],
                                      );
                                    }),
                                  icon: const Icon(Icons.delete),          
                                  ),
                                  */

                                ],
                                ),
                              );
                          }
                        ),
                      ),
                ],
              ),
            );

          } else if (state is TransactionsPageStateLoading) {
            log(state.toString());
            return const ShowLoader();

          }  else if (state is TransactionsPageStateError) {
            log(state.toString());
            log(state.erro.toString());
            log(state.runtimeType.toString());
            return Text(state.erro.toString());

          }
          return Container();
        },
      ),
    );
  }
}
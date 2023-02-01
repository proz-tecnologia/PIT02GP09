import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/transactions/transactions_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/consts.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/formatters.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';


class TransactionsPage extends StatefulWidget {
  
  const TransactionsPage({super.key});

  @override  
  State<TransactionsPage> createState() => _TransactionsPageState();
}


class _TransactionsPageState extends State<TransactionsPage> {

  final bloc = Modular.get<TransactionsBloc>();

  List<String> categories = Modular.get<HomeBloc>().userModel!.categories;
  List<String> selectedCategories = [];

  void selectCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    log('selected categories: $selectedCategories');
    bloc.add(OnTransactionsInitState(categories: selectedCategories));
  }

  @override
  void initState() {
    super.initState();
    bloc.add(OnTransactionsInitState());
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
                        Modular.to.pushReplacementNamed(ConstsRoutes.createTransactionPage);
                      },
                      icon: const Icon(Icons.add),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          children: categories.map(
                            (e) => SizedBox(
                                height: 36.0,
                                width: 120.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () => selectCategory(e),
                                      child: Chip(
                                        label: Text(e),
                                          backgroundColor:
                                          selectedCategories.contains(e) ?
                                          Colors.blue
                                          : null,
                                      ),
                                  ),
                                ),
                            ),
                          ).toList(),
                        ),
                      ],
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
            );
          } else if (state is TransactionsPageStateSuccess) {
            log(state.transactions!.length.toString());
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
                        Modular.to.pushReplacementNamed(ConstsRoutes.createTransactionPage);
                      },
                      icon: const Icon(Icons.add)),
              
                    Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.transactions!.length,
                            itemBuilder: (context, i) {
              
                              if (i == 0) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Wrap(
                                      children: categories.map(
                                        (e) => SizedBox(
                                          height: 36.0,
                                          width: 120.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () => selectCategory(e),
                                              child: Chip(
                                                label: Text(e),
                                                backgroundColor:
                                                selectedCategories.contains(e) ?
                                                  Colors.blue
                                                  : null,
                                                ),
                                              ),
                                            ),
                                        ),
                                      ).toList(),
                                      
                                    ),
                                    Card(
                                      child: Column(
                                        children: [
                                          Text(state.transactions![i].type == TransactionTypes.expense ?
                                                'Despesa' : 'Receita'),
                                          const Divider(),
                                          Text(style: state.transactions![i].type == TransactionTypes.expense ?
                                                const TextStyle(color: Colors.red) : 
                                                const TextStyle(color: Colors.green),
                                            Formatters.formatToReal(state.transactions![i].value)),
                                          const Divider(),
                                          Text(state.transactions![i].formattedDate),
                                          const Divider(),
                                          Text(state.transactions![i].category ??
                                              ''),
                                    
                                    IconButton(
                                      onPressed: (() {
                                        bloc.add(OnTransactionsDelete(transaction: state.transactions![i]));
                                      }),
                                      icon: const Icon(Icons.delete),
                                    ),

                                        ],
                                      ),
                                    )                                  
                                  ],
                                );
                              }
                              return Card(
                                child: Column(
                                  children: [
                                    Text(state.transactions![i].type == TransactionTypes.expense ?
                                          'Despesa' : 'Receita'),
                                    const Divider(),
                                    Text(style: state.transactions![i].type == TransactionTypes.expense ?
                                          const TextStyle(color: Colors.red) : 
                                          const TextStyle(color: Colors.green),
                                      Formatters.formatToReal(state.transactions![i].value)),
                                    const Divider(),
                                    Text(state.transactions![i].formattedDate),
                                    const Divider(),
                                    Text(state.transactions![i].category ??
                                         ''),
                                    
                                    IconButton(
                                      onPressed: (() {
                                        bloc.add(OnTransactionsDelete(transaction: state.transactions![i]));
                                      }),
                                      icon: const Icon(Icons.delete),
                                    ),
                                    
                                  ],
                                ),
                              );
                            }
                          ),
                        ),
                  ],
                ),
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
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class CreateTransactionPage extends StatefulWidget {
  
  const CreateTransactionPage({super.key});

  @override
  State<CreateTransactionPage> createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {

  final bloc = Modular.get<CreateTransactionBloc>();

  TransactionTypes? type;  
  
  final _formKey = GlobalKey<FormState>();

  // financial transaction common parameters controllers
  final typeController = TextEditingController();
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final idController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  get inputClear {
    typeController.clear;
    nameController.clear;
    valueController.clear;
    idController.clear;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CreateTransactionBloc, CreateTransactionState> (
        bloc: bloc,
        builder: (context, state) {
          if (state is CreateTransactionStateEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Registrar transação'),
                automaticallyImplyLeading: false,
                ),
              body: Form(
                key: _formKey,
                onChanged: () => setState(() {}),
                child: ListView(
                  children: [

                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          barrierDismissible: true, 
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text('Tipo de transação: '),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              children: 
                                    List.generate(
                                      TransactionTypes.values.length,
                                      (i) => 
                                      IconButton(
                                      onPressed: () {
                                        type = TransactionTypes.values[i];
                                        typeController.text = TransactionTypes.values[i].toString();
                                        Navigator.pop(context);
                                      }, 
                                      icon: Text(TransactionTypes.values[i].toString()),
                                      ),
                                    ),           
                            );
                          }
                        );                        
                      }, 
                      icon: const Text('Escolha um tipo de transação')
                    ),

                    TextFormField(
                      enabled: false,
                      controller: typeController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Valor inválido';
                        }
                      },
                      decoration: const InputDecoration(label: Text('Tipo de transação')),
                    ),

                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Valor inválido';
                        }
                      },
                      decoration: const InputDecoration(label: Text('Nome: ')),
                    ),

                    TextFormField(
                      controller: valueController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            double.tryParse(value) != null) {
                          return null;
                        } else {
                          return 'Valor inválido';
                        }
                      },
                      decoration: const InputDecoration(label: Text('valor: ')),
                    ),

                    IconButton(
                      onPressed:                
                        _formKey.currentState?.validate() == true ?
                        () {
                          double value = double.parse(valueController.text);
                          final newTransaction = FinancialTransaction(
                            type: type!, 
                            name: nameController.text, 
                            value: value, 
                            date: date,
                            );
                          bloc.add(OnNewTransaction(newTransaction: newTransaction));
                          log(newTransaction.value.toString());
                        } : null,
                      icon: const Icon(Icons.add),
                    ),

                    IconButton(
                        onPressed: (() {
                          inputClear;
                          Modular.to.pushReplacementNamed(ConstsRoutes.homePageModule);
                        }),
                      icon: const Icon(Icons.home),          
                      ),

                    IconButton(
                        onPressed: (() {
                          inputClear;
                          Modular.to.pushReplacementNamed(ConstsRoutes.transactionsPage);
                        }),
                      icon: const Icon(Icons.arrow_back),          
                      )

                  ],
                ),
              ),
            );

          } else if (state is CreateTransactionStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is CreateTransactionStateSuccess){
            inputClear;
            log(state.toString());
            Modular.get<HomeBloc>().add(OnHomePageEmpty());
            Modular.to.pushReplacementNamed(ConstsRoutes.transactionsPage);

          } else if (state is CreateTransactionError) {
            inputClear;
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
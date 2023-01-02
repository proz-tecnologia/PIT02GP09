import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
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
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final idController = TextEditingController();
  Timestamp date = Timestamp.now();

  List<String> categories = Modular.get<HomeBloc>().userModel!.categories;
  String? category;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  get inputClear {
    nameController.clear;
    valueController.clear;
    idController.clear;
  }

  @override
  void initState() {
    type = TransactionTypes.values.first;
    super.initState();
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

                    DropdownButtonFormField(
                      value: type,
                      items: TransactionTypes.values.map(
                        (e) => DropdownMenuItem<TransactionTypes>(
                          value: e,
                          child: e == TransactionTypes.expense ? const Text('Despesa') : const Text('Receita'),
                          ),
                        ).toList(), 
                      onChanged: (value) {
                        type = value;
                      }, 
                    ),

                    /*
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
                    */
                    
                    DropDownTextField(
                      enableSearch: true,
                      dropDownList: categories.map(
                          (e) => DropDownValueModel(
                            name: e, 
                            value: e,
                            ),
                          ).toList(),
                      onChanged: (value) {
                        category = value.value;
                        log(category.toString());
                      },
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
                            category: category,
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
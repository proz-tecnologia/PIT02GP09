import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_transaction/create_transaction_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/widgets/custom_input_form/custom_text_form_field.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/financial_transactions/financial_transaction.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class CreateTransactionPage extends StatefulWidget {
  
  const CreateTransactionPage({super.key});

  @override
  State<CreateTransactionPage> createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {

  var bloc = Modular.get<CreateTransactionBloc>();

  TransactionTypes? type;  
  
  final _formKey = GlobalKey<FormState>();

  // financial transaction common parameters controllers
  final typeController = TextEditingController();
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final categoryController = TextEditingController();
  final walletController = TextEditingController();
  Timestamp date = Timestamp.now();

  List<String> categories = Modular.get<HomeBloc>().userModel!.categories;
  String? walletID;

  get inputClear {
    typeController.clear();
    nameController.clear();
    valueController.clear();
    categoryController.clear();
    walletController.clear();
  }

  @override
  void initState() {
    super.initState();
    type = TransactionTypes.values.first;
    bloc.add(OnInitState());    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CreateTransactionBloc, CreateTransactionState> (
        bloc: bloc,
        listener: (context, state) {
          if (state is CreateTransactionSuccess) {
            Modular.to.popAndPushNamed(ConstsRoutes.transactionsPage);
          }
        },
        builder: (context, state) {
          if (state is CreateTransactionStateNoWallets) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Você não tem carteiras'),
                automaticallyImplyLeading: false,
                ),
              body: Column(
                children: [
                  IconButton(
                        onPressed: (() {
                          //inputClear;
                          Modular.to.popAndPushNamed(ConstsRoutes.homePageModule);
                        }),
                      icon: const Icon(Icons.home),          
                      ),

                    IconButton(
                        onPressed: (() {
                          //inputClear;
                          Modular.to.popAndPushNamed(ConstsRoutes.transactionsPage);
                        }),
                      icon: const Icon(Icons.arrow_back),          
                      )
                ],
              ),
            );

          } else if (state is CreateTransactionStateEmpty) {
            log(state.toString());
            walletID = state.wallets.first.id;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Registrar transação'),
                automaticallyImplyLeading: false,
                ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        onChanged: () => setState(() {}),
                        child: ListView (
                          shrinkWrap: true,
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
                            
                            DropdownButtonFormField(
                              value: state.wallets.first,
                              items: state.wallets.map(
                                (e) => DropdownMenuItem<WalletModel>(
                                  value: e,
                                  child: Text(e.name),
                                  ),
                                ).toList(), 
                              onChanged: (value) {
                                walletID = value!.id;
                              }, 
                            ),
                            const SizedBox(height: 20),
                            const Text('Escolha uma categoria da lista ou digite uma nova categoria:'),
                            const SizedBox(height: 20),                            
                            IconButton(
                              color: Colors.blueGrey,
                              onPressed: () {
                                showDialog(
                                  context: context, 
                                  barrierDismissible: true, 
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: const Text('Lista de categorias: '),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      children:
                                            List.generate(
                                              categories.length,
                                              (i) =>
                                              IconButton(
                                              onPressed: () {
                                                categoryController.text = categories[i].toString();
                                                Navigator.pop(context);
                                              },
                                              icon: Text(categories[i].toString()),
                                              ),
                                            ),           
                                    );
                                  }
                                );                        
                              }, 
                              icon: const Text('Escolha uma categoria')
                            ),
                            const SizedBox(height: 20),
                            
                            CustomTextFormField(
                                            prefixIcon: null,
                                            label: 'Categoria',
                                            controller: categoryController,
                                            hintText: 'Categoria',
                                            validator: (value) {
                                                          if (value != null &&
                                                              value.isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Valor inválido';
                                                          }
                                                        },
                                            //suffix: InputClear(
                                            //    controller: mailController),
                                            textInputAction: TextInputAction.next,
                                            //onFieldSubmitted: (_) =>
                                            //    passwordFocusNode.requestFocus(),
                                          ),
                            const SizedBox(height: 20),

                            CustomTextFormField(
                                            prefixIcon: null,
                                            label: 'Nome',
                                            controller: nameController,
                                            hintText: 'Nome',
                                            validator: (value) {
                                                          if (value != null &&
                                                              value.isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Valor inválido';
                                                          }
                                                        },
                                            //suffix: InputClear(
                                            //    controller: mailController),
                                            textInputAction: TextInputAction.next,
                                            //onFieldSubmitted: (_) =>
                                            //    passwordFocusNode.requestFocus(),
                                          ),                            
                            const SizedBox(height: 20),

                            CustomTextFormField(
                                            prefixIcon: null,
                                            label: 'Valor',
                                            controller: valueController,
                                            hintText: 'Valor',
                                            validator: (value) {
                                                          if (value != null &&
                                                              value.isNotEmpty) {
                                                            return null;
                                                          } else {
                                                            return 'Valor inválido';
                                                          }
                                                        },
                                            //suffix: InputClear(
                                            //    controller: mailController),
                                            textInputAction: TextInputAction.next,
                                            //onFieldSubmitted: (_) =>
                                            //    passwordFocusNode.requestFocus(),
                                          ),                            
                            const SizedBox(height: 20),
              
                            IconButton(
                              onPressed:                
                                _formKey.currentState?.validate() == true ?
                                () async {
                                  double value = double.parse(valueController.text);
                                  final newTransaction = FinancialTransaction(
                                    type: type!, 
                                    name: nameController.text, 
                                    value: value, 
                                    date: date,
                                    category: categoryController.text,
                                    walletID: walletID!,
                                  );
                                  bloc.add(OnNewTransaction(newTransaction: newTransaction)); 
                                } : null,
                              icon: const Icon(Icons.add),
                            ),
              
                            IconButton(
                                onPressed: (() {
                                  inputClear;
                                  Modular.to.popAndPushNamed(ConstsRoutes.homePageModule);
                                }),
                              icon: const Icon(Icons.home),          
                              ),
              
                            IconButton(
                                onPressed: (() {
                                  inputClear;
                                  Modular.to.popAndPushNamed(ConstsRoutes.transactionsPage);
                                }),
                              icon: const Icon(Icons.arrow_back),          
                              )
              
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          } else if (state is CreateTransactionStateLoading) {
            log(state.toString());
            return const ShowLoader();

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


/*
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
*/
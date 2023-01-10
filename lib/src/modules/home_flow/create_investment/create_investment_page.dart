import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_investment/create_investment_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/widgets/custom_input_form/custom_text_form_field.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/investments/investment_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class CreateInvestmentPage extends StatefulWidget {
  const CreateInvestmentPage({super.key});

  @override
  State<CreateInvestmentPage> createState() => _CreateInvestmentPageState();
}

class _CreateInvestmentPageState extends State<CreateInvestmentPage> {

  final bloc = Modular.get<CreateInvestmentBloc>();

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final initialValueController = TextEditingController();
  final incomeRateByDayController = TextEditingController();

  get inputClear {
    nameController.clear();
    initialValueController.clear();
    incomeRateByDayController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CreateInvestmentBloc, CreateInvestmentState> (
        bloc: bloc,
        builder: (context, state) {
          if (state is CreateInvestmentStateEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Registrar investimento'),
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
                                            label: 'Valor inicial',
                                            controller: initialValueController,
                                            hintText: 'Nome',
                                            validator: (value) {
                                                          if (value != null &&
                                                              value.isNotEmpty &&
                                                              double.tryParse(value) != null) {
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
                                            label: 'Taxa diária de rendimento',
                                            controller: initialValueController,
                                            hintText: 'Nome',
                                            validator: (value) {
                                                          if (value != null &&
                                                              value.isNotEmpty &&
                                                              double.tryParse(value) != null) {
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
                                  final newInvestment = InvestmentModel(
                                    name: nameController.text, 
                                    initialDate: Timestamp.now(), 
                                    initialValue: double.parse(initialValueController.text),
                                    incomeRateByDay: double.parse(incomeRateByDayController.text),
                                  );
                                  () async {
                                    bloc.add(OnNewInvestment(newInvestment: newInvestment));
                                  };                                 
                                  Modular.to.popAndPushNamed(ConstsRoutes.investmentsPage);                         
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
                                  Modular.to.popAndPushNamed(ConstsRoutes.investmentsPage);
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

          } else if (state is CreateInvestmentStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is CreateInvestmentStateError) {
            inputClear;
            log(state.toString());
            log(state.erro.toString());
            log(state.runtimeType.toString());
            return Text(state.erro.toString());

          }
          return Container();
        }
      )
    );
  }
}
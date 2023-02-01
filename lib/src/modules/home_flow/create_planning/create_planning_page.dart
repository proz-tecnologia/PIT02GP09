import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_planning/create_planning_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/widgets/custom_input_form/custom_text_form_field.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/plannings/planning_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class CreatePlanningPage extends StatefulWidget {
  const CreatePlanningPage({super.key});

  @override
  State<CreatePlanningPage> createState() => _CreatePlanningPageState();
}

class _CreatePlanningPageState extends State<CreatePlanningPage> {

  final bloc = Modular.get<CreatePlanningBloc>();

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final finalDateController = TextEditingController();

  DateTime finalDate = DateTime.now();

  get inputClear {
    nameController.clear();
    valueController.clear();
    finalDateController.clear();
  }

  @override
  void initState() {
    super.initState();
    bloc.add(OnCreatePlanningInitState());    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CreatePlanningBloc, CreatePlanningState> (
        bloc: bloc,
        listener: (context, state) {
          if (state is CreatePlanningStateSuccess) {
            Modular.to.popAndPushNamed(ConstsRoutes.planningsPage);
          }
        },
        builder: (context, state) {
          if (state is CreatePlanningStateEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Registrar planejamento'),
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
                                            label: 'Valor',
                                            controller: valueController,
                                            hintText: 'valor',
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

                            ElevatedButton(
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context, 
                                  initialDate: finalDate, 
                                  firstDate: DateTime(1900), 
                                  lastDate: DateTime(2100),
                                  );
                                if (newDate != null) {
                                  setState(() => finalDate = newDate);
                                  setState(() => finalDateController.text = newDate.toString());
                                }
                              }, 
                              child: const Text('Selecionar data limite'),
                            ),

                            CustomTextFormField(
                                            enabled: false,
                                            prefixIcon: null,
                                            label: 'Data limite',
                                            controller: finalDateController,
                                            hintText: 'Data limite',
                                            validator: (value) {
                                                          if (value != null &&
                                                              value.isNotEmpty &&
                                                              DateTime.tryParse(value) != null) {
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
                                  final newPlanning = PlanningModel(
                                    name: nameController.text,
                                    value: double.parse(valueController.text), 
                                    finalDate: Timestamp.fromDate(finalDate),
                                  );
                                  bloc.add(OnNewPlanning(newPlanning: newPlanning));                         
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
                                  Modular.to.popAndPushNamed(ConstsRoutes.planningsPage);
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

          } else if (state is CreatePlanningStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is CreatePlanningStateError) {
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
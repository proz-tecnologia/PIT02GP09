import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/create_wallet/create_wallet_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/wallet_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {

  final bloc = Modular.get<CreateWalletBloc>();

  final _formKey = GlobalKey<FormState>();
  
  final nameController = TextEditingController();
  final valueController = TextEditingController();

  get inputClear {
    nameController.clear();
    valueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CreateWalletBloc, CreateWalletState> (
        bloc: bloc,
        builder: (context, state) {
          if (state is CreateWalletStateEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Registrar carteira'),
                automaticallyImplyLeading: false,
                ),
              body: Form(
                key: _formKey,
                onChanged: () => setState(() {}),
                child: ListView(
                  children: [                    

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
                          final newWallet = WalletModel(
                            name: nameController.text, 
                            value: value,
                            );
                          bloc.add(OnNewWallet(newWallet: newWallet));
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
                          Modular.to.pushReplacementNamed(ConstsRoutes.walletsPage);
                        }),
                      icon: const Icon(Icons.arrow_back),          
                      )

                  ],
                ),
              ),
            );

          } else if (state is CreateWalletStateLoading) {
            log(state.toString());
            return const ShowLoader();
            
          } else if (state is CreateWalletStateSuccess) {
            inputClear;
            log(state.toString());
            Modular.get<HomeBloc>().add(OnHomePageEmpty());
            Modular.to.pushReplacementNamed(ConstsRoutes.walletsPage);

          } else if (state is CreateWalletStateError) {
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
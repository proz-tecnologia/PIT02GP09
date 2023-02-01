import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';

class SignOutDialog extends StatelessWidget {

  final bloc = Modular.get<HomeBloc>();

  SignOutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Configurações'),
      shape: RoundedRectangleBorder(
			  borderRadius: BorderRadius.circular(16.0),
		  ),
      children: [
              IconButton(
              onPressed: () {                
                Modular.get<HomeBloc>().add(OnHomePageLogout());
                Modular.to.pop();
                Modular.to.navigate(ConstsRoutes.signUpPage);
              }, 
              icon: const Text('SignOut'),
              ),
      ]    
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';

class HomepageAppBarSettingsButton extends StatelessWidget {
  const HomepageAppBarSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            minimum: const EdgeInsets.only(right: 15.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Modular.get<HomeBloc>().add(OnHomePageLogout());
                    Modular.to.navigate(ConstsRoutes.signUpPage);
                  }, 
                  icon: const Icon(
                    size: 40.0,
                    Icons.logout,
                    ),
                  ),
                  const Text('Logout'),
              ],
            ),
            );
  }
}
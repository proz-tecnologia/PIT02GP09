import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_appbar_widgets/month_button.dart';

class HomepageAppBarTitle extends StatefulWidget {  

  const HomepageAppBarTitle({
    super.key,
  });

  @override
  State<HomepageAppBarTitle> createState() => _HomepageAppBarTitleState();
}

class _HomepageAppBarTitleState extends State<HomepageAppBarTitle> {

  final bloc = Modular.get<HomeBloc>();
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded (
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,         
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo, ${bloc.userModel!.userModelName}!',
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const MonthButton(),
                      ],
                    ),
                  ],             
                ),
            ),
          ],
        ),
        );
  }
}
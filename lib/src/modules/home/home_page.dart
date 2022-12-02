// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login/login_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login/login_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = Modular.get<HomeBloc>();
  String? name;
  late UserModel user;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.repo.getUserSession().then((value) => setState(() {
          name = value;
        }));

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page  Olá $name'),
        actions: [
          IconButton(
              onPressed: () {
                user = UserModel(
                    name: 'name', email: 'email', password: 'password');
                Modular.get<LoginBloc>().add(OnLogoutPressed(user));
                Modular.get<LoginBloc>().add(OnLoginStateEmpty(user));
                Modular.to.navigate(ConstsRoutes.loginPage);
                // Navigator.popAndPushNamed(context, ConstsRoutes.loginPage);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is HomeStateEmpty) {
              return const Center(child: SizedBox());
            }

            return const SizedBox.shrink();
          }),
    );
  }
}

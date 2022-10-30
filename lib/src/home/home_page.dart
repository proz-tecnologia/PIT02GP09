import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/routes/consts_routes.dart';

import '../login_flow/sign_up/sign_up_controller.dart';

class HomeArguments {
  final String name;

  const HomeArguments({required this.name});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SignUpController controller;
  @override
  void initState() {
    controller = SignUpController(
      onUpdate: () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as HomeArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page, Olá ${args.name}!'),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
                Navigator.popAndPushNamed(context, ConstsRoutes.loginPage);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}

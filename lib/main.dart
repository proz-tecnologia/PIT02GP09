import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app_widget.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ModularApp(
      module: AppModule(sharedPref:sharedPreferences),
      child: const AppWidget(),
    ),
  );
}

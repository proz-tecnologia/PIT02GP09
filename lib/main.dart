import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ModularApp( // replaces MyApp()
      module: AppModule(sharedPref:sharedPreferences), // module with binds and routes
      child: const AppWidget(), // has app settings
    ),
  );
}

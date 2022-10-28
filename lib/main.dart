import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/utils/custom_theme_data.dart';

import 'routes/consts_routes.dart';
import 'routes/routes.dart';
import 'utils/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ConstsRoutes.rootRoute,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      title: Consts.titleMain,
      theme: CustomThemeData.themeData,

      // home: const Ccontainer(),
    );
  }
}

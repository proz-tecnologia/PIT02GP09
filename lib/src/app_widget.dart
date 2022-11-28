import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'utils/consts.dart';
import 'utils/custom_theme_data.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // initialRoute: ConstsRoutes.rootRoute,
      // routes: Routes.routes,
      title: Consts.titleMain,
      theme: CustomThemeData.themeData,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
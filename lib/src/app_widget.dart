import 'package:flutter/material.dart';

import 'modules/routes/consts_routes.dart';
import 'modules/routes/routes.dart';
import 'utils/consts.dart';
import 'utils/custom_theme_data.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ConstsRoutes.rootRoute,
      routes: Routes.routes,
      title: Consts.titleMain,
      theme: CustomThemeData.themeData,
    );
  }
}
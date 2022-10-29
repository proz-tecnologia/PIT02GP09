import 'package:flutter/material.dart';

import 'routes/consts_routes.dart';
import 'routes/routes.dart';
import 'utils/consts.dart';
import 'utils/custom_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

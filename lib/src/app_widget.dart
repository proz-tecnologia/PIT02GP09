import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/utils/consts.dart';
import 'shared/utils/custom_theme_data.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      init();
      Firebase.initializeApp();
    });    
    super.initState();
  }

  Future<void> init() async {
    final instance = await Firebase.initializeApp(
      name: 'my-finance-app',
      options: const FirebaseOptions(
        apiKey: "AIzaSyATfXoNUm_N08duK5a4qgO6kM6voHxpo5U", 
        appId: "1:335634638705:android:218ca6619eba86285438d0", 
        messagingSenderId: "335634638705", 
        projectId: "my-finance-app-3e9e9",
      ),
    );
    FirebaseCrashlytics.instance.crash();
    log('[LOG] ${instance.name}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Consts.titleMain,
      theme: CustomThemeData.themeData,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home_flow_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

import 'home_repository_mock.dart';
import 'sharedpreferences_mock.dart';

void main() {
  group(
    "home page",
    () {
      const userID = '1234';
      final repository = HomePageRepositoryMock();
      setUp(() async {      
        WidgetsFlutterBinding.ensureInitialized();
        Firebase.initializeApp();

        initModules([
          AppModule(sharedPref: SharedPrefMock()),
          HomePageModule(sharedPref: SharedPrefMock()),
          ], replaceBinds: [
          Bind.instance<HomePageRepository>(repository),
        ]);

        when(() => repository.getUserData(userID: userID))
        .thenAnswer((_) => Future.value(UserModel(
          userModelID: userID,
          userModelName: 'joao',
          userModelDocID: userID,
        )));

        when(() => repository.getMonthPlanning(userID: userID, currentMonth: 1))
        .thenAnswer((_) => Future.value(100));        
      });
      
      testWidgets(
        'when loading',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: HomePage()
            ),
          );
          await tester.pump();
          expect(find.byType(ShowLoader), findsNothing);
        }
      );
    },
  );
}
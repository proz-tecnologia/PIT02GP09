import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home_flow_module.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/wallets/wallets_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';
import '../home/sharedpreferences_mock.dart';
import 'wallets_repository_mock.dart';

void main () {
  group(
    'wallets page',
    () {
      const userID = '1234';
      final repository = WalletsRepositoryMock();
      setUp(() async {
        
        initModules([
          AppModule(sharedPref: SharedPrefMock()),
          HomePageModule(sharedPref: SharedPrefMock()),
          ], replaceBinds: [
          Bind.instance<WalletsRepository>(repository),
        ]);

        when(() => repository.getUserData(userID: userID))
        .thenAnswer((_) => Future.value(UserModel(
          userModelID: userID,
          userModelName: 'joao',
          userModelDocID: userID,
        )));

        when(() => repository.getWallets(userID: userID))
        .thenAnswer((_) => Future.any([]));        
      });
      
      testWidgets(
        'when loading',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: WalletsPage(),
            ),
          );
          await tester.pump();
          expect(find.byType(ShowLoader), findsNothing);
        }
      );
    },
  );
}
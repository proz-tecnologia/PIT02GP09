import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

import 'wallets_repository_mock.dart';

void main() {
  group(
    'wallet repository', 
    () {
      test( // just testing the test
        'getUserData',
        () async {
          final repository = WalletsRepositoryMock();
          const userID = '123';
          final user = UserModel(
              userModelID: userID,
              userModelName: 'joao',
              userModelDocID: userID,
            );
          when(() => repository.getUserData(userID: userID))
          .thenAnswer((_) => Future.value(user));
        

        final newuser = await repository.getUserData(userID: userID);

        expect(newuser.userModelName, equals('joao'));
        // expect(newuser.userModelName, equals('pedro'));
        
        },
      );
    },
  );
}
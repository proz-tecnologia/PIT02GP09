import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class AppRepository extends Repository {

  List<UserModel> usersLogin = <UserModel>[];

  AppRepository({required super.sharedPreferences}) {
    init();
  }

  Future<void> init();
  Future<List<UserModel>> getUser();
  Future<String> getUserSession();

  
}
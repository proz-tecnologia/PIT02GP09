
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class LoginFlowRepository extends Repository {

  List<UserModel> usersLogin = <UserModel>[];

  LoginFlowRepository({required super.sharedPreferences});

  Future<void> init();
  Future<void> addUser({required UserModel user});
  Future<List<UserModel>> getUser();
  Future<String> getUserSession();
}
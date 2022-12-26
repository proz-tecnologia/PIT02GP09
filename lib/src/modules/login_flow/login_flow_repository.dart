import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/login_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class LoginFlowRepository extends Repository {

  List<LoginModel> usersLogin = <LoginModel>[];

  LoginFlowRepository({required super.sharedPreferences});

  Future<void> init();
  Future<void> addUser({required LoginModel user});
  Future<void> createUserData({required UserModel user});
  Future<List<LoginModel>> getUser();
  Future<String> getUserSession();
}
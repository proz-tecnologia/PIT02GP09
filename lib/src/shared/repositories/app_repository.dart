import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/login_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class AppRepository extends Repository {

  List<LoginModel> usersLogin = <LoginModel>[];

  AppRepository({required super.sharedPreferences}) {
    init();
  }

  Future<void> init();
  Future<List<LoginModel>> getUser();
  Future<String> getUserSession();

  
}
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class HomeRepository extends Repository {

  List<UserModel> usersLogin = <UserModel>[];

  HomeRepository({required super.sharedPreferences});

  
}
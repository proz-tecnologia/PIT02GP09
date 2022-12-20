import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

class HomeRepositoryImpl implements HomeRepository {

  @override
  List<UserModel> usersLogin = <UserModel>[];
  @override
  final SharedPreferences sharedPreferences;

  HomeRepositoryImpl({required this.sharedPreferences});

}
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/repositories/repository.dart';

abstract class HomePageRepository extends Repository {

  HomePageRepository({required super.sharedPreferences});

  Future<UserModel> getUserData({required String userID});

}
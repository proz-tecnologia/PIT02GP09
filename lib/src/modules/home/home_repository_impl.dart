import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home/homepage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageRepositoryImpl implements HomePageRepository {

  @override
  final SharedPreferences sharedPreferences;

  HomePageRepositoryImpl({required this.sharedPreferences});
  
}
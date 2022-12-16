
import 'package:shared_preferences/shared_preferences.dart';

abstract class Repository {
  final SharedPreferences sharedPreferences;

  Repository({
    required this.sharedPreferences,
  });
  
}

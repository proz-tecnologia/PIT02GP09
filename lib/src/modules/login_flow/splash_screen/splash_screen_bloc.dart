import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/repositories/repository.dart';
import '../../../shared/utils/shared_preferences_keys.dart';
import 'splash_screen_event.dart';
import 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final Repository repository;
  late final SharedPreferences sharedPreferences;

  SplashScreenBloc({required this.repository, required this.sharedPreferences})
      : super(SplashScreenStateEmpty()) {
    on<OnIsAuthenticated>(isAuthenticated);
  }

  Future<void> isAuthenticated(
    SplashScreenEvent event,
    Emitter<SplashScreenState> emitter,
  ) async {
    final String? userSession =
        sharedPreferences.getString(SharedPreferencesKeys.userSession);
    if (userSession != null && userSession.isNotEmpty) {
      emitter(SplashScreenStateAuthenticated());
    } else {
      emitter(SplashScreenStateUnauthenticated());
    }
  }
}

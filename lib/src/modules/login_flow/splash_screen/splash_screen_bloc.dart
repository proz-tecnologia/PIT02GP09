import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    on<OnIsAuthenticated>(isAuthenticated); // class OnIsAuthenticated extends SplashScreenEvent {}
  }

  Future<void> setup() async {
    await initializeFirebase();
  }

  Future<FirebaseApp> initializeFirebase() async {
    return await Firebase.initializeApp(
      name: 'my-finance-app',
      options: const FirebaseOptions(
        apiKey: "AIzaSyATfXoNUm_N08duK5a4qgO6kM6voHxpo5U", 
        appId: "1:335634638705:android:218ca6619eba86285438d0", 
        messagingSenderId: "335634638705", 
        projectId: "my-finance-app-3e9e9",
      ),
    );
  }

  Future<void> isAuthenticated(
    SplashScreenEvent event,
    Emitter<SplashScreenState> emitter,
  ) async {
    await initializeFirebase();
    // check on Firebase
    User? userFirebase = FirebaseAuth.instance.currentUser;
    // check on repository
    final String? userSession =
        sharedPreferences.getString(SharedPreferencesKeys.userSession);
    if ((userSession != null && userSession.isNotEmpty) &&
        userFirebase != null) {
      emitter(SplashScreenStateAuthenticated());
    } else {
      emitter(SplashScreenStateUnauthenticated());
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/app_controller.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/utils/shared_preferences_keys.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginFlowRepository repository;
  final SharedPreferences sharedPreferences;

  LoginBloc({
    required this.repository,
    required this.sharedPreferences,
  }) : super(
          LoginStateEmpty(),
        ) {
    on<OnLoginPressed>(newLoginFirebase); // using Firebase login option
    on<OnLogoutPressed>(logout);
    on<OnLoginStateEmpty>(empty);
  }

  FirebaseAuth get _auth => FirebaseAuth.instance;  

  Future<void> newLoginFirebase(LoginEvent event, Emitter<LoginState> emitter) async {
    try {
      emitter(LoginStateLoading());

      final userCredential = await _auth.signInWithEmailAndPassword(
                                email: event.user!.email, 
                                password: event.user!.password,
                                );
      Modular.get<AppController>().setUser(userCredential.user!);
      if (userCredential.user != null) {
        emitter(LoginStateSuccess());
      } else {
        throw Exception();
      }
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      emitter(LoginStateError(erro: e));
    }
  }


  Future<bool> logout(LoginEvent event, Emitter<LoginState> emitter) async {
    return await sharedPreferences.remove(SharedPreferencesKeys.userSession);
  }

  empty(LoginEvent event, Emitter<LoginState> emitter) {
    log(state.toString());
    emitter(LoginStateEmpty());
  }
}

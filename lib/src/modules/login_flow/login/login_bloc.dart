// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../../../shared/utils/shared_preferences_keys.dart';
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

      final result = await _auth.signInWithEmailAndPassword(
                                email: event.user!.email, 
                                password: event.user!.password,
                                );
      if (result.user != null) {
        emitter(LoginStateSuccess());
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      emitter(LoginStateError(erro: e));
    }
  }

  Future<void> logout(LoginEvent event, Emitter<LoginState> emitter) async {
    await FirebaseAuth.instance.signOut();
  }

  void empty(LoginEvent event, Emitter<LoginState> emitter) {
    emitter(LoginStateEmpty());
  }
}

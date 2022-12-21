import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login_flow_repository.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final LoginFlowRepository repository;
  late final SharedPreferences sharedPreferences;  

  SignUpBloc({required this.repository, required this.sharedPreferences})
      : super(SignUpStateEmpty()) {
    on<OnCreateNewUserPressed>(createNewUser);
    on<OnSignUpEmpty>(signUpEmpty);
  }

  FirebaseAuth get _auth => FirebaseAuth.instance;

  Future<void> createNewUser(
      SignUpEvent event, Emitter<SignUpState> emitter) async {
    try {
      emitter(SignUpStateLoading());
      await Future.delayed(const Duration(seconds: 3));
      // authenticate new user on Firebase
      await _auth.createUserWithEmailAndPassword(
        email: event.getUser!.email, 
        password: event.getUser!.password,
        );      
      await _auth.currentUser!.updateDisplayName(event.getUser!.name);
      sharedPreferences.setString(SharedPreferencesKeys.userSession, event.getUser!.name);
      await _auth.currentUser!.sendEmailVerification();
        // add function to add user on Firebase Firestore, something like:
        // FirebaseFirestore.instance.collection('Users').add(event.getUser.toMap());
      // add new user to repository
      repository.addUser(user: event.getUser!);
      final user = await repository.getUser();
      emitter(SignUpStateSuccess(user: user));
    } on Exception catch (e) {
      emitter(SignUpStateError(erro: e));
    }
  }

  signUpEmpty(SignUpEvent event, Emitter<SignUpState> emitter) async {
    emitter(SignUpStateEmpty());
  }
}

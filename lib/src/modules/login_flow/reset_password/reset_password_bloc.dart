// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/repositories/repository.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {

  final SharedPreferences sharedPreferences;
  Repository repository;
  FirebaseAuth get _auth => FirebaseAuth.instance; // todo: create absctraction class
  FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance; // todo: create absctraction class

  ResetPasswordBloc({
    required this.sharedPreferences,
    required this.repository,
  }) : super(ResetPasswordStateEmpty()) {
    on<OnResetPasswordPressed>(resetPasswordPressed);
  }

  Future<void> resetPasswordPressed(
      ResetPasswordEvent event, Emitter<ResetPasswordState> emitter) async {
    try {
      emitter(ResetPasswordStateLoading());
      await Future.delayed(const Duration(seconds: 3));
      await _auth.sendPasswordResetEmail(email: _auth.currentUser!.email!);
      emitter(ResetPasswordStateSuccess());
    } catch (e, s) {
      _crashlytics.recordError(e, s);
      emitter(ResetPasswordStateError(erro: e.toString()));
    }
  }


}

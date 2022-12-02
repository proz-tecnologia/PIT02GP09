// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/repositories/repository.dart';
import '../../../shared/utils/consts.dart';
import '../../../shared/utils/shared_preferences_keys.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final SharedPreferences sharedPreferences;

  LoginBloc({
    required this.repository,
    required this.sharedPreferences,
  }) : super(
          LoginStateEmpty(),
        ) {
    on<OnLoginPressed>(newLogin);
    on<OnLogoutPressed>(logout);
    on<OnLoginStateEmpty>(empty);
  }

  Future<bool> newLogin(LoginEvent event, Emitter<LoginState> emitter) async {
    try {
      emitter(LoginStateLoading());

      await Future.delayed(const Duration(seconds: 3));

      final user = await repository.getUser();
      if (user.isEmpty) {
        emitter(LoginStateError(erro: Consts.textLoginStateErrorGetUser ));
      }

      for (var element in user) {
        if (element.email.trim() == event.user!.email.trim()) {
         
          if (element.password.trim() == event.user!.password.trim()) {
            sharedPreferences.setString(
                SharedPreferencesKeys.userSession, element.name.trim());
            final userSession = await repository.getUserSession();

            emitter(LoginStateSuccess(user: userSession));
            return true;
          } else {
            emitter(LoginStateError(erro: Consts.textLoginStateErrorPassEmail));
            return false;
          }
        }
      }
    } on Exception catch (e) {
      emitter(LoginStateError(erro: e));
      return false;
    }
    return false;
  }

  Future<bool> logout(LoginEvent event, Emitter<LoginState> emitter) async {
    return await sharedPreferences.remove(SharedPreferencesKeys.userSession);
  }

  empty(LoginEvent event, Emitter<LoginState> emitter) {
    emitter(LoginStateEmpty());
  }
}

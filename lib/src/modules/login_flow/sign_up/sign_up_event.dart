// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/login_model.dart';

abstract class SignUpEvent {
  final LoginModel? _user;
  SignUpEvent(
    this._user,
  );

  LoginModel? get getUser => _user;
  set setUser(LoginModel user) => _user;
}

class OnCreateNewUserPressed extends SignUpEvent {
  OnCreateNewUserPressed(super.user);
}

class OnSignUpEmpty extends SignUpEvent {
  OnSignUpEmpty(super.user);
}

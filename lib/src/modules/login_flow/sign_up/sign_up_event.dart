// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';

abstract class SignUpEvent {
  final UserModel? _user;
  SignUpEvent(
     this._user,
  );

  UserModel? get getUser => _user;
  set setUser(UserModel user) => _user;
}
class OnCreateNewUserPressed extends SignUpEvent{
  OnCreateNewUserPressed(super.user);
  
}
class OnSignUpEmpty extends SignUpEvent{
  OnSignUpEmpty(super.user);
  
}
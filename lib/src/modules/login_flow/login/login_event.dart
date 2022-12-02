import '../../../shared/models/user_model.dart';

abstract class LoginEvent {
  final UserModel? _user;

  LoginEvent(this._user);

  UserModel? get user => _user;
}

class OnLogoutPressed extends LoginEvent {
  OnLogoutPressed(super.user);
}

class OnLoginPressed extends LoginEvent {
  OnLoginPressed(super.user);
}
class OnLoginStateEmpty extends LoginEvent {
  OnLoginStateEmpty(super.user);
}

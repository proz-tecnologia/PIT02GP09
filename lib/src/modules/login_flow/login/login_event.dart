import '../../../shared/models/login_model.dart';

abstract class LoginEvent {
  final LoginModel? _user;

  LoginEvent(this._user);

  LoginModel? get user => _user;
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

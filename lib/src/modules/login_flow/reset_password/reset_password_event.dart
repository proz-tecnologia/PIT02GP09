// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/login_model.dart';

abstract class ResetPasswordEvent {
  LoginModel user;
  ResetPasswordEvent({
    required this.user,
  });
}

class OnResetPasswordPressed extends ResetPasswordEvent {
  OnResetPasswordPressed({required super.user});
}

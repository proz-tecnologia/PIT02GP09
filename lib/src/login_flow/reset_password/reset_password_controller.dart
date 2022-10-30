import 'reset_password_state.dart';

class ResetPasswordController {
  ResetPasswordState state = ResetPasswordStateEmpty();

  Future<ResetPasswordState> login({
    required String mail,
    required String password,
  }) async {
    

    await Future.delayed(const Duration(seconds: 3));

    
    return ResetPasswordStateSuccess();
  }
}

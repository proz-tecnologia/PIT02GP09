import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/login/login_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/login_flow/sign_up/sign_up_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/page_state.dart';
import '../../../../shared/utils/consts.dart';
import '../text_richinfo_create_account.dart';
import '../text_richinfo_forgot_password.dart';
import 'custom_dialog.dart';

class CustomDialogStateless extends StatelessWidget {
  CustomDialogStateless({
    Key? key,
    required this.stateType,
    required this.theme,
    required this.formkey,
    required this.inputClear,
    this.error,
  }) : super(key: key) {
    if (error != null) {
      if (error == Consts.emailAlreadyInUseError) {
        message = Consts.textCustomDialogEmailAlreadyInUse;
      }
    } else {
      if (stateType is LoginStateError) {
        message = Consts.textCustomDialogDescriptionLogin;
      } else if (stateType is SignUpStateError) {
        message = Consts.textCustomDialogDescriptionSignUp;
      } else {
        message = Consts.textCustomDialogDescriptionDefault;
      }
    }
  }

  final PageState stateType;
  late final String? error;
  final ThemeData theme;
  final GlobalKey<FormState> formkey;
  final Function()? inputClear;
  late final String message;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      wid1: TextRichInfoForgotPassword(
        theme: theme,
        formkey: formkey,
        inputClear: inputClear,
      ),
      wid2: TextRichInfoCreateAccount(
        theme: theme,
        formkey: formkey,
        inputClear: inputClear,
      ),
      title: Consts.textCustomDialogTitle,
      description: message,
      buttonText: Consts.textCustomDialogButtonText,
    );
  }
}

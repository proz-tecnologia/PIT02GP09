// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/login_flow/reset_password/reset_password_page.dart';
import 'package:projeto_gestao_financeira_grupo_nove/utils/mixins/validations_mixin.dart';

import '../../../routes/consts_routes.dart';
import '../../../utils/consts.dart';
import '../../../utils/shared_preferences_keys.dart';
import '../../models/user_model.dart';
import '../reset_password/reset_password_controller.dart';
import '../sign_up/sign_up_controller.dart';
import 'custom_dialog/custom_dialog.dart';
import 'custom_input_form/text_rich_info.dart';
import 'custom_show_alert_dialog.dart';
import 'text_richinfo_create_account.dart';

class TextRichInfoForgotPassword extends StatefulWidget with ValidationMixin {
  const TextRichInfoForgotPassword({
    Key? key,
    required this.theme,
    required this.resetPasswordController,
    required this.formkey,
    required this.inputClear,
  }) : super(key: key);

  final ThemeData theme;
  final ResetPasswordController resetPasswordController;
  final GlobalKey<FormState> formkey;
  final Function()? inputClear;

  @override
  State<TextRichInfoForgotPassword> createState() =>
      _TextRichInfoForgotPasswordState();
}

class _TextRichInfoForgotPasswordState
    extends State<TextRichInfoForgotPassword> {
  late final SignUpController signUpController;

  @override
  void initState() {
    signUpController = SignUpController(onUpdate: () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextRichInfo(
      textLink: Text(
        Consts.textForgotPassword,
        style: widget.theme.textTheme.labelMedium,
      ),
      link: () async {
        showDialog(
          context: context,
          builder: (context) => const CustomShowAlertDialog(),
        ).then((email) async {
          if (email != null) {
            UserModel? user = await validEmailSharedPref(
              mail: email,
              sharedPreferencesKeys: SharedPreferencesKeys.users,
            );

            if (user != null) {
              final userResetPassword = await Navigator.pushNamed(
                (context),
                ConstsRoutes.resetPasswordPage,
                arguments: ResetPasswordArguments(
                  name: user.name,
                  email: user.email,
                ),
              );

              if (userResetPassword != null) {
                widget.resetPasswordController
                    .resetPassword(user: userResetPassword as UserModel);
              }
              widget.formkey.currentState!.reset();
              widget.inputClear;
            } else {
              return showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  title: Consts.textTitleTextRichinfoForgotPassword,
                  description: Consts.textDescriptionTextRichinfoForgotPassword,
                  wid1: TextRichInfoCreateAccount(
                    theme: widget.theme,
                    signUpController: signUpController,
                    formkey: widget.formkey,
                    inputClear: widget.inputClear,
                  ),
                  buttonText: Consts.textCustomDialogButtonText,
                ),
              );
            }
          }
        });
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../routes/consts_routes.dart';
import '../../../utils/consts.dart';
import '../../models/user_model.dart';
import '../sign_up/sign_up_controller.dart';
import 'custom_input_form/text_rich_info.dart';

class TextRichInfoCreateAccount extends StatelessWidget {
  const TextRichInfoCreateAccount({
    Key? key,
    required this.theme,
    required this.signUpController,
    required this.formkey,
    required this.inputClear,
  }) : super(key: key);

  final ThemeData theme;
  final SignUpController signUpController;
  final GlobalKey<FormState> formkey;
  final Function()? inputClear;

  @override
  Widget build(BuildContext context) {
    return TextRichInfo(
        text: Text(Consts.textInteractionCreateAccount,
            style: theme.textTheme.labelSmall),
        textLink: Text(Consts.textInteractionCreateAccountLink,
            style: theme.textTheme.labelMedium),
        link: () async {
          final newUser = await Navigator.pushNamed(
            context,
            ConstsRoutes.signUpPage,
          );
          if (newUser != null) {
            signUpController.addUser(user: newUser as UserModel);
          }
          formkey.currentState!.reset();
          inputClear;
        });
  }
}

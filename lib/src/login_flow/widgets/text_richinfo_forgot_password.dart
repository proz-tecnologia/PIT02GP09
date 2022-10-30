import 'package:flutter/material.dart';

import '../../../routes/consts_routes.dart';
import '../../../utils/consts.dart';
import 'custom_input_form/text_rich_info.dart';

class TextRichInfoForgotPassword extends StatelessWidget {
  const TextRichInfoForgotPassword({
    Key? key,
    required this.theme,
    required this.formkey,
    required this.inputClear,
  }) : super(key: key);

  final ThemeData theme;
  final GlobalKey<FormState> formkey;
  final Function()? inputClear;

  @override
  Widget build(BuildContext context) {
    return TextRichInfo(
      textLink: Text(
        Consts.textForgotPassword,
        style: theme.textTheme.labelMedium,
      ),
      link: () {
        Navigator.pushNamed(context, ConstsRoutes.resetPasswordPage);
        formkey.currentState!.reset();
        inputClear;
      },
    );
  }
}
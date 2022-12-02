import 'package:flutter/material.dart';

import '../../../../utils/consts.dart';
import '../text_richinfo_create_account.dart';
import '../text_richinfo_forgot_password.dart';
import 'custom_dialog.dart';

class CustomDialogStateless extends StatelessWidget {
  const CustomDialogStateless({
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
      description: Consts.textCustomDialogDescription,
      buttonText: Consts.textCustomDialogButtonText,
    );
  }
}

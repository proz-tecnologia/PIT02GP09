import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../routes/consts_routes.dart';
import '../../../shared/models/user_model.dart';
import '../../../shared/utils/consts.dart';
import '../sign_up/sign_up_bloc.dart';
import '../sign_up/sign_up_event.dart';
import 'custom_input_form/text_rich_info.dart';

class TextRichInfoCreateAccount extends StatelessWidget {
  const TextRichInfoCreateAccount({
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
    final bloc = Modular.get<SignUpBloc>();
    return TextRichInfo(
        text: Text(Consts.textInteractionCreateAccount,
            style: theme.textTheme.labelSmall),
        textLink: Text(Consts.textInteractionCreateAccountLink,
            style: theme.textTheme.labelMedium),
        link: () async {
          final newUser = await Modular.to.pushReplacementNamed(
            ConstsRoutes.signUpPage,
          );
          // // final newUser = await Navigator.pushNamed(
          // //   context,
          // //   ConstsRoutes.signUpPage,
          // // );
          if (newUser != null) {
            Modular.get<SignUpBloc>().add(OnSignUpEmpty(newUser as UserModel));
            bloc.add(OnCreateNewUserPressed(newUser));
            // signUpController.addUser(user: newUser as UserModel);
          }

          // formkey.currentState!.reset();
          // inputClear;
        });
  }
}

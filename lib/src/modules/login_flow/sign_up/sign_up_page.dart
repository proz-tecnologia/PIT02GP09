import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../utils/consts.dart';
import '../../../utils/mixins/validations_mixin.dart';
import '../../models/user_model.dart';
import '../widgets/custom_input_form/confirm_password_custom_text_form_field.dart';
import '../widgets/custom_input_form/custom_elevated_button.dart';
import '../widgets/custom_input_form/custom_text_form_field.dart';
import '../widgets/custom_input_form/input_clear.dart';
import '../widgets/custom_input_form/password_custom_text_form_field.dart';
import '../widgets/custom_input_form/text_rich_info.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> with ValidationMixin {
  final formkey = GlobalKey<FormState>();

  //Controle com entrada de parametro "text" com valores para teste
  final nameController = TextEditingController(text: 'Rodrigo Oliveira');
  final mailController = TextEditingController(text: 'teste@teste.com');
  final passwordController = TextEditingController(text: 'Rinex1#');
  final confirmPasswordController = TextEditingController(text: 'Rinex1#');
  final formValidVN = ValueNotifier<bool>(false);

//Faz o controle de foco
  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final savedFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  get inputClear {
    nameController.clear();
    mailController.clear;
    passwordController.clear;
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Form(
                  key: formkey,
                  onChanged: () {
                    setState(() {
                      formValidVN.value =
                          formkey.currentState?.validate() ?? false;
                    });
                  },
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 170,
                                  width: 170,
                                  child: Image(
                                    image:
                                        AssetImage(Consts.pathImageSignUpPage),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Consts.textInteraction1SignUp,
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  Consts.textInteraction2SignUp,
                                  style: theme.textTheme.labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              prefixIcon: const Icon(Icons.badge),
                              label: Consts.textNameSignUp,
                              controller: nameController,
                              hintText: Consts.textHintTextNameSignUp,
                              validator: isEmpty,
                              suffix: InputClear(controller: nameController),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  mailFocusNode.requestFocus(),
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              focusNode: mailFocusNode,
                              prefixIcon: const Icon(Icons.mail),
                              label: Consts.textEmail,
                              controller: mailController,
                              hintText: Consts.textHintTextEmail,
                              validator: validateMail,
                              suffix: InputClear(controller: mailController),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  passwordFocusNode.requestFocus(),
                            ),
                            const SizedBox(height: 10),
                            PasswordCustomTextFormField(
                              label: Consts.textPasswordSignUp,
                              hintText: Consts.textHintTextPasswordSignUp,
                              password: passwordController,
                              focusNode: passwordFocusNode,
                              suffix: InputClear(
                                controller: passwordController,
                              ),
                              onFieldSubmitted: (_) =>
                                  confirmPasswordFocusNode.requestFocus(),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10),
                            ConfirmPasswordCustomTextFormField(
                              label: Consts.textConfirmPasswordSignUp,
                              hintText:
                                  Consts.textHintTextConfirmPasswordSignUp,
                              password: passwordController,
                              focusNode: confirmPasswordFocusNode,
                              confirmPassword: confirmPasswordController,
                              suffix: InputClear(
                                controller: confirmPasswordController,
                              ),
                              onFieldSubmitted: (_) =>
                                  savedFocusNode.requestFocus(),
                              textInputAction: TextInputAction.go,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: formValidVN,
                  builder: (_, formValid, child) {
                    return CustomElevatedButton(
                      label: Consts.textSignUp,
                      savedFocusNode: savedFocusNode,
                      onPressed: !formValid
                          ? null
                          : () async {
                              if (formkey.currentState != null &&
                                  formkey.currentState!.validate()) {
                                final newUser = UserModel(
                                    name: nameController.text,
                                    email: mailController.text,
                                    password: passwordController.text);

                                Modular.to.pop(newUser);
                                // Navigator.pop(context, newUser);
                                formkey.currentState!.reset();
                                inputClear;
                              }
                            },
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextRichInfo(
                    text: Text(Consts.textInteractionLoginSignUp,
                        style: theme.textTheme.labelSmall),
                    textLink: Text(Consts.textInteractionLoginLinkSignUp,
                        style: theme.textTheme.labelMedium),
                    link: () {
                      Modular.to.pop();
                      // Navigator.popAndPushNamed(
                      //     context, ConstsRoutes.loginPage);
                      formkey.currentState!.reset();
                      inputClear;
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

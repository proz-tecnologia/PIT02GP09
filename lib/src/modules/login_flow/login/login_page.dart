import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/consts_routes.dart';
import '../../home/home_page.dart';
import '../../../utils/consts.dart';
import '../../../utils/mixins/validations_mixin.dart';
import '../../../utils/shared_preferences_keys.dart';
import '../reset_password/reset_password_controller.dart';
import '../sign_up/sign_up_controller.dart';
import '../widgets/custom_dialog/custom_dialog.dart';
import '../widgets/custom_input_form/custom_elevated_button.dart';
import '../widgets/custom_input_form/custom_text_form_field.dart';
import '../widgets/custom_input_form/input_clear.dart';
import '../widgets/custom_input_form/password_custom_text_form_field.dart';
import '../widgets/text_richinfo_create_account.dart';
import '../widgets/text_richinfo_forgot_password.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  late final LoginController loginController = LoginController();
  late final SignUpController signUpController;
  late final ResetPasswordController resetPasswordController;
  final formValidVN = ValueNotifier<bool>(false);

  @override
  void initState() {
    signUpController = SignUpController(onUpdate: () {
      setState(() {});
    });

    resetPasswordController = ResetPasswordController(onUpdate: () {
      setState(() {});
    });
    super.initState();
  }

  final formkey = GlobalKey<FormState>();

  //Controle com entrada de parametro "text" com valores para teste
  final mailController = TextEditingController(text: 'teste@teste.com');
  final passwordController = TextEditingController(text: 'Rinex1#');

  //Faz o controle de foco
  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final savedFocusNode = FocusNode();

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  get inputClear {
    mailController.clear;
    passwordController.clear;
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
                  //Habilta de desabilita o botão
                  onChanged: () {
                    setState(() {
                      formValidVN.value =
                          formkey.currentState?.validate() ?? false;
                    });
                  },
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 180,
                                  width: 180,
                                  child: Image(
                                    image:
                                        AssetImage(Consts.pathImageLoginPage),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Consts.textSalutation,
                                  style: theme.textTheme.labelLarge,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  Consts.textInteraction,
                                  style: theme.textTheme.labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
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
                            const SizedBox(height: 40),
                            PasswordCustomTextFormField(
                              label: Consts.textPassword,
                              hintText: Consts.textHintTextPassword,
                              password: passwordController,
                              focusNode: passwordFocusNode,
                              suffix: InputClear(
                                controller: passwordController,
                              ),
                              onFieldSubmitted: (_) =>
                                  savedFocusNode.requestFocus(),
                              textInputAction: TextInputAction.go,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextRichInfoForgotPassword(
                                  theme: theme,
                                  resetPasswordController:
                                      resetPasswordController,
                                  formkey: formkey,
                                  inputClear: inputClear,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  //Habilta de desabilita o botão
                  valueListenable: formValidVN,
                  builder: (_, formValid, child) {
                    return CustomElevatedButton(
                      label: Consts.textLogin,
                      savedFocusNode: savedFocusNode,
                      onPressed: !formValid
                          ? null
                          : () async {
                              late final SharedPreferences sharedPrefers;
                              sharedPrefers =
                                  await SharedPreferences.getInstance();

                              if (formkey.currentState != null &&
                                  formkey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                                loginController
                                    .login(
                                  mail: mailController.text,
                                  password: passwordController.text,
                                )
                                    .then((value) {
                                  if (value.runtimeType == LoginStateSuccess) {
                                    final userSession = sharedPrefers.getString(
                                        SharedPreferencesKeys.userSession);
                                    //Tira o loading
                                    Modular.to.pop();

                                    Modular.to.navigate(
                                      ConstsRoutes.homePage,
                                      arguments:
                                          HomeArguments(name: userSession!),
                                    );

                                    // Navigator.popAndPushNamed(
                                    //     context, ConstsRoutes.homePage,
                                    //     arguments:
                                    //         HomeArguments(name: userSession!));
                                    formkey.currentState!.reset();
                                    inputClear;
                                  } else {
                                    Navigator.pop(context);
                                    return showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CustomDialog(
                                        wid1: TextRichInfoForgotPassword(
                                          theme: theme,
                                          resetPasswordController:
                                              resetPasswordController,
                                          formkey: formkey,
                                          inputClear: inputClear,
                                        ),
                                        wid2: TextRichInfoCreateAccount(
                                          theme: theme,
                                          signUpController: signUpController,
                                          formkey: formkey,
                                          inputClear: inputClear,
                                        ),
                                        title: Consts.textCustomDialogTitle,
                                        description:
                                            Consts.textCustomDialogDescription,
                                        buttonText:
                                            Consts.textCustomDialogButtonText,
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                    );
                  },
                ),
                const SizedBox(height: 100),
                TextRichInfoCreateAccount(
                  theme: theme,
                  signUpController: signUpController,
                  formkey: formkey,
                  inputClear: inputClear,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

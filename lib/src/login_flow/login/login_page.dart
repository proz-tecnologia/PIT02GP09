import 'package:flutter/material.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/login_flow/widgets/custom_input_form/input_clear.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/login_flow/widgets/mixins/validations_mixin.dart';

import '../../../routes/consts_routes.dart';
import '../../../utils/consts.dart';
import '../widgets/custom_input_form/custom_elevated_button.dart';
import '../widgets/custom_input_form/custom_text_form_field.dart';
import '../widgets/custom_input_form/password_custom_text_form_field.dart';
import '../widgets/custom_input_form/text_rich_info.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final formkey = GlobalKey<FormState>();

  //Controle com entrada de parametro "text" com valores para teste
  final mailController = TextEditingController(text: 'teste@teste.com');
  final passwordController = TextEditingController(text: 'Rinex1#');

//Faz o controle de foco
  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final savedFocusNode = FocusNode();
  final controller = LoginController();
  @override
  void initState() {
    super.initState();
  }

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
                  onChanged: () {
                    setState(() {});
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
                                TextRichInfo(
                                  textLink: Text(
                                    Consts.textForgotPassword,
                                    style: theme.textTheme.labelMedium,
                                  ),
                                  link: () {
                                    Navigator.pushNamed(context,
                                        ConstsRoutes.resetPasswordPage);
                                    formkey.currentState!.reset();
                                    inputClear;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                CustomElevatedButton(
                  label: Consts.textLogin,
                  savedFocusNode: savedFocusNode,
                  onPressed: () async {
                    if (formkey.currentState != null &&
                        formkey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      controller
                          .login(
                        mail: mailController.text,
                        password: passwordController.text,
                      )
                          .then((value) {
                        //Tira o loading
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ConstsRoutes.homePage);
                        formkey.currentState!.reset();
                        inputClear;
                      });
                    }
                  },
                ),
                const SizedBox(height: 100),
                TextRichInfo(
                    text: Text(Consts.textInteractionCreateAccount,
                        style: theme.textTheme.labelSmall),
                    textLink: Text(Consts.textInteractionCreateAccountLink,
                        style: theme.textTheme.labelMedium),
                    link: () {
                      Navigator.pushNamed(context, ConstsRoutes.signUpPage);
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

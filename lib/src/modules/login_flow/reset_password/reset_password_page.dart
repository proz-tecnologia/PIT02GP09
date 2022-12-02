// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/models/user_model.dart';
import '../../../utils/consts.dart';
import '../widgets/custom_input_form/confirm_password_custom_text_form_field.dart';
import '../widgets/custom_input_form/custom_elevated_button.dart';
import '../widgets/custom_input_form/input_clear.dart';
import '../widgets/custom_input_form/password_custom_text_form_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage([Key? key]) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formkey = GlobalKey<FormState>();

  //Parametro "text" do TexteEditingController está com informação para TESTES
  final passwordController = TextEditingController(text: 'Rinex1#');
  final confirmPasswordController = TextEditingController(text: 'Rinex1#');
  final formValidVN = ValueNotifier<bool>(false);

  //Faz o controle de foco
  final passwordFocusNode = FocusNode();
  final savedFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  late UserModel userResetPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  get inputClear {
    passwordController.clear;
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black87,
          backgroundColor: const Color(0x00FFFFFF),
          elevation: 0,
          centerTitle: true,
          title: Text(
            Consts.textTitleAppBarResetPasswordPage,
            style: theme.textTheme.labelLarge,
          ),
        ),
        body: Scaffold(
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
                            horizontal: 20,
                            vertical: 0,
                          ),
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
                                        image: AssetImage(
                                          Consts.pathImageResetPasswordPage,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Consts.textInteraction1ResetPasswordPage,
                                      style: theme.textTheme.labelLarge,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      Consts.textInteraction2ResetPasswordPage,
                                      style: theme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                PasswordCustomTextFormField(
                                  label: Consts.textPasswordResetPasswordPage,
                                  hintText: Consts
                                      .textHintTextPasswordResetPasswordPage,
                                  password: passwordController,
                                  focusNode: passwordFocusNode,
                                  suffix: InputClear(
                                    controller: passwordController,
                                  ),
                                  onFieldSubmitted: (_) =>
                                      confirmPasswordFocusNode.requestFocus(),
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 40),
                                ConfirmPasswordCustomTextFormField(
                                  label: Consts
                                      .textConfirmPasswordResetPasswordPage,
                                  hintText: Consts
                                      .textHintTextConfirmPasswordResetPasswordPage,
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
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: formValidVN,
                      builder: (_, formValid, child) {
                        return CustomElevatedButton(
                          label: Consts.textResetPasswordPage,
                          savedFocusNode: savedFocusNode,
                          onPressed: !formValid
                              ? null
                              : () async {
                                  if (formkey.currentState != null &&
                                      formkey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                    final arg = ModalRoute.of(context)!
                                        .settings
                                        .arguments as UserModel;

                                    userResetPassword = UserModel(
                                      name: arg.name,
                                      email: arg.email,
                                      password: passwordController.text,
                                    );
                                    //Tira o loading
                                    Modular.to.pop();
                                    Modular.to.pop(userResetPassword);
                                    // Navigator.pop(context, userResetPassword);
                                    formkey.currentState!.reset();
                                    inputClear;
                                  }
                                },
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import '../../../shared/models/login_model.dart';
import '../../../shared/utils/consts.dart';
import '../../../shared/utils/mixins/validations_mixin.dart';
import '../../../shared/widgets/show_loader/show_loader.dart';
import '../widgets/custom_dialog/custom_dialog_stateless.dart';
import '../widgets/custom_input_form/custom_elevated_button.dart';
import '../widgets/custom_input_form/custom_text_form_field.dart';
import '../widgets/custom_input_form/input_clear.dart';
import '../widgets/custom_input_form/password_custom_text_form_field.dart';
import '../widgets/text_richinfo_create_account.dart';
import '../widgets/text_richinfo_forgot_password.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final formValidVN = ValueNotifier<bool>(false);

  final formkey = GlobalKey<FormState>();

  //Controle com entrada de parametro "text" com valores para teste
  final mailController = TextEditingController(text: 'teste@teste.com');
  final passwordController = TextEditingController(text: 'Rinex1#');

  //Faz o controle de foco
  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final savedFocusNode = FocusNode();
  final bloc = Modular.get<LoginBloc>();

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    //bloc.close();
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
      body: BlocBuilder<LoginBloc, LoginState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoginStateEmpty) {
                log(state.toString());
                return SafeArea(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            height: 180,
                                            width: 180,
                                            child: Image(
                                              image: AssetImage(
                                                  Consts.pathImageLoginPage),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        suffix: InputClear(
                                            controller: mailController),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextRichInfoForgotPassword(
                                            theme: theme,
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
                                        if (formkey.currentState != null &&
                                            formkey.currentState!.validate()) {
                                          LoginModel user = LoginModel(
                                            name: '',
                                            email: mailController.text,
                                            password: passwordController.text,
                                          );
                                          bloc.add(
                                            OnLoginPressed(user),
                                          );
                                          formkey.currentState!.reset();
                                          inputClear;
                                        }
                                      },
                              );
                            },
                          ),
                          const SizedBox(height: 100),
                          TextRichInfoCreateAccount(
                            theme: theme,
                            formkey: formkey,
                            inputClear: inputClear,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            } else if (state is LoginStateLoading) {
                log(state.toString());
                return const ShowLoader();
            } else if (state is LoginStateSuccess) {
                inputClear;
                log(state.toString());
                Modular.to.pushReplacementNamed(ConstsRoutes.homePageModule);
            } else if (state is LoginStateError) {
                log(state.toString());
                log(state.erro.toString());
                log(state.runtimeType.toString());
                return CustomDialogStateless(
                  stateType: state,
                  theme: theme,
                  formkey: formkey,
                  inputClear: inputClear,
                );
            }
            return Container();
          }
        ),
    );
  }


}

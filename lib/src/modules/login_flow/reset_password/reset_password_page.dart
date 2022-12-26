// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../routes/consts_routes.dart';
import '../../../shared/models/login_model.dart';
import '../../../shared/utils/consts.dart';
import '../../../shared/widgets/show_loader/show_loader.dart';
import '../widgets/custom_dialog/custom_dialog_stateless.dart';
import '../widgets/custom_input_form/confirm_password_custom_text_form_field.dart';
import '../widgets/custom_input_form/custom_elevated_button.dart';
import '../widgets/custom_input_form/input_clear.dart';
import '../widgets/custom_input_form/password_custom_text_form_field.dart';
import 'reset_password_bloc.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

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

  late LoginModel userResetPassword;
  final bloc = Modular.get<ResetPasswordBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    bloc.close();
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
        body: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            bloc: bloc,
            builder: (context, state) {
              return bloc.state.when(
                onEmpty: (_) {
                  log(state.toString());
                  return SafeArea(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  Consts
                                                      .pathImageResetPasswordPage,
                                                ),
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
                                              Consts
                                                  .textInteraction1ResetPasswordPage,
                                              style: theme.textTheme.labelLarge,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              Consts
                                                  .textInteraction2ResetPasswordPage,
                                              style: theme.textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        PasswordCustomTextFormField(
                                          label: Consts
                                              .textPasswordResetPasswordPage,
                                          hintText: Consts
                                              .textHintTextPasswordResetPasswordPage,
                                          password: passwordController,
                                          focusNode: passwordFocusNode,
                                          suffix: InputClear(
                                            controller: passwordController,
                                          ),
                                          onFieldSubmitted: (_) =>
                                              confirmPasswordFocusNode
                                                  .requestFocus(),
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
                                          confirmPassword:
                                              confirmPasswordController,
                                          suffix: InputClear(
                                            controller:
                                                confirmPasswordController,
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
                                              formkey.currentState!
                                                  .validate()) {
                                            // Encotra o usário pelo e-mail e devolve para "arg"
                                            final arg = ModalRoute.of(context)!
                                                .settings
                                                .arguments as LoginModel;
                                            // Resgata nome e email do usuário existente e cria um usuário com nova senha
                                            userResetPassword = LoginModel(
                                              name: arg.name,
                                              email: arg.email,
                                              password: passwordController.text,
                                            );
                                            // Devolve o novo usuário
                                            Modular.get<ResetPasswordBloc>()
                                                .add(OnResetPasswordPressed(user: userResetPassword));
                                            //Tira o loading
                                            Modular.to.pushNamed(
                                                ConstsRoutes.loginPage);
                                          }
                                          formkey.currentState!.reset();
                                          inputClear;
                                        },
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                onLoading: (_) {
                  log(state.toString());
                  return const ShowLoader();
                },
                onSuccess: (userSession) {
                  inputClear;
                  log(state.toString());
                  Modular.to.pushReplacementNamed(ConstsRoutes.homePageModule);
                },
                onError: (erro) {
                  log(state.toString());
                  log(erro.toString());
                  log(state.runtimeType.toString());
                  return CustomDialogStateless(
                    stateType: state,
                    theme: theme,
                    formkey: formkey,
                    inputClear: inputClear,
                  );
                },
              );
            }),
      ),
    );
  }
}

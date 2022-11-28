import 'package:flutter/material.dart';

class Consts {
  Consts._();

  //Constantes para serem usadas no projeto

  //Textos Splash_screen
  static const String textTitleSplashScreen = 'Eu Me Controlo';
  static const String pathImageSplashScreen =
      'images/images_login_flow/splash_screen.jpg';
  /*================================================================= */
  
  //Textos MAIN
  static const String titleMain = 'App Eu Me Controlo';
  /*================================================================= */

  // //Textos login_page
  static const String pathImageLoginPage =
      'images/images_login_flow/login_page.jpg';
  static const String textSalutation = 'Bem vindo de volta!';
  static const String textInteraction = 'Vamos fazer login para continuar';
  static const String textPassword = 'Senha';
  static const String textHintTextEmail = 'entre com seu e-mail';
  static const String textEmail = 'E-mail';
  static const String textHintTextPassword = 'entre com sua senha';
  static const String textForgotPassword = 'Esqueceu a senha?';
  static const String textLogin = 'Entrar';
  static const String textInteractionCreateAccount = 'Não tem uma conta?';
  static const String textInteractionCreateAccountLink = 'Crie Aqui';
  /*================================================================= */

  //Textos sign_up_page
  static const String pathImageSignUpPage =
      'images/images_login_flow/sign_up.jpg';
  static const String textInteraction1SignUp = 'Vamos começar';
  static const String textInteraction2SignUp =
      'Crie uma conta para obter todos os recursos';
  static const String textNameSignUp = 'Nome';
  static const String textHintTextNameSignUp = 'entre com seu nome completo';
  static const String textEmailSignUp = 'E-mail';
  static const String textHintTextEmailSignUp = 'entre com seu e-mail';
  static const String textPasswordSignUp = 'Senha';
  static const String textHintTextPasswordSignUp = 'entre com sua senha';
  static const String textConfirmPasswordSignUp = 'Confirme Senha';
  static const String textHintTextConfirmPasswordSignUp = 'repita a senha';
  static const String textSignUp = 'Inscrever-se';
  static const String textInteractionLoginSignUp = 'Já tem uma conta?';
  static const String textInteractionLoginLinkSignUp = 'Entrar';
  /*================================================================= */

  //Textos reset_password_page
  static const String textTitleAppBarResetPasswordPage = 'Reset Password';
  static const String pathImageResetPasswordPage =
      'images/images_login_flow/reset_password.jpg';
  static const String textInteraction1ResetPasswordPage =
      'Criar uma nova senha';
  static const String textInteraction2ResetPasswordPage =
      'Sua nova senha deve ser diferente das senhas usadas anteriormente';
  static const String textPasswordResetPasswordPage = 'Senha';
  static const String textHintTextPasswordResetPasswordPage =
      'entre com sua senha';
  static const String textConfirmPasswordResetPasswordPage =
      'Confirme Password';
  static const String textHintTextConfirmPasswordResetPasswordPage =
      'repita a senha';
  static const String textResetPasswordPage = 'Criar';
  /*================================================================= */

  //Textos do custom_dialog
  static const String textCustomDialogTitle = 'Info Login';
  static const String textCustomDialogDescription =
      'Senha ou e-mail incorreto!';
  static const String textCustomDialogButtonText = 'OK';
  /*================================================================= */

  //Textos do custom_theme_data
  static const String textTitleCustomShowAlertDialog = 'Entre com seu e-mail';
  static const String textCancelarCustomShowAlertDialog = 'Cancelar';
  static const String textEnviarCustomShowAlertDialog = 'Enviar';
  /*================================================================= */

  // Textos text_richinfo_forgot_password
  static const String textTitleTextRichinfoForgotPassword = 'Info Reset Password';
  static const String textDescriptionTextRichinfoForgotPassword = 'Usuário não cadastrado ou e-mail incorreto!';
  /*================================================================= */

  //Textos not_found_page
  static const String pathImageNotFoundPage =
      'images/404_error.png';
  static const String textTextButtonNotFoundPage =
      'Página de Login';

  /*================================================================= */



  //Constantes de de configurações gerais
  static const BorderRadius borderRadius10 =
      BorderRadius.all(Radius.circular(10));

  static final buttonStyleElevatedButton = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.all(18),
    shape: const RoundedRectangleBorder(
      borderRadius: Consts.borderRadius10,
    ),
    shadowColor: const Color(0xFF231F1F),
    elevation: 8,
  );
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
  /*================================================================= */
  

  /*================================================================= */
  /*================================================================= */
  //EXEMPLOS
  // static const String textConfirmPassword = 'Confirme a senha';
  // static const String exemploText1 = "... ${Consts.exemploText2} ....";
  // static const String exemploText2 = '';
  // static const String exemploText3 = '';
  // static const String exemploText4 = '${Consts.exemploText2} ...!';
  // static const String exemploText5 = '...a ${Consts.exemploText2}!';
  // static const String exemploText6 = '';
  // static const String exemploText7 = '';
  // static const double exemploText8 = 0.0;
  // static const int exemploText9 = 0;
}

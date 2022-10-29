import 'package:flutter/material.dart';

class Consts {
  Consts._();

  //Constantes para serem usadas no projeto

  //Textos Splash_screen
  static const String textTitleSplashScreen = 'Eu Me Controlo';
  static const String pathImageSplashScreen =
      'images/images_login_flow/splash_screen.jpg';

  //Textos login_page
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

  //Textos sign_up_page
  static const String pathImageSignUpPage =
      'images/images_login_flow/sign_up.jpg';
  static const String textInteraction1SignUp = 'Vamos começar';
  static const String textInteraction2SignUp = 'Crie uma conta para obter todos os recursos';
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
  
  static const BorderRadius borderRadius10 =
      BorderRadius.all(Radius.circular(10));

  static final buttonStyleElevatedButton = ElevatedButton.styleFrom(
    textStyle:  const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.all(18),
    shape: const RoundedRectangleBorder(
      borderRadius: Consts.borderRadius10,
    ),    
    shadowColor:const  Color(0xFF231F1F),
    elevation: 8,

  );
  //EXEMPLOS
  static const String titleMain = 'App Eu Me Controlo';
  static const String textConfirmPassword = 'Confirme a senha';
  static const String exemploText1 = "... ${Consts.exemploText2} ....";
  static const String exemploText2 = '';
  static const String exemploText3 = '';
  static const String exemploText4 = '${Consts.exemploText2} ...!';
  static const String exemploText5 = '...a ${Consts.exemploText2}!';
  static const String exemploText6 = '';
  static const String exemploText7 = '';
  static const double exemploText8 = 0.0;
  static const int exemploText9 = 0;
}

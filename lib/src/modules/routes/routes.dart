import 'package:flutter/material.dart';

import '../credit_card/credit_card_page.dart';
import '../expenses/expenses_page.dart';
import '../home/home_page.dart';
import '../login_flow/login/login_page.dart';
import '../login_flow/reset_password/reset_password_page.dart';
import '../login_flow/sign_up/sign_up_page.dart';
import '../login_flow/splash_screen/splash_screen_page.dart';
import '../revenue/revenue_page.dart';
import 'consts_routes.dart';

class Routes {
  

 static Map<String, Widget Function(BuildContext)> routes =
       <String, WidgetBuilder>{
        ConstsRoutes.rootRoute: (context) => const SplashScreenPage(),
        ConstsRoutes.loginPage: (context) => const LoginPage(),
        ConstsRoutes.signUpPage: (context) => const SignUpPage(),
        ConstsRoutes.resetPasswordPage: (context) => const ResetPasswordPage(),
        ConstsRoutes.homePage: (context) => const HomePage(),
        ConstsRoutes.revenuePage: (context) => const RevenuePage(),
        ConstsRoutes.expensesPage: (context) => const ExpensesPage(),
        ConstsRoutes.creditCardPage: (context) => const CreditCardPage(),
      };
}

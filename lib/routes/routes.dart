import 'package:flutter/material.dart';

import '../src/credit_card/credit_card_page.dart';
import '../src/expenses/expenses_page.dart';
import '../src/home/home_page.dart';
import '../src/login_flow/login/login_page.dart';
import '../src/login_flow/reset_password/reset_password_page.dart';
import '../src/login_flow/sign_up/sign_up_page.dart';
import '../src/login_flow/splash_screen/splash_screen_page.dart';
import '../src/revenue/revenue_page.dart';
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

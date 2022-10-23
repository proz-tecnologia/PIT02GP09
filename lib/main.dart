import 'package:flutter/material.dart';

import 'pages/credit_card/credit_card_page.dart';
import 'pages/expenses/expenses_page.dart';
import 'pages/revenue/revenue_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),        
        'login_page': (context) => const LoginPage(),        
        'revenue_page': (context) => const RevenuePage(),        
        'expenses_page': (context) => const ExpensesPage(),
        'credit_card_page': (context) => const CreditCardPage(),

        
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Lab Aulas',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
            fontStyle: FontStyle.normal,
          ),
          titleSmall: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
            fontStyle: FontStyle.normal,
          ),
          titleLarge: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
      ),

      // home: const Ccontainer(),
    );
  }
}

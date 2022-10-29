import 'package:flutter/material.dart';

class HomeArguments {
  final String name;

  const HomeArguments({required this.name});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as HomeArguments;
  
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('HOME PAGE  Olá ${args.name}!'),
      ),
    );
  }
}
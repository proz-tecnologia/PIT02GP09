import 'package:flutter/material.dart';

class HomepageAppBarSettingsButton extends StatelessWidget {
  const HomepageAppBarSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            minimum: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context, 
                  '/settings'
                  );
              }, 
              icon: const Icon(
                size: 40.0,
                Icons.settings,
                ),
              ),
            );
  }
}
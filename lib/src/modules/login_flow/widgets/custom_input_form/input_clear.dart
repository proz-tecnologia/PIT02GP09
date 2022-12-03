import 'package:flutter/material.dart';

class InputClear extends StatelessWidget {
  const InputClear({
    Key? key,
    required this.controller,
    this.controllerDois,
  }) : super(key: key);

  final TextEditingController controller;
  final TextEditingController? controllerDois;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.clear();
        if (controllerDois != null) {
          controllerDois!.clear();
        }
      },
      child: Icon(Icons.cancel_outlined,
          color: Theme.of(context).primaryColorDark),
    );
  }
}

import 'package:flutter/material.dart';

import 'dot.dart';
import 'show_loader.dart';

class OpacityCustom extends StatelessWidget {
  const OpacityCustom({
    Key? key,
    required this.animation,
    required this.widget,
   
  }) : super(key: key);

  final Animation<double> animation;
  final ShowLoader widget; 

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (animation.value <= 0.4
          ? 2.5 * animation.value
          : (animation.value > 0.40 && animation.value <= 0.60)
              ? 1.0
              : 2.5 - (2.5 * animation.value)),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Dot(
          radius: 10.0,
          color: widget.dotOneColor,
          type: widget.dotType,
          icon: widget.dotIcon,
        ),
      ),
    );
  }
}
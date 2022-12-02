// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'dot_type.dart';
import 'opacity_custom.dart';

class ShowLoader extends StatefulWidget {
  final Color dotOneColor;
  final Color dotTwoColor;
  final Color dotThreeColor;
  final Duration duration;
  final DotType dotType;
  final Icon dotIcon;

  const ShowLoader(
      {Key? key,
      this.dotOneColor = Colors.green,
      this.dotTwoColor = Colors.green,
      this.dotThreeColor = Colors.green,
      this.duration = const Duration(milliseconds: 1000),
      this.dotType = DotType.circle,
      this.dotIcon = const Icon(Icons.blur_on)})
      : super(key: key);

  @override
  ShowLoaderState createState() => ShowLoaderState();
}

class ShowLoaderState extends State<ShowLoader>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late Animation<double> animation_3;
  late Animation<double> animation_4;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = animation(0.60);

    animation_2 = animation(0.70);

    animation_3 = animation(0.80);

    animation_4 = animation(0.90);

    controller.addListener(() {
      setState(() {
        //print(animation_1.value);
      });
    });

    controller.repeat();
  }

  Animation<double> animation(double ands) {
    return Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, ands, curve: Curves.linear),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OpacityCustom(animation: animation_1, widget: widget),
        OpacityCustom(animation: animation_2, widget: widget),
        OpacityCustom(animation: animation_3, widget: widget),
        OpacityCustom(animation: animation_4, widget: widget),
        
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}




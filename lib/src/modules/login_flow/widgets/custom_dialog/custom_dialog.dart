//FONTE: https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
import 'package:flutter/material.dart';

import '../../../../utils/consts.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonText;
  final Widget? wid1;
  final Widget? wid2;
  final Image? image;

  const CustomDialog({
    super.key,
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.wid1,
    this.wid2,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...parte inferior do cartão,
        Container(
          padding: const EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: const EdgeInsets.only(top: Consts.avatarRadius),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10),
              if(wid1 != null) wid1!,
              const SizedBox(height: 10),
              if(wid2 != null) wid2!,
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 45,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(
                      buttonText!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //OPCIONAL
        // const Positioned(
        //   left: Consts.padding,
        //   right: Consts.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.blueAccent,
        //     radius: Consts.avatarRadius,
        //   ),
        // ),
      ],
    );
  }
}

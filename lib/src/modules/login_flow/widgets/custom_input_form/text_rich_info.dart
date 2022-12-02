import 'package:flutter/material.dart';

class TextRichInfo extends StatelessWidget {
  const TextRichInfo({
    Key? key,
    this.text,
    this.text2,
    this.textLink,
    this.link, 
  }) : super(key: key);

  final Widget? text;
  final Widget? text2;
  final Widget? textLink;
  final Function()? link;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(child: text == null ? const Text('') : text!),
          const TextSpan(text: '  '),
          WidgetSpan(
            child: GestureDetector(
              onTap: link,
              child: textLink!,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  CustomTextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.wordSpacing,
      this.onClick,
      this.textAlign});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? wordSpacing;
  final VoidCallback? onClick;
  TextAlign? textAlign = TextAlign.center;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (onClick == null)
          ? Text(
              textAlign: textAlign,
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,

                wordSpacing: wordSpacing,
              ),
            )
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(
                text,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                  wordSpacing: wordSpacing,
                ),
              ),
            ),
    );
  }
}

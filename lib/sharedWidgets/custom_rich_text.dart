import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';

class CustomRichText extends StatefulWidget {
  final String? text,colorText,afterText;
  final Color? textColor,colorTextColor,afterTextColor;
  final FontWeight? fontWeight;

  const CustomRichText({Key? key,this.text,this.afterText,this.colorText,this.textColor,this.afterTextColor,this.colorTextColor,this.fontWeight}) : super(key: key);

  @override
  _CustomRichTextState createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        textScaleFactor: 1.0,
        textAlign: TextAlign.center,
        softWrap: true,
        maxLines: 3,
        text:  TextSpan(
            text: widget.text,
            style: TextStyle(
                color: widget.textColor??AppColors.dartBlueText,
                fontWeight: widget.fontWeight??FontWeight.w800,fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                  text: widget.colorText,
                  style: TextStyle(
                      fontWeight: widget.fontWeight??FontWeight.w800,
                      color: widget.colorTextColor?? AppColors.blueText)),
              TextSpan(
                text: widget.afterText,
              ),
            ]));
  }
}

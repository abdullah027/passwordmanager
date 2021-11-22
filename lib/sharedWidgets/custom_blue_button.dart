import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';

import 'custom_text.dart';

class CustomBlueButton extends StatefulWidget {
  final Function()? onPressed;
  final Color? color,textColor;
  final String? text;
  final double? width;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  CustomBlueButton({Key? key,this.onPressed,this.color,this.text,this.width,this.borderRadius,this.shape,this.textColor,this.child,this.padding}) : super(key: key);

  @override
  _CustomBlueButtonState createState() => _CustomBlueButtonState();
}

class _CustomBlueButtonState extends State<CustomBlueButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: widget.width,
      child: MaterialButton(
        padding: widget.padding?? const EdgeInsets.symmetric(
            vertical: 15, horizontal: 20),
        color:widget.color?? AppColors.blueButtonColor,
        elevation: 5,
        shape: widget.shape??RoundedRectangleBorder(
            borderRadius:widget.borderRadius?? BorderRadius.circular(20)),
        textColor: widget.textColor??Colors.white,
        onPressed: widget.onPressed,
        child: widget.child??CustomText(
          title: widget.text?? AppStrings.getStarted,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

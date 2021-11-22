import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';


class CustomWhiteButton extends StatefulWidget {
  final Function()? onPressed;
  final Color? color,textColor;
  final String? text;


  CustomWhiteButton({Key? key,this.onPressed,this.color,this.text,this.textColor}) : super(key: key);

  @override
  _CustomWhiteButtonState createState() => _CustomWhiteButtonState();
}

class _CustomWhiteButtonState extends State<CustomWhiteButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
         border: Border.all(
           width: 1.5,
           color: AppColors.logInTextColor.withOpacity(0.2),
         )
      ),
      child: MaterialButton(

        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        onPressed: widget.onPressed,
        child: CustomText(
          title: widget.text,
          fontWeight: FontWeight.w800,
          textColor: widget.color,
        ),
      ),
    );
  }
}

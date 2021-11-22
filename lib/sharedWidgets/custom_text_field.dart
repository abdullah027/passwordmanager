import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';


class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final bool? obscureText,enabled;
  final Color? fillColor;
  final InputBorder? enableBorder;
  final Icon? prefixIcon;
  final BorderSide? borderSide;
  const CustomTextField({Key? key,this.hintText,this.controller,this.inputType,this.textAlign,this.obscureText,this.fillColor,this.enableBorder,this.prefixIcon,this.enabled,this.borderSide}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      textAlign: widget.textAlign??TextAlign.justify,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        enabledBorder: widget.enableBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: widget.borderSide??const BorderSide(),
        ),

        filled: true,
        fillColor: widget.fillColor??AppColors.fillColor,
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.55), fontSize: 10),
        hintText: widget.hintText,
      ),
      obscureText: widget.obscureText??false,
      keyboardType: widget.inputType,
    );
  }
}

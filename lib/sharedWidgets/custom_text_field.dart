import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';


class CustomTextField extends StatefulWidget {
  final String? hintText,labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final bool? obscureText,enabled;
  final Color? fillColor;
  final Function()? onPressed;
  final InputBorder? enableBorder;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final BorderSide? borderSide;
  const CustomTextField({Key? key,this.hintText,this.labelText,this.controller,this.inputType,this.textAlign,this.obscureText,this.fillColor,this.enableBorder,this.prefixIcon,this.enabled,this.borderSide,this.suffixIcon,this.onPressed}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return MediaQuery(
      data: const MediaQueryData(textScaleFactor: 1),
      child: TextField(
        style: TextStyle(
          color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black
        ),
        enabled: widget.enabled,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        textAlign: widget.textAlign??TextAlign.justify,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: IconButton(
            onPressed: widget.onPressed,
              icon: widget.suffixIcon??Container()),
          enabledBorder: widget.enableBorder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: widget.borderSide??const BorderSide(),
          ),
          filled: true,
          fillColor: widget.fillColor??AppColors.fillColor,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black.withOpacity(0.55), fontSize: 10),
          hintStyle: TextStyle(
              color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black.withOpacity(0.55), fontSize: 10),
          hintText: widget.hintText,
        ),
        obscureText: widget.obscureText??false,
        keyboardType: widget.inputType,
      ),
    );
  }
}

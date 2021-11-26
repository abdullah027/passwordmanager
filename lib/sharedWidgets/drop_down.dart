import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';

import 'custom_text.dart';

class DropDownBox<T> extends StatefulWidget {
  final T? value;
  final List<T>? items;
  final Function(T)? onChange;
  final String? hint, header;
  final Color? headerColor;

  DropDownBox(
      {this.value,
        this.items,
        this.onChange,
        this.hint,
        this.header,
        this.headerColor});

  @override
  _DropDownBoxState createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: widget.header,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          textColor: widget.headerColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                isExpanded: true,
                hint: CustomText(title: widget.hint,textColor: Colors.black.withOpacity(0.2),
                    fontSize: 14),
                dropdownColor: Colors.white,
                // icon: Icon(Icons.keyboard_arrow_down),
                value: widget.value,
                items: widget.items!
                    .map<DropdownMenuItem>((v) => DropdownMenuItem(
                  child: CustomText(
                    title: v.toString(),
                    textColor: Colors.black,
                  ),
                  value: v,
                ))
                    .toList(),
                onChanged: widget.onChange),
          ),
        ),
      ],
    );
  }
}

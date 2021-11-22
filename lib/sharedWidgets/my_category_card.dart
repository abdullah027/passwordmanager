import 'package:flutter/material.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class MyCategoryCard extends StatefulWidget {
  final Icon? icon;
  final String? text;
  final int? index;
  const MyCategoryCard({Key? key,this.icon,this.text,this.index}) : super(key: key);

  @override
  _MyCategoryCardState createState() => _MyCategoryCardState();
}

class _MyCategoryCardState extends State<MyCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 22.w,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      height: 120,
      decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor
                  .withOpacity(0.05),
              blurRadius: 34,
              offset: const Offset(10,18),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: widget.index == 0?AppColors.container1Color:widget.index ==1?AppColors.container2Color:widget.index == 2?AppColors.container3Color:AppColors.container4Color,
                shape: BoxShape.circle),
            child: widget.icon,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            title: widget.text,
            fontSize: 12,
            textAlign: TextAlign.center,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';

import '../../../../constant/text_style_constant.dart';
import '../../../../custom/container_custom.dart';
import '../../../../custom/text_custom.dart';

class FaqCategoryCard extends StatefulWidget {
  final String title;
  const FaqCategoryCard({super.key, required this.title});

  @override
  State<FaqCategoryCard> createState() => _FaqCategoryCardState();
}

class _FaqCategoryCardState extends State<FaqCategoryCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      callback: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      marginRight: 12.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      borderRadius: BorderRadius.circular(12.r),
      bgColor: isSelected == true ? primaryColor : neutral200,
      child: TextCustomWidget(
        text: widget.title,
        textStyle: heading6Mid.copyWith(
          color: isSelected == true ? whiteColor : blackColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';

import '../../../../constant/text_style_constant.dart';
import '../../../../custom/container_custom.dart';
import '../../../../custom/text_custom.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String description;
  const CustomExpansionTile(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      marginLeft: 35.w,
      marginRight: 35.w,
      marginBottom: 24.h,
      child: ExpansionTile(
        trailing: Icon(
          Icons.arrow_drop_down_rounded,
          size: 35.h,
        ),
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.transparent)),
        collapsedShape: ContinuousRectangleBorder(
          side: BorderSide(color: neutral200, width: 2.w),
          borderRadius: BorderRadius.circular(14.r),
        ),
        title: TextCustomWidget(
          text: title,
          textStyle: heading6Mid,
        ),
        children: [
          ContainerCustom(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
            borderRadius: BorderRadius.circular(14.r),
            bgColor: const Color(0xffFBFBFB),
            child: TextCustomWidget(
              text: description,
              textStyle: heading6Regular.copyWith(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}

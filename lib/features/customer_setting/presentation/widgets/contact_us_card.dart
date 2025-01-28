import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';

import '../../../../constant/text_style_constant.dart';
import '../../../../custom/container_custom.dart';
import '../../../../custom/text_custom.dart';

class ContactUsCard extends StatelessWidget {
  final String title;
  final String icon;
  const ContactUsCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      marginLeft: 35.w,
      marginRight: 35.w,
      marginTop: 24.h,
      borderRadius: BorderRadius.circular(14.r),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      bgColor: neutral200,
      child: Row(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: 24.h,
            color: blackColor,
          ),
          TextCustomWidget(
            text: title,
            textStyle: heading6Mid,
            marginLeft: 14.w,
          )
        ],
      ),
    );
  }
}

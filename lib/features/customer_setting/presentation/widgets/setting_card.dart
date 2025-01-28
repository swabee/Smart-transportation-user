import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';

import '../../../../constant/text_style_constant.dart';
import '../../../../custom/text_custom.dart';

class SettingCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback callback;
  final Widget? traling;
  final Color? tileColor;
  final Color? iconColor;
  final Color? textColor;

  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.callback,
    this.traling,
    this.tileColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      marginBottom: 10.h,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 16.w, right: 16.w),
        tileColor: tileColor,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(14.r)),
        leading: icon,
        title: TextCustomWidget(
          text: title,
          textStyle: heading6Mid.copyWith(color: primaryColor),
        ),
        onTap: callback,
        trailing: traling,
      ),
    );
  }
}

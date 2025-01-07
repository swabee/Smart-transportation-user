
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:user_app/custom/iconbutton_custom.dart';
import 'package:user_app/custom/text_custom.dart';


class SettingCard extends StatelessWidget {
  const SettingCard({
    required this.text,
    required this.callback,
    required this.width,
    super.key,
  });

  final String text;
  final VoidCallback callback;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustomWidget(
            text: text,
            width: width,
            height: 17.h,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          IconButtonCustom(
            btnWidth: 19.w,
            btnHeight: 19.h,
            dontApplyMargin: true,
            callback: callback,
            child: Icon(
              Iconsax.arrow_right_3,
              color: Colors.black,
              size: 16.h,
            ),
          ),
        ],
      ),
    );
  }
}
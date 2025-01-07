import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';

class DatePickList extends StatelessWidget {
  const DatePickList({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      marginTop: 20.h,
      marginLeft: 10.w,
      marginRight: 10.w,
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const DatePickListTile();
        },
      ),
    );
  }
}

class DatePickListTile extends StatelessWidget {
  const DatePickListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      margin: EdgeInsets.all(8.sp),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
      // height: 40.h,
      // width: 40.h,
      border: Border.all(color: boarderPrimaryColor),
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        children: [
          TextCustomWidget(
            containerAlignment: Alignment.center,
            text: "12",
            textColor: textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
          TextCustomWidget(
            containerAlignment: Alignment.center,
            text: "Today",
            textColor: textSecondaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}

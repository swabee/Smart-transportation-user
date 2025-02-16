import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/firebse_constants.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 31.h),
      child: ContainerCustom(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
        alignment: Alignment.centerLeft, // width: 339.w,
        // height: 70.h,
        // bgColor: Colors.blue.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xffDEE8F7),
              radius: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 13.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerCustom(
                    width: 310.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          text: notificationModel.title,
                          width: 138.w,
                          height: 19.h,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        TextCustomWidget(
                          text: defaultDateOnlyFormat
                              .format(notificationModel.createdAt.toDate()),
                          width: 79.w,
                          height: 15.h,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          textColor: const Color(0xffBAB8BB),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  TextCustomWidget(
                    text: notificationModel.content,
                    width: 300.w,
                    height: 45.h,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xffAAACAB),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

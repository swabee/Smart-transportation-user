import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 31.h),
      child: ContainerCustom(padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 12.w),
        alignment: Alignment.centerLeft,// width: 339.w,
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
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [   Row(
                    children: [
                      TextCustomWidget(
                        text: "Notification1",
                        width: 158.w, 
                        height: 19.h,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 149.w),
                        child: TextCustomWidget(
                          text: "1h",
                          width: 19.w,
                          height: 15.h,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          textColor: const Color(0xffBAB8BB),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 6.h),
                  TextCustomWidget(
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been..",
                    width: 320.w,
                    height: 45.h,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xffAAACAB),
                  ),],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

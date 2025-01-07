
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/notifications/presnetation/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustomWidget(
          text: "Notification",
          width: 85.w,
          height: 18.h,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, top: 40.h),
          child: Column(
            children: [
              Row(
                children: [
                  TextCustomWidget(
                    text: "TODAY",
                    width: 53.w,
                    height: 19.h,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xffB7B7B7),
                  ),
                  SizedBox(width: 173.w),
                  TextCustomWidget(
                    text: "Mark all as read",
                    width: 106.w,
                    height: 17.h,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xff778E96),
                  ),
                ],
              ),
              SizedBox(height: 23.h),
              const NotificationCard(),
              const NotificationCard(),
              const NotificationCard(),
              SizedBox(height: 14.h),
              Row(
                children: [
                  TextCustomWidget(
                    text: "YESTERDAY",
                    width: 91.w,
                    height: 19.h,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xffB7B7B7),
                  ),
                  SizedBox(width: 135.w),
                  TextCustomWidget(
                    text: "Mark all as read",
                    width: 106.w,
                    height: 17.h,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xff778E96),
                  ),
                ],
              ),
              SizedBox(height: 23.h),
              const NotificationCard(),
              const NotificationCard(),
              const NotificationCard(),
              SizedBox(height: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
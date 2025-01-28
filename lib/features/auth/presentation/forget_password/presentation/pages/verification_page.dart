import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/custom/textfield_custom.dart';
import 'package:user_app/features/auth/presentation/forget_password/presentation/pages/verified_page.dart';

import '../../../../../../custom/button_custom.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Verification',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          TextCustomWidget(
            text: 'Enter the verification code',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            containerAlignment: Alignment.center,
            textColor: primaryColor,
            marginTop: 78.h,
          ),
          TextCustomWidget(
            text: 'We send the verification code to @hsr@gmail.com',
            textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: primaryColor),
            containerAlignment: Alignment.center,
            marginTop: 24.h,
            marginBottom: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldCustom(
                marginLeft: 35.w,
                width: 40.w,
                height: 40.h,
                isOtpField: true,
                borderColor: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                keyboardType: TextInputType.number,
              ),
              TextFieldCustom(
                width: 40.w,
                height: 40.h,
                isOtpField: true,
                borderColor: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                keyboardType: TextInputType.number,
              ),
              TextFieldCustom(
                width: 40.w,
                height: 40.h,
                isOtpField: true,
                borderColor: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                keyboardType: TextInputType.number,
              ),
              TextFieldCustom(
                width: 40.w,
                height: 40.h,
                isOtpField: true,
                borderColor: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                keyboardType: TextInputType.number,
              ),
              TextFieldCustom(
                width: 40.w,
                height: 40.h,
                isOtpField: true,
                borderColor: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                keyboardType: TextInputType.number,
              ),
              TextFieldCustom(
                marginRight: 35.w,
                width: 40.w,
                height: 40.h,
                isOtpField: true,
                borderColor: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              SizedBox(width: 35.w),
              const Icon(
                CupertinoIcons.info,
                color: Colors.red,
              ),
              TextCustomWidget(
                text: 'Invalid OTP. Try again in 5s.  ',
                marginLeft: 14.w,
                textStyle: heading6Mid.copyWith(color: error500),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextCustomWidget(
                text: 'Didn’t get a code?',
                textStyle: bodySemi,
              ),
              ButtonCustom(
                text: 'Resend',
                callback: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SignupPage(),
                  //   ),
                  // );
                },
                btnColor: Colors.transparent,
                margin: EdgeInsets.only(left: 14.w),
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ],
          ),
          Expanded(child: Container()),
          ButtonCustom(btnColor: primaryColor,
            text: 'Verify',
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VerifiedPage(isVerificationPage: true),
                ),
              );
            },
            margin: EdgeInsets.only(bottom: 127.h, left: 35.w, right: 35.w),
          ),
        ],
      ),
    );
  }
}

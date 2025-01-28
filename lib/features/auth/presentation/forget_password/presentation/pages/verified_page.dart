import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/auth/presentation/forget_password/presentation/pages/change_password_page.dart';
import 'package:user_app/features/auth/presentation/login/presentation/pages/login_page.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({
    super.key,
    required this.isVerificationPage,
  });

  final bool isVerificationPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.check_mark_circled,
            size: 50.sp,
            color: primaryColor,
          ),
          TextCustomWidget(
            text: 'Successfully Changed',
            textStyle: heading6bold,
            containerAlignment: Alignment.center,
            marginTop: 20.h,
          ),
          TextCustomWidget(
            text:
                'Your password has been successfully changed. You can now use your new password to sign in.',
            textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: primaryColor),
            textAlign: TextAlign.center,
            marginLeft: 64.w,
            marginRight: 64.w,
            marginTop: 20.h,
          ),
          ButtonCustom(
            btnColor: primaryColor,
            text: isVerificationPage == true
                ? 'Change Password'
                : 'Return to Login Page',
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => isVerificationPage == true
                      ? const ChangePasswordPage()
                      : const LoginPage(),
                ),
              );
            },
            margin: EdgeInsets.only(top: 20.h, left: 35.w, right: 35.w),
          ),
        ],
      ),
    );
  }
}

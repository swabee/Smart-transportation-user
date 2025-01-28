import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/auth/presentation/forget_password/presentation/pages/verification_page.dart';

import '../../../../../../custom/textfield_custom.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        title: Text(
          'Forget Password',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextCustomWidget(
            text: 'No worries, we’ll send you reset instructions',
            fontSize: 16.sp,
            marginTop: 78.h,
            fontWeight: FontWeight.w600,
            containerAlignment: Alignment.center,
            textColor: primaryColor,
          ),
          TextFieldCustom(
            marginTop: 60.h,
            marginLeft: 35.w,
            marginRight: 35.w,
            hintText: 'Email Address',
                 prefixIcon: Icon(
                Icons.email,
                color: primaryColor,
              ),
          ),
          Expanded(child: Container()),
          ButtonCustom(btnColor: primaryColor,
            text: 'Send',
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerificationPage(),
                ),
              );
            },
            margin: EdgeInsets.only(bottom: 167.h, left: 35.w, right: 35.w),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/features/auth/presentation/forget_password/presentation/pages/verified_page.dart';

import '../../../../../../custom/textfield_custom.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        title: const Text(
          'Change Password',
      
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFieldCustom(
            marginTop: 78.h,
            marginLeft: 35.w,
            marginRight: 35.w,
            hintText: 'Password',
            obscureText: isHide,
            prefixIcon: Icon(
              CupertinoIcons.lock,
              color: primaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isHide = !isHide;
                });
              },
              color: Colors.black,
              icon: (isHide)
                  ? Icon(
                      CupertinoIcons.eye_slash,
                      color: primaryColor,
                    )
                  : Icon(
                      CupertinoIcons.eye,
                      color: primaryColor,
                    ),
            ),
          ),
          TextFieldCustom(
            marginTop: 24.h,
            marginLeft: 35.w,
            marginRight: 35.w,
            marginBottom: 24.h,
            hintText: 'Confirm Password',
            obscureText: isHide,
            prefixIcon: Icon(
              CupertinoIcons.lock,
              color: primaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isHide = !isHide;
                });
              },
              color: Colors.black,
              icon: (isHide)
                  ? Icon(
                      CupertinoIcons.eye_slash,
                      color: primaryColor,
                    )
                  : Icon(
                      CupertinoIcons.eye,
                      color: primaryColor,
                    ),
            ),
          ),
          ButtonCustom(
            btnColor: primaryColor,
            text: 'Change',
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const VerifiedPage(isVerificationPage: false),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';


class CustomerDeleteAccountConfirmPage extends StatelessWidget {
  const CustomerDeleteAccountConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Delete Account',
          style: heading5Semi,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerCustom(
            marginLeft: 35.w,
            marginRight: 35.w,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/right.png',
                  width: 72.w,
                  height: 72.h,
                ),
                TextCustomWidget(
                  text: 'Account Deleted Successfully',
                  textStyle: heading6bold,
                  containerAlignment: Alignment.center,
                  marginBottom: 20.h,
                  marginTop: 20.h,
                ),
                TextCustomWidget(
                  text: 'Your account has been successfully deleted.',
                  textStyle: bodyRegular,
                  marginLeft: 29.w,
                  marginRight: 29.w,
                  textAlign: TextAlign.center,
                ),
                ButtonCustom(
                  text: 'Got It',
                  callback: () {},
                  margin: EdgeInsets.only(top: 20.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

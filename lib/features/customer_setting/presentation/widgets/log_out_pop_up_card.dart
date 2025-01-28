import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/app/cubit/auth_cubit.dart';
import 'package:user_app/constant/app_constant.dart';

import '../../../../constant/text_style_constant.dart';
import '../../../../custom/button_custom.dart';
import '../../../../custom/container_custom.dart';
import '../../../../custom/text_custom.dart';

class LogOutPopUpCard extends StatelessWidget {
  const LogOutPopUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 19.w, right: 19.w, top: 678.h),
      child: ContainerCustom(
        height: 177.h,
        bgColor: whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        borderRadius: BorderRadius.circular(14.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCustomWidget(
              text: 'Log Out of your Account?',
              textStyle: heading6bold,
              containerAlignment: Alignment.center,
            ),
            TextCustomWidget(
              text:
                  'Are you sure you want to log out? You’ll need to login again to use the app.',
              textStyle: bodyRegular,
              marginLeft: 29.w,
              marginRight: 29.w,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonCustom(
                  text: 'Cancle',
                  callback: () => Navigator.pop(context),
                  btnWidth: 170.w,
                  btnColor: whiteColor,
                  borderSide: BorderSide(color: primaryColor, width: 1.5.w),
                  textColor: primaryColor,
                  dontApplyMargin: true,
                ),
                ButtonCustom(
                  btnColor: primaryColor,
                  text: 'Log Out',
                  callback: () {
                         Navigator.pop(context);
                          context.read<AuthCubit>().signOut();
                  },
                  btnWidth: 170.w,
                  dontApplyMargin: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

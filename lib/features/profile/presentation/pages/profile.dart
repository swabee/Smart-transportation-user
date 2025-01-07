import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/iconbutton_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/custom/textfield_custom.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteCOlor,
      // extendBodyBehindAppBar: true,
 
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const ContainerCustom(
              // width: 375.w,
              // height: 812.h,
              bgColor: Color(0xffFFFFFF),
            ),
            ContainerCustom(
              // width: 375.w,
              height: 50.h,
              bgColor: whiteCOlor,
            ),
            Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(top: 70.h),
                //   child: TextCustomWidget(
                //     text: "My Account",
                //     fontSize: 20.sp,
                //     fontWeight: FontWeight.w400,
                //     containerAlignment: Alignment.center,
                //     textColor: const Color(0xffFFFFFF),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top:14.h),
                  child: CircleAvatar(
                    // backgroundColor: Colors.black,
                    radius: 61.h,
                    // backgroundImage:
                    //     const AssetImage("assets/images/plogo.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:54.w, right: 23.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButtonCustom(
                        dontApplyMargin: true,
                        // btnWidth: 111.w,
                        // btnHeight: 19.h,
                        callback: () {},
                        child: TextCustomWidget(
                          text: "Change Picture",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          textColor: primaryColor,
                        ),
                      ),
                      SizedBox(height: 46.h),
                      TextCustomWidget(
                        text: "NAME",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff808080),
                      ),
                      TextFieldCustom(
                        width: 327.w,
                        useUnderlineBorder: true,
                        border: BorderSide(
                          width: 1.h,
                          color: const Color(0xff808080),
                        ),
                      ),
                      SizedBox(height: 31.h),
                      TextCustomWidget(
                        text: "EMAIL",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff808080),
                      ),
                      TextFieldCustom(
                        width: 327.w,
                        useUnderlineBorder: true,
                        border: BorderSide(
                          width: 1.h,
                          color: const Color(0xff808080),
                        ),
                      ),
                      SizedBox(height: 31.h),
                      TextCustomWidget(
                        text: "PHONE NUMBER",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff808080),
                      ),
                      TextFieldCustom(
                        width: 327.w,
                        useUnderlineBorder: true,
                        border: BorderSide(
                          width: 1.h,
                          color: const Color(0xff808080),
                        ),
                      ),
                      SizedBox(height: 31.h),
                      TextCustomWidget(
                        text: "PASSWORD",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff808080),
                      ),
                      TextFieldCustom(
                        width: 327.w,
                        useUnderlineBorder: true,
                        border: BorderSide(
                          width: 1.h,
                          color: const Color(0xff808080),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 29.h),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       TextCustomWidget(
                      //         text: "Skills",
                      //         fontSize: 12.sp,
                      //         fontWeight: FontWeight.w400,
                      //         textColor: const Color(0xff808080),
                      //       ),
                      //       IconButtonCustom(
                      //         callback: () {},
                      //         btnWidth: 50.w,
                      //         btnHeight: 24.h,
                      //         child: TextCustomWidget(
                      //           text: "+ Add",
                      //           fontSize: 16.sp,
                      //           fontWeight: FontWeight.w700,
                      //           textColor: primaryColor,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
        
                ContainerCustom(height: 120.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
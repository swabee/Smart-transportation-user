
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/setting/presnetation/widgets/settings_card.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteCOlor,
    
      body: Padding(
        padding: EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustomWidget(
              text: "General",
              width: 61.w,
              height: 19.h,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SettingCard(
              text: "Language",
              callback: () {
                // languageBottomSheet(context);
              },
              width: 66.w,
            ),
            SizedBox(height: 12.h),
            Divider(
              color: const Color(0xff0d16340d),
              thickness: 1.h,
            ),
            SettingCard(
              text: "Notification Setting",
              callback: () {
                // notificationSetiing(context);
              },
              width: 135.w,
            ),
            SizedBox(height: 12.h),
            Divider(
              color: const Color(0xff0d16340d),
              thickness: 1.h,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustomWidget(
                  text: "Location",
                  width: 57.w,
                  height: 17.h,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                FlutterSwitch(
                  width: 30.w,
                  height: 16.h,
                  toggleSize: 12.h,
                  value: status,
                  onToggle: (val) {
                    setState(
                      () {
                        status = val;
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SettingCard(
              text: "Delete Account",
              callback: () {
                // deleteAccount(context, (bool? newValue) {
                //   setState(() {
                //     ischeck = newValue;
                //   });
                // });
              },
              width: 102.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 28.h),
              child: TextCustomWidget(
                text: "Other",
                width: 61.w,
                height: 19.h,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 13.h),
            SettingCard(
              text: "Privacy Policy",
              callback: () {
                // PrivacyPolicy(context);
              },
              width: 92.w,
            ),
            SizedBox(height: 12.h),
            Divider(
              color: const Color(0xff0d16340d),
              thickness: 1.h,
            ),
            SettingCard(
              text: "Terms and Conditions",
              callback: () {
                // teamAndCond(context);
              },
              width: 145.w,
            ),
            SizedBox(height: 12.h),
            Divider(
              color: const Color(0xff0d16340d),
              thickness: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustomWidget(
                    text: "Rate app",
                    width: 61.w,
                    height: 17.h,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextCustomWidget(
                    text: "v4.87.2",
                    width: 54.w,
                    height: 19.h,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
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

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isSwitched,
      onChanged: (value) {
        setState(() {
          _isSwitched = value;
        });
      },
      activeColor: Colors.blue,
      inactiveThumbColor: Colors.black,
      inactiveTrackColor: Colors.white,
    );
  }
}
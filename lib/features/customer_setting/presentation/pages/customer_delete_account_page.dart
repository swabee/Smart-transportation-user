import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/custom_checkbox.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/customer_setting/presentation/pages/customer_delete_account_confirm_page.dart';

class CustomerDeleteAccountPage extends StatefulWidget {
  const CustomerDeleteAccountPage({super.key});

  @override
  State<CustomerDeleteAccountPage> createState() =>
      _CustomerDeleteAccountPageState();
}

class _CustomerDeleteAccountPageState extends State<CustomerDeleteAccountPage> {
  bool isChecked = false;
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
        children: [
          TextCustomWidget(
            text:
                'We’re sorry to see you go! Deleting your account will permanently remove your profile and all related data.',
            textStyle: heading6Mid,
            textAlign: TextAlign.center,
            marginLeft: 35.w,
            marginRight: 35.w,
          ),
          const Spacer(),
          Row(
            children: [
              CustomCheckBox(
                value: isChecked,
                checkedFillColor: whiteColor,
                checkedIconColor: primaryColor,
                borderColor: isChecked == true ? primaryColor : blackColor,
                borderWidth: 1.5.w,
                shouldShowBorder: true,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                marginLeft: 35.w,
                marginBottom: 24.h,
              ),
              TextCustomWidget(
                text:
                    'I understand and accept all the above \frisks regarding my account deletion.',
                textStyle: heading6Mid,
                marginRight: 35.w,
                marginLeft: 14.w,
                marginBottom: 24.h,
              ),
            ],
          ),
          ButtonCustom(
            btnColor: primaryColor,
            text: 'Delete Account',
            isDisabled: isChecked == false ? true : false,
            callback: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerDeleteAccountConfirmPage(),
              ),
            ),
          ),
          ButtonCustom(
            text: 'Dismiss',
            callback: () {},
            btnColor: whiteColor,
            textColor: primaryColor,
            borderSide: BorderSide(color: primaryColor),
            margin: EdgeInsets.only(
                left: 35.w, right: 35.w, top: 24.w, bottom: 24.w),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/textfield_custom.dart';

import '../../../../../constant/text_style_constant.dart';
import '../../../../../custom/button_custom.dart';
import '../../../../../custom/container_custom.dart';
import '../../../../../custom/text_custom.dart';

class CustomerUpdateProfilePage extends StatefulWidget {
  const CustomerUpdateProfilePage({super.key});

  @override
  State<CustomerUpdateProfilePage> createState() =>
      _CustomerUpdateProfilePageState();
}

class _CustomerUpdateProfilePageState extends State<CustomerUpdateProfilePage> {
  final List<String> phoneNumbers = ['+94', '+00'];
  String? selectedPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: heading5Semi,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerCustom(
              width: 108.w,
              height: 105.h,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ContainerCustom(
                    borderRadius: BorderRadius.circular(50.sp),
                    height: 90.h,
                    width: 90.w,
                    bgColor: Colors.grey.shade300,
                  ),
                  Icon(
                    Icons.add_a_photo,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            TextCustomWidget(
              text: 'Full Name',
              textStyle: heading6Mid,
              marginBottom: 24.h,
              marginLeft: 35.w,
              marginTop: 24.h,
            ),
            TextFieldCustom(
              marginLeft: 35.w,
              marginRight: 35.w,
              marginBottom: 24.h,
              borderRadius: BorderRadius.circular(14.r),
              prefixIcon: Icon(
                Icons.person,
                color: primaryColor,
              ),
              hintText: 'Enter Full Name',
            ),
            TextCustomWidget(
              text: 'Date of Birth',
              textStyle: heading6Mid,
              marginBottom: 24.h,
              marginLeft: 35.w,
            ),
            TextFieldCustom(
              marginLeft: 35.w,
              marginRight: 35.w,
              marginBottom: 24.h,
              borderRadius: BorderRadius.circular(14.r),
              prefixIcon: Icon(
                Icons.calendar_month,
                color: primaryColor,
              ),
              hintText: 'DD/MM/YYYY',
              keyboardType: TextInputType.datetime,
            ),
            TextCustomWidget(
              text: 'Email',
              textStyle: heading6Mid,
              marginBottom: 24.h,
              marginLeft: 35.w,
            ),
            TextFieldCustom(
              marginLeft: 35.w,
              marginRight: 35.w,
              marginBottom: 24.h,
              borderRadius: BorderRadius.circular(14.r),
              prefixIcon: Icon(
                Icons.email,
                color: primaryColor,
              ),
              hintText: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
            ),
            TextCustomWidget(
              text: 'Phone Number',
              textStyle: heading6Mid,
              marginBottom: 24.h,
              marginLeft: 35.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerCustom(
                  height: 48.h,
                  width: 112.w,
                  paddingRight: 16.w,
                  paddingLeft: 16.w,
                  marginLeft: 35.w,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: neutral200),
                  child: DropdownButton(
                    iconSize: 24.h,
                    borderRadius: BorderRadius.circular(14.r),
                    elevation: 1,
                    // hint: TextCustomWidget(
                    //   text: 'Choose the Reason',
                    //   textStyle: heading6Mid.copyWith(color: neutral300),
                    // ),
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor: whiteColor,
                    focusColor: whiteColor,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPhoneNumber = value;
                      });
                    },
                    value: selectedPhoneNumber,
                    items: phoneNumbers.map(
                      (String reason) {
                        return DropdownMenuItem(
                          value: reason,
                          child: TextCustomWidget(
                            text: reason,
                            textStyle: heading6Mid,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                TextFieldCustom(
                  height: 48.h,
                  width: 226.w,
                  marginRight: 35.w,
                  borderRadius: BorderRadius.circular(14.r),
                  hintText: '00 000 0000',
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            ButtonCustom(
              btnColor: primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 52.h),
              text: 'Update Profile',
              callback: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

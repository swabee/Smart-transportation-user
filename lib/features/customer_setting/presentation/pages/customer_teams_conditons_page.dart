import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/text_custom.dart';

class CustomerTeamsConditonsPage extends StatelessWidget {
  const CustomerTeamsConditonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'Terms & Conditions',
          style: heading5Semi,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Column(
            children: [
              TextCustomWidget(
                text: 'Terms and Conditions \fEffective Date: October 2024',
                textStyle: heading6Mid,
              ),
              TextCustomWidget(
                text: '1. Acceptance of Terms',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'By using the app, you agree to comply with and be bound by these terms. If you do not agree with any part of these terms, you must not use our app.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '2. Services Provided',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'Yeti Plow connects users (customers) with independent contractors (shovelers) for snow removal services, car assistance, and other related services. The services provided through the app are subject to availability.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '3. User Responsibilities',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    '•	Customers: You are responsible for providing accurate property information and ensuring safe access for the shoveler.\f•	Shovelers: You must complete services professionally, follow customer requests, and provide accurate before and after images.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '4. Payments',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'Payments for services are made through Stripe. By using Yeti Plow, you agree to Stripe’s terms of service and authorize us to process payments on your behalf. All payments must be completed before services commence.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '5. Cancellations and Refunds',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    '•	Customers: You may cancel a job before the shoveler arrives. Refunds will be provided only if cancellations are made within a specified time frame.\f•	Shovelers: If you are unable to fulfill a job after accepting it, you must notify the customer as soon as possible.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '6. Limitation of Liability',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'Yeti Plow acts as a facilitator between customers and shovelers. We are not liable for any damage or loss caused during the performance of services. Any disputes between customers and shovelers must be resolved between the involved parties.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '7. Privacy',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'By using the app, you consent to our collection and use of your personal information as outlined in our Privacy Policy.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '8. Modifications to Terms',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'Yeti Plow reserves the right to update or modify these terms at any time. Continued use of the app following any changes constitutes acceptance of the revised terms.',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text: '9. Governing Law',
                textStyle: heading6Mid,
                marginTop: 20.h,
              ),
              TextCustomWidget(
                text:
                    'These terms are governed by and construed in accordance with the laws of [Your Jurisdiction].',
                textStyle: heading6Mid,
                marginTop: 20.h,
                marginBottom: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

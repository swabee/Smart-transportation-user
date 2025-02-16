import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/qr_scanner/qr_scanner_page.dart';

class QrBaseScreen extends StatelessWidget {
  const QrBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextCustomWidget(
            containerAlignment: Alignment.center,
            text: 'Scan qr code for get ticket',
            fontSize: 20.sp,
          ),
          SizedBox(
            height: 100.h,
          ),
          Icon(
            Icons.qr_code_scanner,
            size: 150.sp,
            color: primaryColor,
          ),
          SizedBox(
            height: 100.h,
          ),
          ButtonCustom(
            btnColor: primaryColor,
            text: 'Scan',
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QRScannerScreen()));
            },
          )
        ],
      ),
    );
  }
}

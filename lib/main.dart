
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/pages/welcome.dart';


void main() => runApp(const ScreenUtilInit(designSize: Size(480, 920),
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Welcome(),
  ),
));
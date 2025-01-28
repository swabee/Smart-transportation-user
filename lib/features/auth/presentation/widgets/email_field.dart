import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/features/auth/presentation/login/presentation/bloc/login_bloc.dart';
import 'package:user_app/features/auth/presentation/signup/presentation/bloc/signup_bloc.dart';
import 'package:user_app/global/form_models/email.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, this.isLogin});
  final bool? isLogin;

  @override
  Widget build(BuildContext context) {
    if (isLogin == true) {
      final displayError = context.select(
        (LoginBloc bloc) => bloc.state.email.displayError,
      );
      String? errorMessage;

      if (displayError != null) {
        switch (displayError) {
          case EmailValidationError.empty:
            errorMessage = 'Email is required';
          case EmailValidationError.notValid:
            errorMessage = 'Invalid email address';
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerCustom(
            border: Border.all(
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(12.r),
            marginRight: 20.w,
            marginLeft: 20.w,
            marginTop: 20.h,
            bgColor: whiteColor,
            height: 48.h,
            child: CupertinoTextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) =>
                  context.read<LoginBloc>().add(LoginEmailChanged(value)),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              placeholder: 'Email Address',
              placeholderStyle:  TextStyle(color: primaryColor,),
              decoration: const BoxDecoration(),
              prefix: ContainerCustom(
                marginLeft: 15.w,
                child: Icon(
                  Icons.email,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          if (displayError != null && errorMessage != null)
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 30.w),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      );
    } else {
      final displayError = context.select(
        (SignupBloc bloc) => bloc.state.email.displayError,
      );
      String? errorMessage;

      if (displayError != null) {
        switch (displayError) {
          case EmailValidationError.empty:
            errorMessage = 'Email is required';
          case EmailValidationError.notValid:
            errorMessage = 'Invalid email address';
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerCustom(
            border: Border.all(
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(12.r),
            marginRight: 20.w,
            marginLeft: 20.w,
            marginTop: 20.h,
            bgColor: whiteColor,
            height: 48.h,
            child: CupertinoTextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) =>
                  context.read<SignupBloc>().add(SignupEmailChanged(value)),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              placeholder: 'Email Address',
              placeholderStyle: TextStyle(color:      primaryColor,),
              decoration: const BoxDecoration(),
              prefix: ContainerCustom(
                marginLeft: 15.w,
                child: Icon(
                  Icons.email,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          if (displayError != null && errorMessage != null)
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 30.w),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      );
    }
  }
}

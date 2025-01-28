import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/features/auth/presentation/login/presentation/bloc/login_bloc.dart';
import 'package:user_app/features/auth/presentation/signup/presentation/bloc/signup_bloc.dart';


class PasswordField extends StatelessWidget {
  const PasswordField({super.key, this.isLogin, this.isConfirmPasswordField});
  final bool? isLogin;
  final bool? isConfirmPasswordField;

  @override
  Widget build(BuildContext context) {
    if (isLogin == true) {
      final displayError = context.select(
        (LoginBloc bloc) => bloc.state.password.displayError,
      );

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
            marginTop: 30.h,
            bgColor: whiteColor,
            height: 48.h,
            child: CupertinoTextField(
              onChanged: (value) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(value)),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              placeholder: 'Password',
              placeholderStyle:  TextStyle(color: primaryColor,),
              decoration: const BoxDecoration(),
              prefix: ContainerCustom(
                marginLeft: 15.w,
                child: Icon(
                  Icons.lock,
                  color: primaryColor,
                ),
              ),
              suffix: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          if (displayError != null)
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 30.w),
              child: Text(
                'Password is required',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      );
    } else {
      if (isConfirmPasswordField != true) {
        final displayError = context.select(
          (SignupBloc bloc) => bloc.state.password.displayError,
        );

        final password = context.select(
          (SignupBloc bloc) => bloc.state.password,
        );

        final confirmPassword = context.select(
          (SignupBloc bloc) => bloc.state.confirmPassword,
        );

        final passwordMatch = confirmPassword.value == password.value;
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
              marginTop: 30.h,
              bgColor: whiteColor,
              height: 48.h,
              child: CupertinoTextField(
                onChanged: (value) => context
                    .read<SignupBloc>()
                    .add(SignupPasswordChanged(value)),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                placeholder: 'Password',
                placeholderStyle: TextStyle(color: primaryColor,),
                decoration: const BoxDecoration(),
                prefix: ContainerCustom(
                  marginLeft: 15.w,
                  child: Icon(
                    Icons.lock,
                    color: primaryColor,
                  ),
                ),
                suffix: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            if (displayError != null)
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 30.w),
                child: Text(
                  'Password is required',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            if (passwordMatch == false &&
                !password.isPure &&
                !confirmPassword.isPure)
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 30.w),
                child: Text(
                  'Password does not match',
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
          (SignupBloc bloc) => bloc.state.confirmPassword.displayError,
        );
        final password = context.select(
          (SignupBloc bloc) => bloc.state.password,
        );

        final confirmPassword = context.select(
          (SignupBloc bloc) => bloc.state.confirmPassword,
        );
        final passwordMatch = confirmPassword.value == password.value;

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
              marginTop: 30.h,
              bgColor: whiteColor,
              height: 48.h,
              child: CupertinoTextField(
                onChanged: (value) => context
                    .read<SignupBloc>()
                    .add(SignupConfirmPasswordChanged(value)),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                placeholder: 'Confirm Password',
                placeholderStyle:  TextStyle(color: primaryColor,),
                decoration: const BoxDecoration(),
                prefix: ContainerCustom(
                  marginLeft: 15.w,
                  child: Icon(
                    Icons.lock,
                    color: primaryColor,
                  ),
                ),
                suffix: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            if (displayError != null)
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 30.w),
                child: Text(
                  'Confirm Password is required',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            if (passwordMatch == false &&
                !password.isPure &&
                !confirmPassword.isPure)
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 30.w),
                child: Text(
                  'Password does not match',
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/features/auth/presentation/signup/presentation/bloc/signup_bloc.dart';


class FirstNameField extends StatelessWidget {
  const FirstNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignupBloc bloc) => bloc.state.firstName.displayError,
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
          marginTop: 60.h,
          bgColor: whiteColor,
          height: 48.h,
          child: CupertinoTextField(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            placeholder: 'First Name',
            placeholderStyle:  TextStyle(color: primaryColor,),
            decoration: const BoxDecoration(),
            prefix: ContainerCustom(
              marginLeft: 15.w,
              child: Icon(
                Icons.person,
                color: primaryColor,
              ),
            ),
            onChanged: (value) =>
                context.read<SignupBloc>().add(SignupFirstNameChanged(value)),
          ),
        ),
        if (displayError != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 30.w),
            child: Text(
              'First Name is required',
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

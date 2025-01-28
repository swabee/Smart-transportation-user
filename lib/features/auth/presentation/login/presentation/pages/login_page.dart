import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/auth/presentation/forget_password/presentation/pages/forget_password_page.dart';
import 'package:user_app/features/auth/presentation/login/presentation/bloc/login_bloc.dart';
import 'package:user_app/features/auth/presentation/signup/presentation/pages/signup_page.dart';
import 'package:user_app/features/auth/presentation/social_login/bloc/social_login_bloc.dart';
import 'package:user_app/features/auth/presentation/widgets/password_field.dart';
import 'package:user_app/global/root/root_page.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/snackbar_service.dart';

import '../../../widgets/email_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final SnackBarService _snackBarService = locator<SnackBarService>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SocialLoginBloc(),
        ),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success) {
            _snackBarService.showSuccess(
              'Login successful!',
              context,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const RootPage(),
              ),
              (route) => false,
            );
          } else if (state.status == FormzSubmissionStatus.failure) {
            _snackBarService.showError(
              state.failure?.message ?? 'Unexpected error occurred',
              context,
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                surfaceTintColor: whiteColor,
                backgroundColor: whiteColor,
                title: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TextCustomWidget(
                      text: 'Welcome Back User!',
                      marginTop: 78.h,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      containerAlignment: Alignment.center,
                      textColor: primaryColor,
                    ),

                    SizedBox(
                      height: 60.h,
                    ),
                    const EmailField(
                      isLogin: true,
                    ),
                    const PasswordField(
                      isLogin: true,
                    ),

                    // TextFieldCustom(
                    //   marginTop: 96.h,
                    //   marginLeft: 35.w,
                    //   marginRight: 35.w,
                    //   hintText: 'Email Address',
                    //   prefixIcon: Icon(
                    //     Icons.email,
                    //     color: primaryColor,
                    //   ),
                    // ),
                    // TextFieldCustom(
                    //   marginTop: 24.h,
                    //   marginLeft: 35.w,
                    //   marginRight: 35.w,
                    //   marginBottom: 24.h,
                    //   hintText: 'Password',
                    //   obscureText: isHide,
                    //   prefixIcon: Icon(
                    //     CupertinoIcons.lock,
                    //     color: primaryColor,
                    //   ),
                    //   suffixIcon: IconButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         isHide = !isHide;
                    //       });
                    //     },
                    //     color: Colors.black,
                    //     icon: (isHide)
                    //         ? Icon(
                    //             CupertinoIcons.eye_slash,
                    //             color: primaryColor,
                    //           )
                    //         : Icon(
                    //             CupertinoIcons.eye,
                    //             color: primaryColor,
                    //           ),
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     SizedBox(width: 35.w),
                    //     const Icon(
                    //       CupertinoIcons.info,
                    //       color: Colors.red,
                    //     ),
                    //     TextCustomWidget(
                    //       text:
                    //           'Your email or password are incorrect.\fPlease try again!',
                    //       marginLeft: 14.w,
                    //       textStyle: heading6Mid.copyWith(color: error500),
                    //     )
                    //   ],
                    // ),
                    ButtonCustom(
                      callback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPasswordPage(),
                          ),
                        );
                      },
                      text: 'Forget Password?',
                      textStyle: bodySemi,
                      btnColor: Colors.transparent,
                      mainAxisAlignment: MainAxisAlignment.end,
                      margin: EdgeInsets.only(right: 35.w),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.isValid != current.isValid ||
                          previous.status != current.status,
                      builder: (context, state) {
                        return ButtonCustom(
                          btnColor: primaryColor,
                          isDisabled: !state.isValid,
                          inProgress:
                              state.status == FormzSubmissionStatus.inProgress,
                          borderRadius: BorderRadius.circular(12.r),
                          margin: EdgeInsets.only(
                            top: 90.h,
                            right: 20.w,
                            left: 20.w,
                          ),
                          text: 'Login',
                          callback: () {
                            context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted());
                          },
                          textStyle: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        );
                      },
                    ),
                    // ButtonCustom(
                    //   isDisabled: !state.isValid,
                    //   inProgress:
                    //       state.status == FormzSubmissionStatus.inProgress,
                    //   btnColor: primaryColor,
                    //   text: 'Login',
                    //   margin:
                    //       EdgeInsets.only(top: 128.h, left: 35.w, right: 35.w),
                    //   callback: () {
                    //     context.read<LoginBloc>().add(const LoginSubmitted());
                    //   },
                    // ),
                    TextCustomWidget(
                      text: 'Or login with',
                      fontWeight: FontWeight.bold,
                      containerAlignment: Alignment.center,
                      marginTop: 40.h,
                      textColor: primaryColor,
                    ),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerCustom(
                          borderRadius: BorderRadius.circular(50.sp),
                          height: 60.sp,
                          width: 60.sp,
                          bgColor: secondprimaryColor,
                          child: Icon(
                            EvaIcons.google,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: 30.w),
                        ContainerCustom(
                          borderRadius: BorderRadius.circular(50.sp),
                          height: 60.sp,
                          width: 60.sp,
                          bgColor: secondprimaryColor,
                          child: Icon(
                            Icons.apple,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustomWidget(
                          text: 'Don’t have an account?',
                          textStyle: bodySemi,
                        ),
                        ButtonCustom(
                          text: 'Sign Up',
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ),
                            );
                          },
                          btnColor: Colors.transparent,
                          margin: EdgeInsets.only(left: 14.w),
                          textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

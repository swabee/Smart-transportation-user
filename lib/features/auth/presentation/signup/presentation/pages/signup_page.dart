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
import 'package:user_app/features/auth/presentation/signup/presentation/bloc/signup_bloc.dart';
import 'package:user_app/features/auth/presentation/widgets/email_field.dart';
import 'package:user_app/features/auth/presentation/widgets/first_name_field.dart';
import 'package:user_app/features/auth/presentation/widgets/last_name_field.dart';
import 'package:user_app/features/auth/presentation/widgets/password_field.dart';
import 'package:user_app/global/root/root_page.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/snackbar_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SnackBarService _snackBarService = locator<SnackBarService>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          surfaceTintColor: whiteColor,
          backgroundColor: whiteColor,
          title: Text(
            'Sign Up',
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
              BlocListener<SignupBloc, SignupState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == FormzSubmissionStatus.success) {
                    //show a snackbar
                    _snackBarService.showSuccess(
                      'Account created successfully',
                      context,
                    );

                    // getTokenAndSave();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RootPage(),
                      ),
                      (route) => false,
                    );
                  } else if (state.status == FormzSubmissionStatus.failure) {
                    _snackBarService.showError(
                      state.error?.message ?? 'Unexpted error occurred: ',
                      context,
                    );
                  }
                },
                child: ContainerCustom(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                  bgColor: whiteColor,
                  height: 800.h,
                  child: Column(
                    children: [
                      TextCustomWidget(
                        text: 'Create your account and get started',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        containerAlignment: Alignment.center,
                        textColor: primaryColor,
                      ),
                      const FirstNameField(),
                      const LastNameField(),
                      const EmailField(),
                      const PasswordField(),
                      const PasswordField(
                        isConfirmPasswordField: true,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          SizedBox(
                            width: 20.h,
                          ),
                          BlocBuilder<SignupBloc, SignupState>(
                            buildWhen: (previous, current) =>
                                previous.agreeToTerms != current.agreeToTerms,
                            builder: (context, state) {
                              return Checkbox(
                                focusColor: primaryColor,
                                activeColor: Colors.transparent,
                                checkColor: primaryColor,
                                value: state.agreeToTerms,
                                onChanged: (value) {
                                  if (value != null) {
                                    context.read<SignupBloc>().add(
                                          SignupAgreeToTermsChanged(
                                            agreeToTerms: value,
                                          ),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                          TextCustomWidget(
                            width: 300.w,
                            marginLeft: 25.sp,
                            marginTop: 25.h,
                            containerAlignment: Alignment.topCenter,
                            text:
                                'I’ve read and agree with the Terms and Conditions and the Privacy Policy',
                            textColor: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                      BlocBuilder<SignupBloc, SignupState>(
                        buildWhen: (previous, current) =>
                            previous.isValid != current.isValid ||
                            previous.status != current.status,
                        builder: (context, state) {
                          return ButtonCustom(
                            btnColor: primaryColor,
                            isDisabled: !state.isValid,
                            inProgress: state.status ==
                                FormzSubmissionStatus.inProgress,
                            borderRadius: BorderRadius.circular(12.r),
                            margin: EdgeInsets.only(
                              top: 40.h,
                              right: 20.w,
                              left: 20.w,
                            ),
                            text: 'SIGN UP',
                            callback: () {
                              context.read<SignupBloc>().add(
                                    SignupSubmitted(),
                                  );
                            },
                            textStyle: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          );
                        },
                      ),
                      TextCustomWidget(
                        text: 'Or signup with',
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
                            text: 'Login',
                            callback: () {
                              Navigator.pop(context);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

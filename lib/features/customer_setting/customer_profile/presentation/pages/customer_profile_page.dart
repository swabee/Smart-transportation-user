import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/customer_setting/customer_profile/presentation/bloc/user_data_bloc.dart';
import 'package:user_app/utils/image_util.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  File? profilePicFile;

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSourceOption.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSourceOption.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSourceOption source) async {
    final pickedFile = await getImage(source);
    if (pickedFile != null) {
      setState(() {
        profilePicFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),
      body: BlocConsumer<UserDataBloc, UserDataState>(
        listenWhen: (previous, current) {
          if (current is UserDataUpdateError) {
            return true;
          } else if (current is UserDataLoaded && current.detailsUpdated) {
            return true;
          }
          // else if (current is UserDataLoaded && current.profilePicUpdated) {
          //   return true;
          // }

          return false;
        },
        listener: (context, state) {
          if (state is UserDataUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failure.message,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            );
          } else if (state is UserDataLoaded && state.detailsUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Details updated successfully!'),
              ),
            );
            // context.read<UserDataBloc>().emit(state.copyWith(detailsUpdated: false));
          }
        },
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserDataFetchError) {
            return Center(
              child: Text(
                state.failure.message,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.sp,
                ),
              ),
            );
          } else if (state is UserDataLoaded) {
            final userData = state.userDataEntity;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ContainerCustom(
                    // bgColor: Colors.white,
                    height: 120.h,
                    width: 120.h,
                    marginTop: 30.h,
                    // marginBottom: 20.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.h, // Outer CircleAvatar radius
                          backgroundColor: Colors.grey, // Border color
                          child: CircleAvatar(
                            radius: 48.h, // Inner CircleAvatar radius
                            backgroundColor: Colors.white,
                            backgroundImage: profilePicFile != null
                                ? FileImage(profilePicFile!)
                                : userData.profilePicUrl != null &&
                                        userData.profilePicUrl!
                                            .isNotEmpty
                                    ? CachedNetworkImageProvider(
                                        userData.profilePicUrl!,
                                      )
                                    : const AssetImage(
                                        'asset/images/profiledummy.png',
                                      ) as ImageProvider,
                          ),
                        ),
                        if (profilePicFile == null)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                _showImageSourceActionSheet(context);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  ContainerCustom(
        
                    margin:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    bgColor: whiteColor,
                    child: Column(
                      children: [
                        TextCustomWidget(
                          text: 'Full Name',
                          marginBottom: 24.h,
                          marginLeft: 35.w,
                          marginTop: 24.h,
                          textColor: primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        ContainerCustom(
                          marginLeft: 35.w,
                          marginRight: 35.w,
                          marginBottom: 24.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          border: Border.all(color: neutral200),
                          borderRadius: BorderRadius.circular(14.r),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              TextCustomWidget(
                                text: '${userData.fName} ${userData.lName}',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                textColor: primaryColor,
                                marginLeft: 14.w,
                              )
                            ],
                          ),
                        ),
                        TextCustomWidget(
                          text: 'Date of Birth',
                          textColor: primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          marginBottom: 24.h,
                          marginLeft: 35.w,
                        ),
                        ContainerCustom(
                          marginLeft: 35.w,
                          marginRight: 35.w,
                          marginBottom: 24.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          border: Border.all(color: neutral200),
                          borderRadius: BorderRadius.circular(14.r),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: primaryColor,
                              ),
                              TextCustomWidget(
                                text: 'DD/MM/YYYY',
                                textStyle: heading6Mid,
                                marginLeft: 14.w,
                              )
                            ],
                          ),
                        ),
                        TextCustomWidget(
                          text: 'Email',
                          textStyle: heading6Mid,
                          marginBottom: 24.h,
                          marginLeft: 35.w,
                        ),
                        ContainerCustom(
                          marginLeft: 35.w,
                          marginRight: 35.w,
                          marginBottom: 24.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          border: Border.all(color: neutral200),
                          borderRadius: BorderRadius.circular(14.r),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: primaryColor,
                              ),
                              TextCustomWidget(
                                text: userData.email,
                                textStyle: heading6Mid,
                                marginLeft: 14.w,
                              ),
                            ],
                          ),
                        ),
                        TextCustomWidget(
                          text: 'Phone Number',
                          textStyle: heading6Mid,
                          marginBottom: 24.h,
                          marginLeft: 35.w,
                        ),
                        Row(
                          children: [
                            ContainerCustom(
                              marginLeft: 35.w,
                              marginRight: 35.w,
                              marginBottom: 24.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              border: Border.all(color: neutral200),
                              borderRadius: BorderRadius.circular(14.r),
                              child: TextCustomWidget(
                                text: '+94',
                                textStyle: heading6Mid,
                              ),
                            ),
                            Expanded(
                              child: ContainerCustom(
                                marginRight: 35.w,
                                marginBottom: 24.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 12.h),
                                border: Border.all(color: neutral200),
                                borderRadius: BorderRadius.circular(14.r),
                                child: TextCustomWidget(
                                  text: '00 000 0000',
                                  textStyle: heading6Mid,
                                  marginLeft: 14.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ButtonCustom(btnColor: primaryColor,
                    text: 'Edit Profile',
                    callback: () {},
                    textStyle: TextStyle(
                      color: whiteColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),

      //  Column(
      //   // crossAxisAlignsment: CrossAxisAlignment.center,
      //   children: [
      //     ContainerCustom(
      //       borderRadius: BorderRadius.circular(50.sp),
      //       height: 90.h,
      //       width: 90.w,
      //       bgColor: Colors.grey.shade300,
      //     ),
      //     // Placeholder(
      //     //   fallbackHeight: 90.h,
      //     //   fallbackWidth: 100.w,
      //     //   color: whiteColor,
      //     //   // child: Image.asset('assets/images/checker.png'),
      //     // ),
      // TextCustomWidget(
      //   text: 'Full Name',
      //   marginBottom: 24.h,
      //   marginLeft: 35.w,
      //   marginTop: 24.h,
      //   textColor: primaryColor,
      //   fontSize: 16.sp,
      //   fontWeight: FontWeight.w500,
      // ),
      // ContainerCustom(
      //   marginLeft: 35.w,
      //   marginRight: 35.w,
      //   marginBottom: 24.h,
      //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      //   border: Border.all(color: neutral200),
      //   borderRadius: BorderRadius.circular(14.r),
      //   child: Row(
      //     children: [
      //       Icon(
      //         Icons.person,
      //         color: primaryColor,
      //       ),
      //       TextCustomWidget(
      //         text: 'Enter Full Name',
      //         fontSize: 16.sp,
      //         fontWeight: FontWeight.w500,
      //         textColor: primaryColor,
      //         marginLeft: 14.w,
      //       )
      //     ],
      //   ),
      // ),
      // TextCustomWidget(
      //   text: 'Date of Birth',
      //   textColor: primaryColor,
      //   fontSize: 16.sp,
      //   fontWeight: FontWeight.w500,
      //   marginBottom: 24.h,
      //   marginLeft: 35.w,
      // ),
      // ContainerCustom(
      //   marginLeft: 35.w,
      //   marginRight: 35.w,
      //   marginBottom: 24.h,
      //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      //   border: Border.all(color: neutral200),
      //   borderRadius: BorderRadius.circular(14.r),
      //   child: Row(
      //     children: [
      //       Icon(
      //         Icons.calendar_month,
      //         color: primaryColor,
      //       ),
      //       TextCustomWidget(
      //         text: 'DD/MM/YYYY',
      //         textStyle: heading6Mid,
      //         marginLeft: 14.w,
      //       )
      //     ],
      //   ),
      // ),
      // TextCustomWidget(
      //   text: 'Email',
      //   textStyle: heading6Mid,
      //   marginBottom: 24.h,
      //   marginLeft: 35.w,
      // ),
      // ContainerCustom(
      //   marginLeft: 35.w,
      //   marginRight: 35.w,
      //   marginBottom: 24.h,
      //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      //   border: Border.all(color: neutral200),
      //   borderRadius: BorderRadius.circular(14.r),
      //   child: Row(
      //     children: [
      //       Icon(
      //         Icons.email,
      //         color: primaryColor,
      //       ),
      //       TextCustomWidget(
      //         text: 'example@gmail.com',
      //         textStyle: heading6Mid,
      //         marginLeft: 14.w,
      //       ),
      //     ],
      //   ),
      // ),
      // TextCustomWidget(
      //   text: 'Phone Number',
      //   textStyle: heading6Mid,
      //   marginBottom: 24.h,
      //   marginLeft: 35.w,
      // ),
      // Row(
      //   children: [
      //     ContainerCustom(
      //       marginLeft: 35.w,
      //       marginRight: 35.w,
      //       marginBottom: 24.h,
      //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      //       border: Border.all(color: neutral200),
      //       borderRadius: BorderRadius.circular(14.r),
      //       child: TextCustomWidget(
      //         text: '+94',
      //         textStyle: heading6Mid,
      //       ),
      //     ),
      //     Expanded(
      //       child: ContainerCustom(
      //         marginRight: 35.w,
      //         marginBottom: 24.h,
      //         padding:
      //             EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      //         border: Border.all(color: neutral200),
      //         borderRadius: BorderRadius.circular(14.r),
      //         child: TextCustomWidget(
      //           text: '00 000 0000',
      //           textStyle: heading6Mid,
      //           marginLeft: 14.w,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      //     const Spacer(),
      //     ButtonCustom(
      //       btnColor: primaryColor,
      //       margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 50.h),
      //       text: 'Edit Profile',
      //       callback: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const CustomerUpdateProfilePage(),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

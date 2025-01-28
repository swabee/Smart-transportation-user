import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/app/cubit/auth_cubit.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/global/root/root_page.dart';

import '../../../../constant/text_style_constant.dart';
import '../../customer_profile/presentation/pages/customer_profile_page.dart';
import '../widgets/log_out_pop_up_card.dart';
import '../widgets/setting_card.dart';
import 'customer_delete_account_page.dart';
import 'customer_help_and_support_page.dart';
import 'customer_privacy_and_policy_page.dart';
import 'customer_teams_conditons_page.dart';

class CustomerSettingPage extends StatefulWidget {
  const CustomerSettingPage({super.key});

  @override
  State<CustomerSettingPage> createState() => _CustomerSettingPageState();
}

class _CustomerSettingPageState extends State<CustomerSettingPage> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const RootPage(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          surfaceTintColor: whiteColor,
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Settings',
            style: heading5Semi,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          children: [
            SettingCard(
              icon: Icon(
                Icons.person,
                color: primaryColor,
              ),
              title: 'My Profile',
              callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerProfilePage(),
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                CupertinoIcons.moon,
                color: primaryColor,
              ),
              title: 'Dark Mode',
              callback: () {},
              tileColor: secondprimaryColor,
              textColor: whiteColor,
              iconColor: whiteColor,
              traling: Transform.scale(
                scale: 0.8.w,
                child: CupertinoSwitch(
                  value: isActive,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (index) {
                    setState(() {
                      isActive = index;
                    });
                  },
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                Icons.notifications,
                color: primaryColor,
              ),
              title: 'Notifications',
              callback: () {},
              tileColor: secondprimaryColor,
              textColor: whiteColor,
              iconColor: whiteColor,
              traling: Transform.scale(
                scale: 0.8.w,
                child: CupertinoSwitch(
                  value: isActive,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (index) {
                    setState(() {
                      isActive = index;
                    });
                  },
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                Icons.privacy_tip,
                color: primaryColor,
              ),
              title: 'Privacy Policy',
              callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerPrivacyAndPolicyPage(),
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                Icons.chat,
                color: primaryColor,
              ),
              title: 'Terms & Conditions',
              callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerTeamsConditonsPage(),
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                Icons.support_agent_rounded,
                color: primaryColor,
              ),
              title: 'Help & Support',
              callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerHelpAndSupportPage(),
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                Icons.contact_support,
                color: primaryColor,
              ),
              title: 'Contact Us',
              callback: () {},
            ),
            SettingCard(
              icon: Icon(
                Icons.delete,
                color: primaryColor,
              ),
              title: 'Delete Account',
              callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerDeleteAccountPage(),
                ),
              ),
            ),
            SettingCard(
              icon: Icon(
                Icons.logout,
                color: primaryColor,
              ),
              title: 'Log Out',
              callback: () => showDialog(
                context: context,
                builder: (context) => const LogOutPopUpCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

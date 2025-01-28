import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/text_style_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/features/customer_setting/presentation/widgets/contact_us_card.dart';
import 'package:user_app/features/customer_setting/presentation/widgets/custom_expansion_tile.dart';
import 'package:user_app/features/customer_setting/presentation/widgets/faq_category_card.dart';

import '../../../../custom/textfield_custom.dart';

// ignore: must_be_immutable
class CustomerHelpAndSupportPage extends StatelessWidget {
  CustomerHelpAndSupportPage({super.key});

  List faqList = [
    'All',
    'General',
    'Account',
    'Payment',
    'Services',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
          centerTitle: true,
          title: Text(
            ' Help & Support',
            style: heading5Semi,
          ),
        ),
        body: Column(
          children: [
            TextFieldCustom(
              marginLeft: 35.w,
              marginRight: 35.w,
              marginBottom: 24.h,
              prefixIcon: ImageIcon(
                const AssetImage('assets/icons/search.png'),
                size: 24.h,
              ),
              hintText: 'Search Here...',
              hintstyle: heading6Mid.copyWith(color: neutral200),
            ),
            TabBar(
              labelPadding: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              indicatorPadding: EdgeInsets.symmetric(vertical: 6.h),
              splashBorderRadius: BorderRadius.circular(12.r),
              dividerColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              unselectedLabelColor: primaryColor,
              labelColor: whiteColor,
              indicator: ShapeDecoration(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              tabs: [
                Tab(
                  child: ContainerCustom(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(12.r),
                    width: 170.w,
                    height: 35.h,
                    child: Text(
                      'FAQ',
                      style: heading6Mid,
                    ),
                  ),
                ),
                Tab(
                  child: ContainerCustom(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(12.r),
                    width: 170.w,
                    height: 35.h,
                    child: Text(
                      'Contact Us',
                      style: heading6Mid,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        ContainerCustom(
                          marginLeft: 35.w,
                          marginTop: 24.h,
                          marginBottom: 24.h,
                          height: 41.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: faqList.length,
                            itemBuilder: (context, index) => FaqCategoryCard(
                              title: faqList[index],
                            ),
                          ),
                        ),
                        const CustomExpansionTile(
                          title: 'How do I track my order?',
                          description:
                              'You can track your order by going to the “My Orders” section and selecting the current order. The status will show whether the order is confirmed, on its way, or delivered.',
                        ),
                        const CustomExpansionTile(
                          title: 'Can I cancel my order?',
                          description:
                              'You can track your order by going to the “My Orders” section and selecting the current order. The status will show whether the order is confirmed, on its way, or delivered.',
                        ),
                        const CustomExpansionTile(
                          title: 'What if my order is late?',
                          description:
                              'You can track your order by going to the “My Orders” section and selecting the current order. The status will show whether the order is confirmed, on its way, or delivered.',
                        ),
                        const CustomExpansionTile(
                          title: 'What are the delivery options?',
                          description:
                              'You can track your order by going to the “My Orders” section and selecting the current order. The status will show whether the order is confirmed, on its way, or delivered.',
                        ),
                        const CustomExpansionTile(
                          title: 'Can I schedule a delivery?',
                          description:
                              'You can track your order by going to the “My Orders” section and selecting the current order. The status will show whether the order is confirmed, on its way, or delivered.',
                        ),
                      ],
                    ),
                  ),
                ),
        const Scaffold(
                  body: Column(
                    children: [
                      ContactUsCard(
                        title: 'https://example.com',
                        icon: 'assets/icons/website.png',
                      ),
                      ContactUsCard(
                        title: 'example@gmail.com',
                        icon: 'assets/icons/sms.png',
                      ),
                      ContactUsCard(
                        title: 'Address',
                        icon: 'assets/icons/location.png',
                      )
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

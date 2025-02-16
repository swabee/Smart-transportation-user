import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/notifications/presnetation/widgets/notification_card.dart';
import 'package:user_app/models/notification_model.dart';
import 'package:user_app/service_locator/service_locator.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = locator<FirebaseFirestore>();
    // final FirebaseFirestore firebaseAuth = locator<FirebaseFirestore>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextCustomWidget(
          text: "Notification",
          width: 85.w,
          height: 18.h,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, top: 40.h),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     TextCustomWidget(
              //       text: "TODAY",
              //       width: 53.w,
              //       height: 19.h,
              //       fontSize: 16.sp,
              //       fontWeight: FontWeight.w500,
              //       textColor: const Color(0xffB7B7B7),
              //     ),
              //     TextCustomWidget(
              //       text: "Mark all as read",
              //       width: 106.w,
              //       height: 17.h,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       textColor: const Color(0xff778E96),
              //     ),
              //   ],
              // ),
              StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('notifications') // Fetches all transactions
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No transactions found.'));
                  }

                  // Extract transaction data
                  final transactions =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();

                  return ContainerCustom(
                    marginTop: 20.h,
                    height: 600.h,
                    // bgColor: primaryColor,
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction =
                            transactions[index] as Map<String, dynamic>;
                        return  NotificationCard(
                            notificationModel: NotificationModel(
                                content:transaction['content'],
                                id: transaction['id'],
                                title: transaction['title'],
                                createdAt: transaction['createdAt'],
                                type: transaction['type']));
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 23.h),
              // const NotificationCard(),
              // const NotificationCard(),
              // const NotificationCard(),
              // SizedBox(height: 14.h),
              // Row(
              //   children: [
              //     TextCustomWidget(
              //       text: "YESTERDAY",
              //       width: 91.w,
              //       height: 19.h,
              //       fontSize: 16.sp,
              //       fontWeight: FontWeight.w500,
              //       textColor: const Color(0xffB7B7B7),
              //     ),
              //     SizedBox(width: 135.w),
              //     TextCustomWidget(
              //       text: "Mark all as read",
              //       width: 106.w,
              //       height: 17.h,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //       textColor: const Color(0xff778E96),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 23.h),
              // const NotificationCard(),
              // const NotificationCard(),
              // const NotificationCard(),
              // SizedBox(height: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}

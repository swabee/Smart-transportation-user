// ignore_for_file: deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/ksrtc_depos.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/booking/data/models/booking_model.dart';
import 'package:user_app/features/booking/presnetatioin/pages/live_tracking_page.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/features/qr_scanner/qr_scanner_for_prebookedUser_page.dart';

class RecentTripsTile extends StatefulWidget {
  const RecentTripsTile(
      {super.key, required this.bookingModel, required this.isActive});
  final BookingModel bookingModel;
  final bool isActive;

  @override
  State<RecentTripsTile> createState() => _RecentTripsTileState();
}


class _RecentTripsTileState extends State<RecentTripsTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('trips')
          .doc(widget.bookingModel.tripId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("Trip data not available."));
        }

    final tripModel = TripModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);


        return ContainerCustom(
          bgColor: primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(6.r),
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
          border: Border.all(color: primaryColor),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustomWidget(
                    text: 'Depo: '+ksrtcDepots.where((element) => element['id']==tripModel.depoId,).first['name'],
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  TextCustomWidget(
                    text: widget.bookingModel.status == BookingStatus.active
                        ? 'Active'
                        : widget.bookingModel.status == BookingStatus.completed
                            ? 'Completed'
                            : 'Cancelled',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    textColor: widget.bookingModel.status == BookingStatus.active
                        ? primaryColor
                        : widget.bookingModel.status == BookingStatus.completed
                            ? primaryColor
                            : Colors.yellow,
                  ),
                ],
              ),
              ContainerCustom(
                marginTop: 15.h,
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.bookingModel.bookedSeats.length,
                  itemBuilder: (context, index) {
                    final seatNumber = widget.bookingModel.bookedSeats[index];
                    return ContainerCustom(
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(7.r),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      bgColor: primaryColor.withOpacity(.3),
                      height: 50.h,
                      width: 50.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chair, size: 20.sp, color: primaryColor),
                          TextCustomWidget(
                            containerAlignment: Alignment.center,
                            text: seatNumber.toString(),
                            textColor: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (tripModel.isTripStarted && widget.isActive)
                ContainerCustom(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustomWidget(
                        marginLeft: 5.w,
                        marginTop: 10.h,
                        text: 'Track the bus',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LiveTrackingPage(
                                    tripId: widget.bookingModel.tripId,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.location_pin, color: primaryColor),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QrScannerForPrebookedUserPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.qr_code_scanner, color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (tripModel.isTeaBreak && widget.isActive)
                ContainerCustom(
                  marginTop: 5.h,
                  bgColor: Colors.yellow.withOpacity(.3),
                  borderRadius: BorderRadius.circular(2.4),
                  height: 40.h,
                  width: double.infinity,
                  child: const TextCustomWidget(
                    containerAlignment: Alignment.center,
                    text: 'Bus is on a tea break',
                    fontWeight: FontWeight.bold,
                    textColor: Colors.orange,
                  ),
                ),
              if (tripModel.isBreakdown&& widget.isActive)
                ContainerCustom(
                  marginTop: 5.h,
                  bgColor: Colors.yellow.withOpacity(.3),
                  borderRadius: BorderRadius.circular(2.4),
                  height: 40.h,
                  width: double.infinity,
                  child: const TextCustomWidget(
                    containerAlignment: Alignment.center,
                    text: 'Don’t worry! The bus had a breakdown but will restart soon.',
                    fontWeight: FontWeight.bold,
                    textColor: Colors.orange,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/booking/data/models/booking_model.dart';
import 'package:user_app/features/booking/presnetatioin/pages/live_tracking_page.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';

class RecentTripsTile extends StatefulWidget {
  const RecentTripsTile({super.key, required this.bookingModel});
  final BookingModel bookingModel;

  @override
  State<RecentTripsTile> createState() => _RecentTripsTileState();
}

class _RecentTripsTileState extends State<RecentTripsTile> {
  TripModel? tripModel;
  bool isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    fetchThisTripModel();
  }

  Future<void> fetchThisTripModel() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('trips')
          .doc(widget.bookingModel.tripId)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          tripModel = TripModel.fromJson(docSnapshot.data()!);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false; // No data found
        });
      }
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (tripModel == null) {
      return const Center(
        child: Text("Trip data not available."),
      );
    }

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
                text: 'Depo: ${tripModel!.depot} ',
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
              TextCustomWidget(
                text: (widget.bookingModel.status == BookingStatus.active)
                    ? 'Active'
                    : (widget.bookingModel.status == BookingStatus.completed)
                        ? 'Completed'
                        : 'Cancelled',
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                textColor: (widget.bookingModel.status == BookingStatus.active)
                    ? primaryColor
                    : (widget.bookingModel.status == BookingStatus.completed)
                        ? primaryColor
                        : Colors.yellow,
              ),
            ],
          ),
          TextCustomWidget(
            text: '${tripModel!.pickup}  to ${tripModel!.destination} ',
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
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
                        Icon(
                          Icons.chair,
                          size: 20.sp,
                          color: primaryColor,
                        ),
                        TextCustomWidget(
                          containerAlignment: Alignment.center,
                          text: seatNumber.toString(),
                          textColor: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ));
              },
            ),
          ),
          TextCustomWidget(
            marginLeft: 5.w,
            marginTop: 10.h,
            text: 'Arrival time : ${tripModel!.arrivalTime}',
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
          TextCustomWidget(
            marginLeft: 5.w,
            marginTop: 10.h,
            text:
                'Arrival date: ${tripModel!.date.day} / ${tripModel!.date.month} /${tripModel!.date.year}',
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
          if (widget.bookingModel.isStarted)
            ContainerCustom(
              child: Column(
                children: [
                  Row(
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
                          ContainerCustom(
                            borderRadius: BorderRadius.circular(8.r),
                            bgColor: primaryColor.withOpacity(.4),
                            padding: EdgeInsets.all(2.sp),
                            child: IconButton(
                                onPressed: () {
                                  if (widget.bookingModel.liveLocationLink !=
                                      null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                             const LiveLocationPage(
                                         ),
                                        ));
                                  }
                                },
                                icon: Icon(
                                  Icons.location_pin,
                                  color: primaryColor,
                                )),
                          ),
                          ContainerCustom(
                            marginLeft: 15.w,
                            borderRadius: BorderRadius.circular(8.r),
                            bgColor: primaryColor.withOpacity(.4),
                            padding: EdgeInsets.all(2.sp),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.call,
                                  color: primaryColor,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          if (widget.bookingModel.isFoodBreak)
            ContainerCustom(
              marginTop: 5.h,
              bgColor: Colors.yellow.withOpacity(.3),
              borderRadius: BorderRadius.circular(2.4),
              height: 40.h,
              width: double.infinity,
              child: const TextCustomWidget(
                containerAlignment: Alignment.center,
                text: 'Bus is on a tea breake',
                fontWeight: FontWeight.bold,
                textColor: Colors.orange,
              ),
            ),
          if (widget.bookingModel.isVechileOnDamage)
            ContainerCustom(
              marginTop: 5.h,
              bgColor: Colors.yellow.withOpacity(.3),
              borderRadius: BorderRadius.circular(2.4),
              height: 40.h,
              width: double.infinity,
              child: const TextCustomWidget(
                containerAlignment: Alignment.center,
                text: 'Dont worry! ,bus get breakdown will restart soon',
                fontWeight: FontWeight.bold,
                textColor: Colors.orange,
              ),
            )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/booking/data/cubit/all_booking_cubit.dart';
import 'package:user_app/features/booking/data/models/booking_model.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/search_for_booking_cubit.dart';

class ConfirmBookingPage extends StatefulWidget {
  const ConfirmBookingPage({super.key, required this.tripModel});
  final TripModel tripModel;

  @override
  State<ConfirmBookingPage> createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  String _selectedPaymentMethod = "Wallet";
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchForBookingCubit, SearchForBookingState>(
        builder: (context, searchForBookingstate) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextCustomWidget(
                    text: 'Trip Details',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey,
                  ),
                  TextCustomWidget(
                    marginLeft: 10.w,
                    marginBottom: 15.h,
                    marginTop: 15.h,
                    text:
                        '${searchForBookingstate.selectedPickup} to ${searchForBookingstate.selectedDestination} ',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  if (searchForBookingstate.selectedSeates != null)
                    ContainerCustom(
                      height: 90.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: searchForBookingstate.selectedSeates!.length,
                        itemBuilder: (context, index) {
                          final seat =
                              searchForBookingstate.selectedSeates![index];
                          return ContainerCustom(
                            borderRadius: BorderRadius.circular(3.r),
                            margin: EdgeInsets.all(10.sp),
                            // ignore: deprecated_member_use
                            bgColor: primaryColor.withOpacity(.3),
                            height: 90.sp,
                            width: 70.sp,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chair,
                                  color: primaryColor,
                                ),
                                TextCustomWidget(
                                  containerAlignment: Alignment.center,
                                  text: seat.toString(),
                                  fontWeight: FontWeight.bold,
                                  textColor: primaryColor,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextCustomWidget(
                    text: 'Invoice details',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ContainerCustom(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          text: 'Ticket Amount',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        TextCustomWidget(
                          text:
                              '₹ ${context.read<SearchForBookingCubit>().findDifferenceBetweenNodes(widget.tripModel) * convertToDouble(widget.tripModel.price)} X ${searchForBookingstate.selectedSeates!.length} = ${context.read<SearchForBookingCubit>().findDifferenceBetweenNodes(widget.tripModel) * convertToDouble(widget.tripModel.price) * (searchForBookingstate.selectedSeates!.length)} ',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: neutral200,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ContainerCustom(
                    marginTop: 25.h,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          text: 'GST',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        TextCustomWidget(
                          text: '₹ 8',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: neutral200,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ContainerCustom(
                    marginTop: 25.h,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          text: 'Platform Fee',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        TextCustomWidget(
                          text: '₹ 2',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: neutral200,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ContainerCustom(
                    marginTop: 25.h,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          text: 'Service charge',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        TextCustomWidget(
                          text: '₹ 10',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: neutral200,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ContainerCustom(
                    marginTop: 5.h,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomWidget(
                          text: 'Sub Total',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        TextCustomWidget(
                          text:
                              '₹  ${context.read<SearchForBookingCubit>().findDifferenceBetweenNodes(widget.tripModel) * convertToDouble(widget.tripModel.price) * (searchForBookingstate.selectedSeates!.length) + 20}',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          textColor: primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextCustomWidget(
                    text: 'Payments',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey,
                  ),
                  RadioListTile<String>(
                    activeColor: primaryColor,
                    title: const Text(
                      "Pay from Wallet",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: "Wallet",
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    activeColor: primaryColor,
                    title: const Text(
                      "Pay using UPI",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: "UPI",
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  ),
                  ButtonCustom(
                    inProgress: inProgress,
                    margin: EdgeInsets.only(top: 70.h),
                    btnColor: primaryColor,
                    text: 'Book Now',
                    callback: () async {
                      final currentUserId =
                          FirebaseAuth.instance.currentUser!.uid;
                      setState(() {
                        inProgress = true;
                      });
                      final updatedTripModel = widget.tripModel.copyWith(
                        bookedSeats: [
                          ...widget.tripModel.bookedSeats,
                          ...searchForBookingstate.selectedSeates!,
                        ],
                      );

                      final bookModel = BookingModel(
                          id: '',
                          tripId: widget.tripModel.id,
                          isStarted: false,
                          isFoodBreak: false,
                          isVechileOnDamage: false,
                          createdAt: DateTime.now(),
                          userId: currentUserId,
                          status: BookingStatus.active,
                          bookedSeats:
                              searchForBookingstate.selectedSeates ?? []);

                      final result = await context
                          .read<AllBookingCubit>()
                          .bookNow(bookModel, updatedTripModel, context);

                      result.fold(
                        (failure) {
                          setState(() {
                            inProgress = false;
                          });
                        },
                        (success) {
                          setState(() {
                            inProgress = false;
                          });
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  double convertToDouble(String value) {
    return double.tryParse(value) ?? 1.0;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/booking/data/cubit/all_booking_cubit.dart';
import 'package:user_app/features/booking/data/models/booking_model.dart';
import 'package:user_app/features/home/widgets/recent_trips_tile.dart';

class AllBookingPage extends StatefulWidget {
  const AllBookingPage({super.key});

  @override
  State<AllBookingPage> createState() => _AllBookingPageState();
}

class _AllBookingPageState extends State<AllBookingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<AllBookingCubit, AllBookingState>(
        builder: (context, allBookingState) {
          final activeBookings = allBookingState.bookings
              .where(
                (element) => element.status == BookingStatus.active,
              )
              .toList();
          final completedBookings = allBookingState.bookings
              .where(
                (element) => element.status == BookingStatus.completed,
              )
              .toList();
          final cancelledBookings = allBookingState.bookings
              .where(
                (element) => element.status == BookingStatus.cancelled,
              )
              .toList();
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(indicatorColor: primaryColor,
                unselectedLabelColor: const Color.fromARGB(255, 30, 107, 33),
                dividerColor: primaryColor,
                labelColor: primaryColor,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.directions_bus),
                    text: "Active",
                  ),
                  Tab(icon: Icon(Icons.history), text: "Completed"),
                  Tab(icon: Icon(Icons.cancel), text: "Cancelled"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                (activeBookings.isEmpty)
                    ? const TextCustomWidget(text: 'No Active Booking found')
                    : ContainerCustom(
                        height: 600.h,
                        child: ListView.builder(
                          itemCount: activeBookings.length,
                          itemBuilder: (context, index) {
                            final bookingModel = activeBookings[index];
                            return RecentTripsTile(bookingModel: bookingModel);
                          },
                        ),
                      ),
                (completedBookings.isEmpty)
                    ? TextCustomWidget(
                        text: 'No Completed Booking found',
                        containerAlignment: Alignment.center,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                      )
                    : ContainerCustom(
                        height: 600.h,
                        child: ListView.builder(
                          itemCount: completedBookings.length,
                          itemBuilder: (context, index) {
                            final bookingModel = completedBookings[index];
                            return RecentTripsTile(bookingModel: bookingModel);
                          },
                        ),
                      ),
                (cancelledBookings.isEmpty)
                    ? TextCustomWidget(
                        text: 'No Cancelled Booking found',
                        containerAlignment: Alignment.center,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                      )
                    : ContainerCustom(
                        height: 600.h,
                        child: ListView.builder(
                          itemCount: cancelledBookings.length,
                          itemBuilder: (context, index) {
                            final bookingModel = cancelledBookings[index];
                            return RecentTripsTile(bookingModel: bookingModel);
                          },
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

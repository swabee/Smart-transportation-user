import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/ksrtc_depos.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/booking/data/cubit/all_booking_cubit.dart';
import 'package:user_app/features/booking/presnetatioin/pages/booking_available_trips_page.dart';
import 'package:user_app/features/customer_setting/customer_profile/presentation/bloc/user_data_bloc.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/search_for_booking_cubit.dart';
import 'package:user_app/features/home/widgets/date_pick_list.dart';
import 'package:user_app/features/home/widgets/location_search_textField.dart';
import 'package:user_app/features/home/widgets/recent_trips_tile.dart';
import 'package:user_app/features/notifications/presnetation/pages/notification_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: whiteCOlor,
        elevation: 2.sp,
        shadowColor: Colors.grey,
        title: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoaded) {
              return TextCustomWidget(
                text: 'Hi ${state.userDataEntity.fName} !',
                fontSize: 17.sp,
              );
            }
            return const TextCustomWidget(text: 'Hi user !');
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ));
              },
              icon: Icon(
                Icons.notifications,
                color: primaryColor,
              ))
        ],
      ),
      backgroundColor: whiteCOlor,
      body: BlocBuilder<AllBookingCubit, AllBookingState>(
        builder: (context, allOrdersState) {
          return Stack(
            children: [
              // Main Content
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        ContainerCustom(
                          marginTop: 50.h,
                          child: Column(
                            children: [
                              LocationSearchCustomTextField(
                                fieldName: 'Select Pickup',
                                depots: ksrtcDepots,
                                onSelected: (selectedDepot) {
                                  context
                                      .read<SearchForBookingCubit>()
                                      .updatePickup(selectedDepot);
                                },
                              ),
                              ContainerCustom(
                                marginRight: 20.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          CupertinoIcons
                                              .arrow_up_arrow_down_circle_fill,
                                          size: 35.sp,
                                          color: primaryColor,
                                        ))
                                  ],
                                ),
                              ),
                              LocationSearchCustomTextField(
                                fieldName: 'Select destination',
                                depots: ksrtcDepots,
                                onSelected: (selectedDepot) {
                                  context
                                      .read<SearchForBookingCubit>()
                                      .updateDestination(selectedDepot);
                                },
                              ),
                              const DatePickList(),
                              //sesrch button
                              ContainerCustom(
                                marginLeft: 10.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonCustom(
                                      btnColor: primaryColor,
                                      margin: EdgeInsets.only(top: 30.h),
                                      btnHeight: 50.h,
                                      borderRadius: BorderRadius.circular(11.r),
                                      btnWidth: 330.w,
                                      textColor: whiteCOlor,
                                      text: 'Search',
                                      callback: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BookingAvailableTripsPage(),
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          color: boarderPrimaryColor,
                          thickness: 2.sp,
                        ),

                        // ContainerCustom(
                        //   height: 90.h,
                        //   marginTop: 15.h,
                        //   marginLeft: 10.w,
                        //   marginRight: 10.w,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return const OfferTile();
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: TextCustomWidget(
                      text: 'Recent Booking',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                  SliverList.builder(
                    itemCount: allOrdersState.bookings.length,
                    itemBuilder: (context, index) {
                      return RecentTripsTile(
                        bookingModel: allOrdersState.bookings[index],
                      );
                    },
                  )
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

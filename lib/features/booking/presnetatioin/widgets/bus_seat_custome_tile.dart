// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/search_for_booking_cubit.dart';

class BusSeatCustomeTile extends StatefulWidget {
  const BusSeatCustomeTile({
    super.key,
    required this.onClick,
    required this.isSold,
    required this.seatNumber,
    required this.tripModel,
  });
  final String seatNumber;
  final bool isSold;
  final VoidCallback onClick;
  final TripModel tripModel;

  @override
  State<BusSeatCustomeTile> createState() => _BusSeatCustomeTileState();
}

class _BusSeatCustomeTileState extends State<BusSeatCustomeTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchForBookingCubit, SearchForBookingState>(
      builder: (context, state) {
        bool isSeatBooked = widget.tripModel.bookedSeats
            .contains(int.parse(widget.seatNumber));
        bool isSeatSelected = state.selectedSeates != null &&
            state.selectedSeates!.contains(int.parse(widget.seatNumber));

        return ContainerCustom(
          callback: () {
            if (!isSeatBooked) {
              context.read<SearchForBookingCubit>().updateSelectedSeats(
                  int.parse(widget.seatNumber));
                  setState(() {
                    
                  });
            }
          },
          margin: EdgeInsets.all(5.sp),
          borderRadius: BorderRadius.circular(3.r),
          bgColor: isSeatBooked
              ? Colors.red.withOpacity(.3)
              : isSeatSelected
                  ? Colors.orange.withOpacity(.3)
                  : primaryColor.withOpacity(.3),
          height: 50.sp,
          width: 50.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chair,
                color: isSeatBooked
                    ? Colors.red
                    : isSeatSelected
                        ? Colors.orange
                        : primaryColor,
              ),
              TextCustomWidget(
                text: widget.seatNumber,
                containerAlignment: Alignment.center,
                textColor: isSeatBooked
                    ? Colors.red
                    : isSeatSelected
                        ? Colors.orange
                        : primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        );
      },
    );
  }
}


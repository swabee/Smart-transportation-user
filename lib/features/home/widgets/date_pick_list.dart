import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/search_for_booking_cubit.dart';

class DatePickList extends StatelessWidget {
  const DatePickList({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a list of dates from today to the next one month
    final dates = List.generate(
      30,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    return BlocBuilder<SearchForBookingCubit, SearchForBookingState>(
      builder: (context, state) {
        return ContainerCustom(
          marginTop: 20.h,
          marginLeft: 10.w,
          marginRight: 10.w,
          height: 60.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected =
                  state.selectedDate != null && _isSameDate(state.selectedDate!, date);

              return GestureDetector(
                onTap: () {
                  // Update the selected date in the cubit
                  context.read<SearchForBookingCubit>().updateBookingDate(date);
                },
                child: DatePickListTile(
                  day: _getDayName(date),
                  date: date.day.toString(),
                  isSelected: isSelected,
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Helper function to get day name (e.g., "Mon", "Tue")
  String _getDayName(DateTime date) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date.weekday % 7];
  }

  // Helper function to compare two dates (ignoring time)
  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class DatePickListTile extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const DatePickListTile({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.withOpacity(0.2) : whiteCOlor,
        border: Border.all(
          color: isSelected ? Colors.green : boarderPrimaryColor,
          width: 2.sp,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextCustomWidget(
            containerAlignment: Alignment.center,
            text: date, // Display the date
            textColor: isSelected ? Colors.green : textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
          TextCustomWidget(
            containerAlignment: Alignment.center,
            text: day, // Display the day
            textColor: isSelected ? Colors.green : textSecondaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}

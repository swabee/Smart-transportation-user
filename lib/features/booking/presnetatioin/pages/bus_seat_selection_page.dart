// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/custom/button_custom.dart';
import 'package:user_app/features/booking/presnetatioin/pages/confirm_booking_page.dart';
import 'package:user_app/features/booking/presnetatioin/widgets/bus_seat_custome_tile.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';

class BusSeatSelectionPage extends StatelessWidget {
  const BusSeatSelectionPage({super.key, required this.tripModel});
  final TripModel tripModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteCOlor,
      appBar: AppBar(
        backgroundColor: whiteCOlor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BusSeatCustomeTile(
                tripModel: tripModel,
                isSold: false,
                seatNumber: '1',
                onClick: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '2',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '3',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '4',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '5',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '6',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '7',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '8',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '9',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '10',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '11',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '12',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '13',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '14',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '15',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '16',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '17',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '18',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '19',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '20',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '21',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '22',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '23',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '24',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '25',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '26',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '27',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '28',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '29',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '30',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '31',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '32',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '33',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '34',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '35',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '36',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '37',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '38',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '39',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '40',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '41',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '42',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '43',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '44',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '45',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '46',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '47',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '48',
                        onClick: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '49',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '50',
                        onClick: () {},
                      ),
                      BusSeatCustomeTile(
                        tripModel: tripModel,
                        isSold: false,
                        seatNumber: '51',
                        onClick: () {},
                      ),
                    ],
                  ),
                ],
              ),
              ButtonCustom(
                margin: EdgeInsets.symmetric(vertical: 25.h),
                btnColor: primaryColor,
                text: 'Next',
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConfirmBookingPage(tripModel: tripModel),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

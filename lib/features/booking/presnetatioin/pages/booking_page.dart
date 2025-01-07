import 'package:flutter/material.dart';
import 'package:user_app/features/booking/presnetatioin/widgets/booking_card.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Bus Booking"),
        ),
        body: ListView(
          children: const [
            BookingCard(
              departureTime: "14:55",
              duration: "15:55 HRS",
              arrivalTime: "06:50, 08 Jan",
              busType: "SWIFT-HYBRID AC SEATER CU...",
              depot: "TRIVANDRUM DEPOT",
              busNumber: "1455TVMBNG",
              seatsAvailable: "0",
              price: "0",
              isSoldOut: true,
            ),
            BookingCard(
              departureTime: "15:05",
              duration: "15:55 HRS",
              arrivalTime: "07:00, 08 Jan",
              busType: "AC MULTI AXLE",
              depot: "TRIVANDRUM DEPOT",
              busNumber: "1505TVMBNG",
              seatsAvailable: "0",
              price: "0",
              isSoldOut: true,
            ),
            BookingCard(
              departureTime: "16:01",
              duration: "17:54 HRS",
              arrivalTime: "09:55, 08 Jan",
              busType: "AC MULTI AXLE",
              depot: "TRIVANDRUM DEPOT",
              busNumber: "1601TVMBNG",
              seatsAvailable: "5",
              price: "1711",
              isSoldOut: false,
            ),
          ],
        ),
      );
    
  }
}
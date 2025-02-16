import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/features/booking/presnetatioin/widgets/booking_card.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/search_for_booking_cubit.dart';

class BookingAvailableTripsPage extends StatelessWidget {
  const BookingAvailableTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchForBookingCubit>();

    return Scaffold(
      backgroundColor: whiteCOlor,
      appBar: AppBar(
        backgroundColor: whiteCOlor,
        title: const Text("Bus Booking"),
      ),
      body: StreamBuilder<List<TripModel>>(
        stream: searchCubit.streamAvailableBookingTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred: ${snapshot.error}"),
            );
          }

          final trips = snapshot.data ?? [];

          if (trips.isEmpty) {
            return  Center(
              child: BlocBuilder<SearchForBookingCubit, SearchForBookingState>(
                builder: (context, state) {
                  return  Text("No trips available. ${state.selectedPickup}");
                },
              ),
            );
          }

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return BookingCard(
                tripModel: trip,
              );
            },
          );
        },
      ),
    );
  }
}

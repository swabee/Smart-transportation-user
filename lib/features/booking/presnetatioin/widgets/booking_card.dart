import 'package:flutter/material.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/features/booking/presnetatioin/pages/bus_seat_selection_page.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';

class BookingCard extends StatelessWidget {
  final TripModel tripModel;

  const BookingCard({
    required this.tripModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteCOlor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tripModel.stops[tripModel.stops.length - 1],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tripModel.busType,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  tripModel.arrivalTime,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  tripModel.departureTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  tripModel.departureTime,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.event_seat,
                  color: Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  "${tripModel.bookedSeats.length} Seats",
                  style: TextStyle(
                    color: tripModel.isSoldOut ? Colors.red : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tripModel.busNumber,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
                tripModel.isSoldOut
                    ? const Text(
                        "SOLD OUT",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        "₹ ${tripModel.price}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_drop_down),
                  label: const Text("View More"),
                ),
                ElevatedButton(
                  onPressed: tripModel.isSoldOut
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BusSeatSelectionPage(tripModel: tripModel),
                              ));
                        },
                  child: const Text("Select Seat"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

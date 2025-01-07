import 'package:flutter/material.dart';
import 'package:user_app/constant/app_constant.dart';

class BookingCard extends StatelessWidget {
  final String departureTime;
  final String duration;
  final String arrivalTime;
  final String busType;
  final String depot;
  final String busNumber;
  final String seatsAvailable;
  final String price;
  final bool isSoldOut;

  const BookingCard({
    required this.departureTime,
    required this.duration,
    required this.arrivalTime,
    required this.busType,
    required this.depot,
    required this.busNumber,
    required this.seatsAvailable,
    required this.price,
    this.isSoldOut = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(color: whiteCOlor,
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
              depot,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              busType,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  departureTime,
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
                  duration,
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
                  arrivalTime,
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
                  "$seatsAvailable Seats",
                  style: TextStyle(
                    color: isSoldOut ? Colors.red : Colors.black87,
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
                  busNumber,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
                isSoldOut
                    ? const Text(
                        "SOLD OUT",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        "₹$price",
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
                  onPressed: isSoldOut ? null : () {},
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

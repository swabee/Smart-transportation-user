import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/ksrtc_depos.dart';
import 'package:user_app/custom/container_custom.dart';
import 'package:user_app/features/booking/presnetatioin/pages/bus_seat_selection_page.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/models/bus_model.dart';

class BookingCard extends StatefulWidget {
  final TripModel tripModel;

  const BookingCard({
    required this.tripModel,
    super.key,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  void initState() {
    fetchBus();
    super.initState();
  }

  fetchBus() {
    FirebaseFirestore.instance
        .collection('buses')
        .doc(widget.tripModel.busId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          thisBus = BusModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
        });
      } else {}
    }).catchError((e) {});
  }

  BusModel? thisBus;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteCOlor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: (thisBus == null)
          ? ContainerCustom(
              borderRadius: BorderRadius.circular(8.r),
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              height: 200.h,
              width: 350.w,
              bgColor: Colors.grey.shade400,
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ksrtcDepots
                        .where(
                          (element) => element['id'] == widget.tripModel.depoId,
                        )
                        .first['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    thisBus!.busType.type,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        ksrtcDepots
                            .where(
                              (element) =>
                                  element['id'] ==
                                  widget.tripModel.stopsModel[0].depoId,
                            )
                            .first['name'],
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
                        ksrtcDepots
                            .where(
                              (element) =>
                                  element['id'] ==
                                  widget
                                      .tripModel
                                      .stopsModel[
                                          widget.tripModel.stopsModel.length -
                                              1]
                                      .depoId,
                            )
                            .first['name'],
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
                        "${widget.tripModel.seats.length - widget.tripModel.bookedSeats.length} seats available",
                        style: TextStyle(
                          color: ((widget.tripModel.seats.length -
                                      widget.tripModel.bookedSeats.length) ==
                                  0)
                              ? Colors.red
                              : Colors.green,
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
                        thisBus!.pnrNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                      // tripModel.isSoldOut
                      //     ? const Text(
                      //         "SOLD OUT",
                      //         style: TextStyle(
                      //           color: Colors.red,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //         ),
                      //       )
                      //     : Text(
                      //         "₹ ${tripModel.price}",
                      //         style: const TextStyle(
                      //           color: Colors.green,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        label: const Text(""),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusSeatSelectionPage(
                                    tripModel: widget.tripModel,
                                    busModel: thisBus!),
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

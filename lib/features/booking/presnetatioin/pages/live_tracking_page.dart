import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/constant/app_constant.dart';
import 'package:user_app/constant/firebse_constants.dart';
import 'package:user_app/constant/ksrtc_depos.dart';
import 'package:user_app/custom/text_custom.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/service_locator/service_locator.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({super.key, required this.tripId});
  final String tripId;

  @override
  State<LiveTrackingPage> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<LiveTrackingPage> {
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();
  late TripModel trip;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('trips').doc(widget.tripId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("Trip not found"));
        }

        // Convert the document snapshot into a TripModel
        trip =
            TripModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
        if (trip.isTripStarted == false) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextCustomWidget(
                  containerAlignment: Alignment.center,
                  text: 'Trip is not started yet',
                  fontSize: 20.sp,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                )
              ],
            ),
          );
        }
        // Get the next stop
        // StopsModel nextStop = trip.stopsModel[trip.currentStopIndex];

        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
            backgroundColor: primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // QR Code for the trip

                const SizedBox(height: 20),

                // Trip info
                // Text('Trip ID: ${trip.tripId}'),
                // Text('Depo ID: ${trip.depoId}'),

                // Text('Next Trip Date: ${trip.nextTripDate.toDate()}'),

                const SizedBox(height: 20),
                if (trip.isBreakdown == true)
                  TextCustomWidget(
                    height: 100.h,
                    containerAlignment: Alignment.center,
                    text: 'Bus Breake down Dont worry new bus is on the way',
                    fontSize: 20.sp,
                  ),
                if (trip.isTeaBreak == true)
                  Column(
                    children: [
                      TextCustomWidget(
                        height: 100.h,
                        containerAlignment: Alignment.center,
                        text: 'Bus is on tea breake',
                        fontSize: 20.sp,
                      ),
                      // Switch(
                      //   value: trip.isTeaBreak,
                      //   onChanged: (value) async {
                      //     if (value) {
                      //       await _firestore
                      //           .collection('trips')
                      //           .doc(widget.tripId)
                      //           .update({
                      //         'is_teabreak': false,
                      //       });
                      //     }
                      //   },
                      // ),
                    ],
                  ),

                // if (!trip.isBreakdown && !trip.isTeaBreak)
                Expanded(
                  child: ListView.builder(
                    itemCount: trip.stopsModel.length,
                    itemBuilder: (context, index) {
                      StopsModel stop = trip.stopsModel[index];
                      return ListTile(
                        title: Text('${ksrtcDepots.where(
                              (element) => element['id'] == stop.depoId,
                            ).first['name']}'),
                        subtitle: Text(
                            'Arrival Time: ${defaultTimeFormat.format(stop.arrivalTime.toDate())}'),
                        trailing: Icon(
                          index <= trip.currentStopIndex
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // // Update the current stop index and save to Firestore
  // Future<void> _onNextStop() async {
  //   if (trip.currentStopIndex < trip.stopsModel.length - 1) {
  //     final newStopIndex = trip.currentStopIndex + 1;
  //     await _firestore
  //         .collection('trips')
  //         .doc(widget.tripId)
  //         .update({'current_stop_index': newStopIndex});
  //   }
  // }


}

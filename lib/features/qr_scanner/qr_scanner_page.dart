// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:user_app/features/booking/data/models/booking_model.dart';
import 'package:user_app/features/common_methos/common_methos.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/models/bus_model.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/snackbar_service.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool isScanning = true;
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    // Start scanning automatically
    _scannerController.start();
  }

  void _onDetect(BarcodeCapture capture) {
    final Barcode? barcode = capture.barcodes.firstOrNull;
    final String? code = barcode?.rawValue;

    if (code != null && isScanning) {
      setState(() {
        isScanning = false; // Stop scanning to prevent duplicate results
      });

      showSuccess(code);

      // Reset scanning after a brief delay to allow for continuous scanning
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isScanning = true; // Enable scanning again
        });

        _scannerController.start(); // Restart the scanner
      });
    }
  }

  void showSuccess(String id) async {
    TripModel? tripModel;
    final selectedDateOnly = Timestamp.fromDate(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
    setState(() {
      isScanned = true;
    });
    // BookingModel? currentRide;
    final SnackBarService service = locator<SnackBarService>();
    final FirebaseAuth firebaseAuth = locator<FirebaseAuth>();

    {
      try {
        final docSnapshot =
            await FirebaseFirestore.instance.collection('trips').doc(id).get();

        if (docSnapshot.exists) {
          tripModel = TripModel.fromJson(docSnapshot.data()!);

          // final prebookings = await FirebaseFirestore.instance
          //     .collection('bookings')
          //     .where('tripId', isEqualTo: tripModel.tripId)
          //     .where('booking_date', isEqualTo: selectedDateOnly)
          //     .where('isPrebooked', isEqualTo: true)
          //     .where('status', isEqualTo: BookingStatus.active)
          //     .limit(1)
          //     .get();

          // if (prebookings.docs.isNotEmpty) {
          //   // Get the first document
          //   final bookingData = prebookings.docs.first.data();

          //   // if user enter before pickup address
          //   final index = tripModel.stopsModel.indexWhere(
          //     (element) => element.depoId == bookingData['pickupIndex'],
          //   );

          //   final destinationindex = tripModel.stopsModel.indexWhere(
          //     (element) => element.depoId == bookingData['destinationIndex'],
          //   );

          //   if (index <= tripModel.currentStopIndex &&
          //       destinationindex <= tripModel.currentStopIndex &&
          //       tripModel.currentUserId
          //           .contains(firebaseAuth.currentUser!.uid)) {
          //     service.showSuccess('Pre booked user exit before des', context);

          //     await FirebaseFirestore.instance
          //         .collection('trips')
          //         .doc(tripModel.tripId)
          //         .update({
          //       'booked_seates':
          //           FieldValue.arrayRemove([bookingData['bookedSeats']]),
          //     }).then(
          //       (value) async {
          //         await FirebaseFirestore.instance
          //             .collection('trips')
          //             .doc(bookingData['id'])
          //             .update({
          //           'status': 'completed',
          //         });
          //       },
          //     );

          //     setState(() {
          //       isScanned = false;
          //     });

          //     service.showSuccess(
          //         'Thankyou for using Gofast ,have a nice day', context);
          //     Navigator.pop(context);
          //   }
          //   //booked user enter
          //   else if (index <= tripModel.currentStopIndex &&
          //       destinationindex <= tripModel.currentStopIndex) {
          //     print('Pre booked user enter');
          //     await FirebaseFirestore.instance
          //         .collection('trips')
          //         .doc(id)
          //         .update({
          //       'current_users_id':
          //           FieldValue.arrayUnion([firebaseAuth.currentUser!.uid]),
          //     });
          //   } else if (index <= tripModel.currentStopIndex &&
          //       destinationindex > tripModel.currentStopIndex) {
          //     service.showSuccess('Pre booked user exit after des', context);

          //     setState(() {
          //       isScanned = false;
          //     });
          //     Navigator.pop(context);
          //     final busquerySnapshot = await FirebaseFirestore.instance
          //         .collection('buses')
          //         .where('bus_id', isEqualTo: tripModel.busId)
          //         .limit(1)
          //         .get();
          //     final userdocSnapshot = await FirebaseFirestore.instance
          //         .collection('users')
          //         .doc(firebaseAuth.currentUser!.uid)
          //         .get();
          //     if (busquerySnapshot.docs.isNotEmpty && userdocSnapshot.exists) {
          //       try {
          //         final userdata =
          //             UserDataModel.fromJson(userdocSnapshot.data()!);

          //         final thisbus =
          //             BusModel.fromJson(busquerySnapshot.docs.first.data());
          //         var fareAmount =
          //             (((tripModel.currentStopIndex - destinationindex).abs()) *
          //                 thisbus.busType.busCharge);
          //         await FirebaseFirestore.instance
          //             .collection('users')
          //             .doc(userdata.id)
          //             .update({
          //           'wallet_balance': (userdata.walletBalance - fareAmount)
          //         });
          //         // final newbookingmodel = thisbooking.copyWith(
          //         //     status: BookingStatus.completed,
          //         //     destinationIndex: tripModel.currentStopIndex);
          //         await FirebaseFirestore.instance
          //             .collection('bookings')
          //             .doc(bookingData['id'])
          //             .update({'destinationIndex': destinationindex});
          //         await FirebaseFirestore.instance
          //             .collection('trips')
          //             .doc(bookingData['id'])
          //             .update({
          //           'status': 'completed',
          //         });
          //         service.showSuccess(
          //             'You exit after destination so an amount of $fareAmount is debited from wallet',
          //             context);
          //       } catch (e) {
          //         service.showSuccess(e.toString(), context);
          //       }
          //     }
          //   } else {
          //     service.showSuccess(
          //         'Pre booked user enter  before pick', context);

          //     setState(() {
          //       isScanned = false;
          //     });
          //     Navigator.pop(context);
          //     final busquerySnapshot = await FirebaseFirestore.instance
          //         .collection('buses')
          //         .where('bus_id', isEqualTo: tripModel.busId)
          //         .limit(1)
          //         .get();
          //     final userdocSnapshot = await FirebaseFirestore.instance
          //         .collection('users')
          //         .doc(firebaseAuth.currentUser!.uid)
          //         .get();
          //     if (busquerySnapshot.docs.isNotEmpty && userdocSnapshot.exists) {
          //       try {
          //         final userdata =
          //             UserDataModel.fromJson(userdocSnapshot.data()!);

          //         final thisbus =
          //             BusModel.fromJson(busquerySnapshot.docs.first.data());
          //         var fareAmount =
          //             (((tripModel.currentStopIndex - index).abs()) *
          //                 thisbus.busType.busCharge);
          //         await FirebaseFirestore.instance
          //             .collection('users')
          //             .doc(userdata.id)
          //             .update({
          //           'wallet_balance': (userdata.walletBalance - fareAmount)
          //         });
          //         await FirebaseFirestore.instance
          //             .collection('trips')
          //             .doc(id)
          //             .update({
          //           'current_users_id':
          //               FieldValue.arrayUnion([firebaseAuth.currentUser!.uid]),
          //         });
          //         // final newbookingmodel = thisbooking.copyWith(
          //         //     status: BookingStatus.completed,
          //         //     destinationIndex: tripModel.currentStopIndex);
          //         await FirebaseFirestore.instance
          //             .collection('bookings')
          //             .doc(bookingData['id'])
          //             .update({'pickupIndex': index});
          //         service.showSuccess(
          //             'You enter before pickup so an amount of $fareAmount is debited from wallet',
          //             context);
          //       } catch (e) {
          //         service.showSuccess(e.toString(), context);
          //       }
          //     }
          //   }
          // }

          //check user already enter in bus
          if (tripModel.currentUserId
              .where(
                (element) => element == firebaseAuth.currentUser!.uid,
              )
              .isNotEmpty) {
            final querySnapshot = await FirebaseFirestore.instance
                .collection('bookings')
                .where('tripId', isEqualTo: tripModel.tripId)
                .where('status', isEqualTo: 'active')
                .limit(1)
                .get();

            final busquerySnapshot = await FirebaseFirestore.instance
                .collection('buses')
                .where('bus_id', isEqualTo: tripModel.busId)
                .limit(1)
                .get();
            final userdocSnapshot = await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseAuth.currentUser!.uid)
                .get();
            if (querySnapshot.docs.isNotEmpty &&
                busquerySnapshot.docs.isNotEmpty &&
                userdocSnapshot.exists) {
              try {
                final userdata =
                    UserDataModel.fromJson(userdocSnapshot.data()!);

                final thisbooking =
                    BookingModel.fromJson(querySnapshot.docs.first.data());
                final thisbus =
                    BusModel.fromJson(busquerySnapshot.docs.first.data());
                await FirebaseFirestore.instance
                    .collection('trips')
                    .doc(tripModel.tripId)
                    .update({
                  'current_users_id':
                      FieldValue.arrayRemove([firebaseAuth.currentUser!.uid]),
                  'booked_seates':
                      FieldValue.arrayRemove(thisbooking.bookedSeats),
                }).then(
                  (value) async {
                    var fareAmount = (((tripModel!.currentStopIndex -
                                thisbooking.pickupIndex) +
                            1) *
                        thisbus.busType.busCharge);
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userdata.id)
                        .update({
                      'wallet_balance': (userdata.walletBalance - fareAmount)
                    });
                    final newbookingmodel = thisbooking.copyWith(
                        status: BookingStatus.completed,
                        destinationIndex: tripModel.currentStopIndex);
                    await FirebaseFirestore.instance
                        .collection('bookings')
                        .doc(thisbooking.id)
                        .update(newbookingmodel.toJson());
                    await addTranscationHistory(
                        content:
                            'Rs $fareAmount  Debited ',
                        title: 'Fare Collected',
                        isCredit: false);
                    await addNotification(
                        content:
                            'Rs $fareAmount debited as a ticket fare amount',
                        title: 'Payment Debited ',
                        type: 'payment');

                    service.showSuccess(
                        'Thankyou for using Gofast ,we recive $fareAmount from you wallet',
                        context);
                    if (userdata.walletBalance <= 30) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Low Balance"),
                          content: const Text(
                              "Your balance is less than 30. Please recharge."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              } catch (e) {
                service.showSuccess(e.toString(), context);
              }
            } else {
              service.showSuccess('error in bookimg fetch', context);
            }
          }
          //adduser to the bus
          else {
            await FirebaseFirestore.instance
                .collection('trips')
                .doc(id)
                .update({
              'current_users_id':
                  FieldValue.arrayUnion([firebaseAuth.currentUser!.uid]),
              'booked_seates': FieldValue.arrayUnion([
                (findavaibleseatIndex(tripModel.bookedSeats, tripModel.seats) +
                    1)
              ]),
            });
            DocumentReference bookingDoc =
                FirebaseFirestore.instance.collection('bookings').doc();
            final bookingModel = BookingModel(
                id: bookingDoc.id,
                bookedSeats: [
                  (findavaibleseatIndex(
                          tripModel.bookedSeats, tripModel.seats) +
                      1)
                ],
                isPrebooked: false,
                userId: firebaseAuth.currentUser!.uid,
                pickupIndex: tripModel.currentStopIndex,
                tripId: tripModel.tripId,
                status: BookingStatus.active,
                bookingDate: Timestamp.now());
            await FirebaseFirestore.instance
                .collection('bookings')
                .doc(bookingDoc.id)
                .set(bookingModel.toJson());

            service.showSuccess(
                'Your seat number is ${(findavaibleseatIndex(tripModel.bookedSeats, tripModel.seats) + 1)}',
                context);
          }
        } else {
          setState(() {});
        }
      } catch (e) {
        // Handle error
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (isScanned) {
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: const Text("Processig"),
    //         content: ContainerCustom(
    //           height: 100.h,
    //           child: Center(
    //             child: CircularProgressIndicator(
    //               color: primaryColor,
    //             ),
    //           ),
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.pop(context),
    //             child: const Text("OK"),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _scannerController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _onDetect,
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 4),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int findavaibleseatIndex(List<int> a, List<int> b) {
    for (int i = 0; i < b.length; i++) {
      if (!a.contains(b[i])) {
        return i;
      }
    }
    return -1;
  }
}

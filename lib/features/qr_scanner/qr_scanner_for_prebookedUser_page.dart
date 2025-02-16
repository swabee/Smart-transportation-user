// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:user_app/features/common_methos/common_methos.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';
import 'package:user_app/models/bus_model.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/snackbar_service.dart';

class QrScannerForPrebookedUserPage extends StatefulWidget {
  const QrScannerForPrebookedUserPage({super.key});

  @override
  State<QrScannerForPrebookedUserPage> createState() =>
      _QrScannerForPrebookedUserPageState();
}

class _QrScannerForPrebookedUserPageState
    extends State<QrScannerForPrebookedUserPage> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool isScanning = true;
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    _scannerController.start(); // Start scanning automatically
  }

  void _onDetect(BarcodeCapture capture) {
    final Barcode? barcode = capture.barcodes.firstOrNull;
    final String? code = barcode?.rawValue;

    if (code != null && isScanning) {
      setState(() {
        isScanning = false; // Stop scanning to prevent duplicate scans
      });

      showSuccess(code);

      // Restart scanning after a short delay
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isScanning = true;
        });
        _scannerController.start();
      });
    }
  }

  Future<void> showSuccess(String id) async {
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

    final SnackBarService service = locator<SnackBarService>();
    final FirebaseAuth firebaseAuth = locator<FirebaseAuth>();

    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('trips').doc(id).get();

      if (docSnapshot.exists) {
        tripModel = TripModel.fromJson(docSnapshot.data()!);

        final prebookings = await FirebaseFirestore.instance
            .collection('bookings')
            .where('tripId', isEqualTo: tripModel.tripId)
            .where('booking_date', isEqualTo: selectedDateOnly)
            .where('isPrebooked', isEqualTo: true)
            .where('status', isEqualTo: 'active')
            .limit(1)
            .get();

        if (prebookings.docs.isNotEmpty) {
          final bookingData = prebookings.docs.first.data();

          final index = tripModel.stopsModel.indexWhere(
            (element) => element.depoId == bookingData['pickupIndex'],
          );

          final destinationIndex = tripModel.stopsModel.indexWhere(
            (element) => element.depoId == bookingData['destinationIndex'],
          );

          if (destinationIndex >= tripModel.currentStopIndex &&
              tripModel.currentUserId.contains(firebaseAuth.currentUser!.uid)) {
            // service.showSuccess('Pre-booked user exited before destination.', context);

            await FirebaseFirestore.instance
                .collection('trips')
                .doc(tripModel.tripId)
                .update({
              'booked_seates':
                  FieldValue.arrayRemove(bookingData['bookedSeats']),
            });

            await FirebaseFirestore.instance
                .collection('bookings')
                .doc(bookingData['id'])
                .update({'status': 'completed'});

            setState(() {
              isScanned = false;
            });

            service.showSuccess(
                'Thank you for using GoFast. Have a nice day!', context);
            Navigator.pop(context);
          } else if (index <= tripModel.currentStopIndex &&
              !tripModel.currentUserId
                  .contains(firebaseAuth.currentUser!.uid)) {
            await FirebaseFirestore.instance
                .collection('trips')
                .doc(id)
                .update({
              'current_users_id':
                  FieldValue.arrayUnion([firebaseAuth.currentUser!.uid]),
            });
          } else if (index > tripModel.currentStopIndex &&
              !tripModel.currentUserId
                  .contains(firebaseAuth.currentUser!.uid)) {
            handleExtraFare(service, firebaseAuth, tripModel, bookingData,
                index, destinationIndex, false);
          } else if (destinationIndex < tripModel.currentStopIndex &&
              tripModel.currentUserId.contains(firebaseAuth.currentUser!.uid)) {
            handleExtraFare(service, firebaseAuth, tripModel, bookingData,
                index, destinationIndex, true);
          }
        }
      }
    } catch (e) {
      service.showSuccess('Error: $e', context);
    }
  }

  Future<void> handleExtraFare(
      SnackBarService service,
      FirebaseAuth firebaseAuth,
      TripModel tripModel,
      Map<String, dynamic> bookingData,
      int index,
      int destinationIndex,
      bool isLateExit) async {
    // service.showSuccess('Pre-booked user exit after destination.', context);
    // setState(() {
    //   isScanned = false;
    // });
    // Navigator.pop(context);

    final busQuerySnapshot = await FirebaseFirestore.instance
        .collection('buses')
        .where('bus_id', isEqualTo: tripModel.busId)
        .limit(1)
        .get();

    final userDocSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    if (busQuerySnapshot.docs.isNotEmpty &&
        userDocSnapshot.exists &&
        isLateExit) {
      try {
        final userData = UserDataModel.fromJson(userDocSnapshot.data()!);
        final thisBus = BusModel.fromJson(busQuerySnapshot.docs.first.data());

        var fareAmount =
            (((tripModel.currentStopIndex - destinationIndex).abs()) *
                thisBus.busType.busCharge);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userData.id)
            .update({'wallet_balance': (userData.walletBalance - fareAmount)});

        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(bookingData['id'])
            .update({
          'destinationIndex':
              tripModel.stopsModel[tripModel.currentStopIndex].depoId,
          'status': 'completed'
        });

        await FirebaseFirestore.instance
            .collection('trips')
            .doc(tripModel.tripId)
            .update({
          'current_users_id':
              FieldValue.arrayRemove([firebaseAuth.currentUser!.uid])
        });
        await addTranscationHistory(
            content: 'Rs $fareAmount  Debited ',
            title: 'Fare Collected',
            isCredit: false);
        await addNotification(
            content:
                'You exited after the destination. An amount of $fareAmount has been debited from your wallet.',
            title: 'Payment Debited ',
            type: 'payment');
        service.showSuccess(
            'You exited after the destination. An amount of $fareAmount has been debited from your wallet.',
            context);
      } catch (e) {
        service.showSuccess('Error: $e', context);
      }
    } else if (busQuerySnapshot.docs.isNotEmpty &&
        userDocSnapshot.exists &&
        !isLateExit) {
      try {
        final userData = UserDataModel.fromJson(userDocSnapshot.data()!);
        final thisBus = BusModel.fromJson(busQuerySnapshot.docs.first.data());

        var fareAmount = (((tripModel.currentStopIndex - index).abs()) *
            thisBus.busType.busCharge);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userData.id)
            .update({'wallet_balance': (userData.walletBalance - fareAmount)});

        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(bookingData['id'])
            .update({
          'pickupIndex': tripModel.stopsModel[tripModel.currentStopIndex].depoId
        });

        await FirebaseFirestore.instance
            .collection('trips')
            .doc(tripModel.tripId)
            .update({
          'current_users_id':
              FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
        });
        await addTranscationHistory(
            content: 'Rs $fareAmount  Debited ',
            title: 'Fare Collected',
            isCredit: false);
        await addNotification(
            content:
                'You enter before pickup point. An amount of $fareAmount has been debited from your wallet.',
            title: 'Payment Debited ',
            type: 'payment');
        service.showSuccess(
            'You enter before pickup point. An amount of $fareAmount has been debited from your wallet.',
            context);
      } catch (e) {
        service.showSuccess('Error: $e', context);
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
}

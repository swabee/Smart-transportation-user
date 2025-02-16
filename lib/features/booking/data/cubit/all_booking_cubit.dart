// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_app/features/base/presentation/pages/base_page.dart';
import 'package:user_app/features/booking/data/models/booking_model.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/entities/user_data_entity.dart';
import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';

class AllBookingState extends Equatable {
  final List<BookingModel> bookings;

  const AllBookingState({this.bookings = const []});

  AllBookingState copyWith({List<BookingModel>? bookings}) {
    return AllBookingState(
      bookings: bookings ?? this.bookings,
    );
  }

  @override
  List<Object?> get props => [bookings];
}

class AllBookingCubit extends Cubit<AllBookingState> {
  AllBookingCubit() : super(const AllBookingState()) {
    _initializeAuthenticationListener();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription? _bookingSubscription;
  StreamSubscription? _authSubscription;

  /// Listens for authentication changes and initializes booking fetching after login.
  void _initializeAuthenticationListener() {
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _initializeBookingListener(user.uid);
      } else {
        _cancelBookingListener();
        emit(const AllBookingState());
      }
    });
  }

  /// Initializes the listener to fetch bookings for the authenticated user.
  void _initializeBookingListener(String userId) {
    _bookingSubscription?.cancel(); // Cancel any existing listener
    _bookingSubscription = _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        // .orderBy('createdAt')
        .snapshots()
        .listen((snapshot) {
      final bookings = snapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data());
      }).toList();
      emit(state.copyWith(bookings: bookings));
    });
  }

  /// Cancels the booking listener.
  void _cancelBookingListener() {
    _bookingSubscription?.cancel();
    _bookingSubscription = null;
  }

  /// Book now and return the result.
  Future<Either<String, BookingModel>> bookNow(
      BookingModel booking,
      TripModel tripModel,
      BuildContext context,
      UserDataEntity userData,
      double ticketCharge) async {
    try {
      final newId = _firestore.collection('bookings').doc().id;

      final updatedBooking = booking.copyWith(id: newId);

      await _firestore
          .collection('bookings')
          .doc(newId)
          .set(updatedBooking.toJson());
      await _firestore
          .collection('trips')
          .doc(tripModel.tripId)
          .update({'booked_seates': tripModel.bookedSeats});
      await _firestore
          .collection('users')
          .doc(userData.id)
          .update({'wallet_balance': (userData.walletBalance - ticketCharge)});

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BasePage(),
        ),
        (route) => false,
      );
      return Right(updatedBooking);
    } catch (e) {
      // Return the error message
      return Left("Failed to book: $e");
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _bookingSubscription?.cancel();
    return super.close();
  }
}

// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:user_app/features/base/presentation/pages/base_page.dart';
// import 'package:user_app/features/booking/data/models/booking_model.dart';
// import 'package:user_app/features/home/presentation/search-for-booking-cubit/model/trip_model.dart';

// class AllBookingState extends Equatable {
//   final List<BookingModel> bookings;

//   const AllBookingState({this.bookings = const []});

//   AllBookingState copyWith({List<BookingModel>? bookings}) {
//     return AllBookingState(
//       bookings: bookings ?? this.bookings,
//     );
//   }

//   @override
//   List<Object?> get props => [bookings];
// }

// class AllBookingCubit extends Cubit<AllBookingState> {
//   AllBookingCubit() : super(const AllBookingState()) {
//     _initializeListener();
//   }

//   final _firestore = FirebaseFirestore.instance;
//   final _currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   StreamSubscription? _bookingSubscription;

//   /// Initializes the listener to fetch bookings.
//   void _initializeListener() {
//     _bookingSubscription = _firestore
//         .collection('bookings')
//         .where('userId', isEqualTo: _currentUserId)
//         .orderBy('createdAt',)
//         .snapshots()
//         .listen((snapshot) {
//       final bookings = snapshot.docs.map((doc) {
//         return BookingModel.fromJson(doc.data());
//       }).toList();
//       emit(state.copyWith(bookings: bookings));
//     });
//   }

//   /// Book now and return the result.
//   Future<Either<String, BookingModel>> bookNow(
//       BookingModel booking, TripModel tripModel, BuildContext context) async {
//     try {
//       final newId = _firestore.collection('bookings').doc().id;

//       final updatedBooking = booking.copyWith(id: newId);

//       await _firestore
//           .collection('bookings')
//           .doc(newId)
//           .set(updatedBooking.toJson());
//       await _firestore
//           .collection('trips')
//           .doc(tripModel.id)
//           .update({'bookedSeats': tripModel.bookedSeats});

//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const BasePage(),
//         ),
//         (route) => false,
//       );
//       return Right(updatedBooking);
//     } catch (e) {
//       // Return the error message
//       return Left("Failed to book: $e");
//     }
//   }

//   @override
//   Future<void> close() {
//     _bookingSubscription?.cancel();
//     return super.close();
//   }
// }

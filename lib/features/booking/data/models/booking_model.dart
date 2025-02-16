import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingStatus { cancelled, active, completed }

class BookingModel {
  final String id;
  final List<int> bookedSeats;
  final bool isPrebooked;
  final String userId;
  final int pickupIndex;
  final int? destinationIndex;
  final String tripId;
  final BookingStatus status;
  final Timestamp bookingDate;
  BookingModel(
      {required this.id,
      required this.bookedSeats,
      required this.isPrebooked,
      required this.userId,
      required this.pickupIndex,
      this.destinationIndex, // Nullable
      required this.tripId,
      required this.status,
      required this.bookingDate});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
        id: json['id'] as String,
        bookedSeats: List<int>.from(json['bookedSeats']),
        isPrebooked: json['isPrebooked'] as bool,
        userId: json['userId'] as String,
        pickupIndex: json['pickupIndex'] as int,
        destinationIndex: json['destinationIndex'] as int?, // Nullable
        tripId: json['tripId'] as String,
        status: BookingStatus.values.firstWhere(
            (e) => e.toString() == 'BookingStatus.${json['status']}'),
        bookingDate: json['booking_date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookedSeats': bookedSeats,
      'isPrebooked': isPrebooked,
      'userId': userId,
      'pickupIndex': pickupIndex,
      'destinationIndex': destinationIndex, // Nullable
      'tripId': tripId,
      'status': status.toString().split('.').last, 'booking_date': bookingDate
    };
  }

  BookingModel copyWith(
      {String? id,
      List<int>? bookedSeats,
      bool? isPrebooked,
      String? userId,
      int? pickupIndex,
      int? destinationIndex,
      String? tripId,
      BookingStatus? status,
      Timestamp? bookingDate}) {
    return BookingModel(
        id: id ?? this.id,
        bookedSeats: bookedSeats ?? this.bookedSeats,
        isPrebooked: isPrebooked ?? this.isPrebooked,
        userId: userId ?? this.userId,
        pickupIndex: pickupIndex ?? this.pickupIndex,
        destinationIndex: destinationIndex ?? this.destinationIndex,
        tripId: tripId ?? this.tripId,
        status: status ?? this.status,
        bookingDate: bookingDate ?? this.bookingDate);
  }
}

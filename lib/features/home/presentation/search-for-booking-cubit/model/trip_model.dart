import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final String destination;
  final String pickup;
  final DateTime date;
  final String departureTime;
  final String duration;
  final String arrivalTime;
  final String busType;
  final String depot;
  final String busNumber;
  final String seatsAvailable;
  final String price;
  final bool isSoldOut;
  final List<int> seats;
  final List<int> bookedSeats;
  final String tripId;
  final String? busId; // nullable
  final List<String> stops; // List of stops

  TripModel({
    required this.id,
    required this.destination,
    required this.pickup,
    required this.date,
    required this.departureTime,
    required this.duration,
    required this.arrivalTime,
    required this.busType,
    required this.depot,
    required this.busNumber,
    required this.seatsAvailable,
    required this.price,
    required this.isSoldOut,
    required this.seats,
    required this.bookedSeats,
    required this.tripId,
    this.busId,
    required this.stops,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      destination: json['destination'],
      pickup: json['pickup'],
      date: json['date'] is Timestamp
          ? (json['date'] as Timestamp).toDate()
          : DateTime.parse(json['date']), // Handle Timestamp or string
      departureTime: json['departureTime'],
      duration: json['duration'],
      arrivalTime: json['arrivalTime'],
      busType: json['busType'],
      depot: json['depot'],
      busNumber: json['busNumber'],
      seatsAvailable: json['seatsAvailable'],
      price: json['price'],
      isSoldOut: json['isSoldOut'],
      seats: List<int>.from(json['seats']),
      bookedSeats: List<int>.from(json['bookedSeats']),
      tripId: json['tripId'],
      busId: json['busId'],
      stops: List<String>.from(json['stops']),
    );
  }

  TripModel copyWith({
    String? id,
    String? destination,
    String? pickup,
    DateTime? date,
    String? departureTime,
    String? duration,
    String? arrivalTime,
    String? busType,
    String? depot,
    String? busNumber,
    String? seatsAvailable,
    String? price,
    bool? isSoldOut,
    List<int>? seats,
    List<int>? bookedSeats,
    String? tripId,
    String? busId,
    List<String>? stops,
  }) {
    return TripModel(
      id: id ?? this.id,
      destination: destination ?? this.destination,
      pickup: pickup ?? this.pickup,
      date: date ?? this.date,
      departureTime: departureTime ?? this.departureTime,
      duration: duration ?? this.duration,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      busType: busType ?? this.busType,
      depot: depot ?? this.depot,
      busNumber: busNumber ?? this.busNumber,
      seatsAvailable: seatsAvailable ?? this.seatsAvailable,
      price: price ?? this.price,
      isSoldOut: isSoldOut ?? this.isSoldOut,
      seats: seats ?? this.seats,
      bookedSeats: bookedSeats ?? this.bookedSeats,
      tripId: tripId ?? this.tripId,
      busId: busId ?? this.busId,
      stops: stops ?? this.stops,
    );
  }
}

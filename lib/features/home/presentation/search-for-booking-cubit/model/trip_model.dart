import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String tripId;
  final int depoId;
  final String? busId;
  final List<int> seats;
  final List<int> bookedSeats;
  final bool isDailyTrip;
  final bool isTripStarted;
  final Timestamp tripStartTime;
  final bool isBreakdown;
  final bool isTeaBreak;
  final Timestamp nextTripDate;
  final List<StopsModel> stopsModel;
  final int currentStopIndex;
  final List<dynamic> currentUserId;
  TripModel(
      {required this.tripId,
      required this.depoId,
      this.busId,
      required this.seats,
      required this.bookedSeats,
      required this.isDailyTrip,
      required this.isTripStarted,
      required this.tripStartTime,
      required this.isBreakdown,
      required this.isTeaBreak,
      required this.nextTripDate,
      required this.stopsModel,
      required this.currentStopIndex,
      required this.currentUserId});

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['trip_id'],
      depoId: json['depo_id'],
      busId: json['bus_id'],
      seats: List<int>.from(json['seats']),
      bookedSeats: List<int>.from(json['booked_seates']),
      isDailyTrip: json['is_daily_trip'],
      isTripStarted: json['is_trip_started'],
      tripStartTime: json['trips_start_time'],
      isBreakdown: json['is_breakdown'],
      isTeaBreak: json['is_teabreak'],
      nextTripDate: json['next_trip_date'],
      stopsModel: (json['stopsmodel'] as List)
          .map((e) => StopsModel.fromJson(e))
          .toList(),
      currentStopIndex: json['current_stop_index'],
      currentUserId: List<dynamic>.from(json['current_users_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': tripId,
      'depo_id': depoId,
      'bus_id': busId,
      'seats': seats,
      'booked_seates': bookedSeats,
      'is_daily_trip': isDailyTrip,
      'is_trip_started': isTripStarted,
      'trips_start_time': tripStartTime,
      'is_breakdown': isBreakdown,
      'is_teabreak': isTeaBreak,
      'next_trip_date': nextTripDate,
      'stopsmodel': stopsModel.map((e) => e.toJson()).toList(),
      'current_stop_index': currentStopIndex,
      'current_users_id': currentUserId
    };
  }

  TripModel copyWith(
      {String? tripId,
      int? depoId,
      String? busId,
      List<int>? seats,
      List<int>? bookedSeats,
      bool? isDailyTrip,
      bool? isTripStarted,
      Timestamp? tripStartTime,
      bool? isBreakdown,
      bool? isTeaBreak,
      Timestamp? nextTripDate,
      List<StopsModel>? stopsModel,
      int? currentStopIndex,
      List<dynamic>? currentusersId}) {
    return TripModel(
        tripId: tripId ?? this.tripId,
        depoId: depoId ?? this.depoId,
        busId: busId ?? this.busId,
        seats: seats ?? this.seats,
        bookedSeats: bookedSeats ?? this.bookedSeats,
        isDailyTrip: isDailyTrip ?? this.isDailyTrip,
        isTripStarted: isTripStarted ?? this.isTripStarted,
        tripStartTime: tripStartTime ?? this.tripStartTime,
        isBreakdown: isBreakdown ?? this.isBreakdown,
        isTeaBreak: isTeaBreak ?? this.isTeaBreak,
        nextTripDate: nextTripDate ?? this.nextTripDate,
        stopsModel: stopsModel ?? this.stopsModel,
        currentStopIndex: currentStopIndex ?? this.currentStopIndex,
        currentUserId: currentusersId ??currentUserId);
  }

  static TripModel empty() {
    return TripModel(
      tripId: '',
      depoId: 0,
      busId: null,
      seats: [],
      bookedSeats: [],
      isDailyTrip: false,
      isTripStarted: false,
      tripStartTime: Timestamp.now(),
      isBreakdown: false,
      isTeaBreak: false,
      nextTripDate: Timestamp.now(),
      stopsModel: [],
      currentStopIndex: 0,currentUserId: []
    );
  }
}

class StopsModel {
  final String id;
  final int depoId;
  final Timestamp arrivalTime;

  StopsModel({
    required this.id,
    required this.depoId,
    required this.arrivalTime,
  });

  factory StopsModel.fromJson(Map<String, dynamic> json) {
    return StopsModel(
      id: json['id'],
      depoId: json['depo_id'],
      arrivalTime: json['arrival_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'depo_id': depoId,
      'arrival_time': arrivalTime,
    };
  }

  StopsModel copyWith({
    String? id,
    int? depoId,
    Timestamp? arrivalTime,
  }) {
    return StopsModel(
      id: id ?? this.id,
      depoId: depoId ?? this.depoId,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  static StopsModel empty() {
    return StopsModel(
      id: '',
      depoId: 0,
      arrivalTime: Timestamp.now(),
    );
  }
}

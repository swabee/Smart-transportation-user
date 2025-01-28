enum BookingStatus { cancelled, active, completed }

class BookingModel {
  final String id;
  final String? busId;
  final String tripId;
  final bool isStarted;
  final String? liveLocationLink; // Nullable
  final bool isFoodBreak;
  final bool isVechileOnDamage;
  final DateTime createdAt;
  final String userId;
  final BookingStatus status;
  final List<int> bookedSeats;
  BookingModel({
    required this.id,
    this.busId,
    required this.tripId,
    required this.isStarted,
    this.liveLocationLink, // Nullable
    required this.isFoodBreak,
    required this.isVechileOnDamage,
    required this.createdAt,
    required this.userId,
    required this.status,
    required this.bookedSeats,
  });

  // JSON serialization methods
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      busId: json['busId'] as String?,
      tripId: json['tripId'] as String,
      isStarted: json['isStarted'] as bool,
      liveLocationLink: json['liveLocationLink'] as String?, // Nullable
      isFoodBreak: json['isFoodBreak'] as bool,
      isVechileOnDamage: json['isVechileOnDamage'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
      status: BookingStatus.values
          .firstWhere((e) => e.toString() == 'BookingStatus.${json['status']}'),
      bookedSeats: List<int>.from(json['bookedSeats']),
    );
  }

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'busId': busId,
    'tripId': tripId,
    'isStarted': isStarted,
    'liveLocationLink': liveLocationLink, // Nullable
    'isFoodBreak': isFoodBreak,
    'isVechileOnDamage': isVechileOnDamage,
    'createdAt': createdAt.toIso8601String(),
    'userId': userId,
    'status': status.toString().split('.').last,
    'bookedSeats': bookedSeats, 
  };
}


  // copyWith method
  BookingModel copyWith({
    String? id,
    String? busId,
    String? tripId,
    bool? isStarted,
    String? liveLocationLink,
    bool? isFoodBreak,
    bool? isVechileOnDamage,
    DateTime? createdAt,
    String? userId,
    BookingStatus? status,
    List<int>? bookedSeats,
  }) {
    return BookingModel(
      id: id ?? this.id,
      busId: busId ?? this.busId,
      tripId: tripId ?? this.tripId,
      isStarted: isStarted ?? this.isStarted,
      liveLocationLink: liveLocationLink ?? this.liveLocationLink,
      isFoodBreak: isFoodBreak ?? this.isFoodBreak,
      isVechileOnDamage: isVechileOnDamage ?? this.isVechileOnDamage,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      bookedSeats: bookedSeats ?? this.bookedSeats,
    );
  }
}

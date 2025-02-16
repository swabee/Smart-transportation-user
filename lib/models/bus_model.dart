class BusModel {
  final String id;
  final String? currentTripId;
  final BusDepoModel busDepo;
  final BusTypeModel busType;
  final String pnrNumber;

  BusModel(
      {required this.id,
      required this.busDepo,
      required this.busType,
      this.currentTripId,
      required this.pnrNumber});

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
        id: json['bus_id'] ?? '',
        busDepo: BusDepoModel.fromJson(json['bus_depo'] ?? {}),
        busType: BusTypeModel.fromJson(json['bus_type'] ?? {}),
        currentTripId: json['current_trip_id'],
        pnrNumber: json['pnr_number']);
  }

  Map<String, dynamic> toJson() {
    return {
      'bus_id': id,
      'bus_depo': busDepo.toJson(),
      'bus_type': busType.toJson(),
      'current_trip_id': currentTripId,
      'pnr_number': pnrNumber
    };
  }

  static final empty = BusModel(
      id: '',
      busDepo: BusDepoModel.empty,
      busType: BusTypeModel.empty,
      pnrNumber: '');
}

class BusDepoModel {
  final int id;
  final String name;

  BusDepoModel({
    required this.id,
    required this.name,
  });

  factory BusDepoModel.fromJson(Map<String, dynamic> json) {
    return BusDepoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static final empty = BusDepoModel(id: 0, name: '');
}

class BusTypeModel {
  final String id;
  final String type;
  final int busCharge;

  BusTypeModel({
    required this.id,
    required this.type,
    required this.busCharge,
  });

  factory BusTypeModel.fromJson(Map<String, dynamic> json) {
    return BusTypeModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      busCharge: json['bus_charge'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'bus_charge': busCharge,
    };
  }

  static final empty = BusTypeModel(id: '', type: '', busCharge: 0);
}

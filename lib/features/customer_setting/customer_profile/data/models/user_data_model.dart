

import 'package:user_app/features/customer_setting/customer_profile/domain/entities/user_data_entity.dart';

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required super.id,
    required super.email,
    required super.fName,
    required super.lName,
    super.currentBusId,
    required super.isInsideBus,
    required super.isSocialLogin,
    required super.phoneNumber,
    super.profilePicUrl,
    required super.userAge,
    required super.walletBalance,
  });

  /// Factory constructor for creating a UserDataModel from JSON.
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fName: json['f_name'] as String,
      lName: json['l_name'] as String,
      currentBusId: json['current_bus_id'] as String?,
      isInsideBus: json['is_inside_bus'] as bool,
      isSocialLogin: json['is_social_login'] as bool,
      phoneNumber: json['phone_number'] as String,
      profilePicUrl: json['profile_pic_url'] as String?,
      userAge: (json['user_age'] as num).toDouble(),
      walletBalance: (json['wallet_balance'] as num).toDouble(),
    );
  }

  /// Converts a UserDataModel instance into JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'f_name': fName,
      'l_name': lName,
      'current_bus_id': currentBusId,
      'is_inside_bus': isInsideBus,
      'is_social_login': isSocialLogin,
      'phone_number': phoneNumber,
      'profile_pic_url': profilePicUrl,
      'user_age': userAge,
      'wallet_balance': walletBalance,
    };
  }

  /// Returns a map of fields to save locally.
  Map<String, dynamic> toSaveLocally() {
    return {
      'id': id,
      'email': email,
      'f_name': fName,
      'l_name': lName,
      'phone_number': phoneNumber,
      'profile_pic_url': profilePicUrl,
      'wallet_balance': walletBalance,
    };
  }

  /// Empty UserDataModel instance.
  static const UserDataModel empty = UserDataModel(
    id: '',
    email: '',
    fName: '',
    lName: '',
    currentBusId: null,
    isInsideBus: false,
    isSocialLogin: false,
    phoneNumber: '',
    profilePicUrl: null,
    userAge: 0.0,
    walletBalance: 0.0,
  );

  /// Checks if the current instance is empty.
  @override
  bool get isEmpty => this == UserDataModel.empty;

  /// Checks if the current instance is not empty.
  @override
  bool get isNotEmpty => !isEmpty;
}

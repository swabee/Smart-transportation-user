import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String id;
  final String email;
  final String fName;
  final String lName;
  final String? currentBusId;
  final bool isInsideBus;
  final bool isSocialLogin;
  final String phoneNumber;
  final String? profilePicUrl;
  final double userAge;
  final double walletBalance;

  const UserDataEntity({
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    this.currentBusId,
    required this.isInsideBus,
    required this.isSocialLogin,
    required this.phoneNumber,
    this.profilePicUrl,
    required this.userAge,
    required this.walletBalance,
  });

  /// Check if the UserDataEntity is empty.
  bool get isEmpty =>
      id.isEmpty &&
      email.isEmpty &&
      fName.isEmpty &&
      lName.isEmpty &&
      phoneNumber.isEmpty &&
      userAge == 0.0 &&
      walletBalance == 0.0;

  /// Check if the UserDataEntity is not empty.
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        id,
        email,
        fName,
        lName,
        currentBusId,
        isInsideBus,
        isSocialLogin,
        phoneNumber,
        profilePicUrl,
        userAge,
        walletBalance,
      ];
}

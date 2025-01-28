part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class StartListeningToUserData extends UserDataEvent {}

class UserDataLoadedEvent extends UserDataEvent {
  const UserDataLoadedEvent(this.userDataEntity);
  final UserDataEntity userDataEntity;

  @override
  List<Object> get props => [userDataEntity];
}

class StopListeningToUserData extends UserDataEvent {}

//update provider availability
class UpdateProviderAvailability extends UserDataEvent {
  const UpdateProviderAvailability({
    required this.isAvailable,
  });
  final bool isAvailable;
  @override
  List<Object> get props => [isAvailable];
}

//update current order id for provider
class UpdateCurrentOrderId extends UserDataEvent {
  const UpdateCurrentOrderId({
    required this.currentOrderId,
  });
  final String currentOrderId;
  @override
  List<Object> get props => [currentOrderId];
}

///Get fcm token
class GetFcmToken extends UserDataEvent {}

/// Delete account
/// This event is used to delete the user account
class DeleteAccountEvent extends UserDataEvent {}

///Update customer profile picture

class UpdateCustomerProfilePicture extends UserDataEvent {
  const UpdateCustomerProfilePicture({
    required this.file,
  });
  final File file;
  @override
  List<Object> get props => [file];
}

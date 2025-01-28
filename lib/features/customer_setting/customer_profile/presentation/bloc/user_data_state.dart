part of 'user_data_bloc.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

final class UserDataInitial extends UserDataState {}

final class UserDataLoading extends UserDataState {}

final class UserDataLoaded extends UserDataState {
  const UserDataLoaded({
    required this.userDataEntity,
    this.detailsUpdated = false,
    // this.profilePicUpdated = false,
  });

  final UserDataEntity userDataEntity;
  final bool detailsUpdated;
  // final bool profilePicUpdated;

  @override
  List<Object> get props => [
        userDataEntity, detailsUpdated,
        // profilePicUpdated
      ];

  UserDataLoaded copyWith({
    UserDataEntity? userDataEntity,
    bool? detailsUpdated,
    // bool? profilePicUpdated,
  }) {
    return UserDataLoaded(
      userDataEntity: userDataEntity ?? this.userDataEntity,
      detailsUpdated: detailsUpdated ?? this.detailsUpdated,
      // profilePicUpdated: profilePicUpdated ?? this.profilePicUpdated,
    );
  }
}

final class UserDataFetchError extends UserDataState {
  const UserDataFetchError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

final class UserDataUpdating extends UserDataState {}

final class UserDataUpdateError extends UserDataState {
  const UserDataUpdateError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

class UserDataDeleted extends UserDataState {
  @override
  List<Object> get props => [];
}

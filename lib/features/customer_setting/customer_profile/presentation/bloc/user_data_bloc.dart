import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user_app/app/cubit/auth_cubit.dart';
import 'package:user_app/errors/common_error_response.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/entities/user_data_entity.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/delete_account_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/get_user_data_as_stream_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/save_user_details_locally_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/update_user_details_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/customer/upload_customer_profile_picture_usecase.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/usecase.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc({
    required this.authCubit,
  }) : super(UserDataInitial()) {
    on<StopListeningToUserData>(_onStopListeningToUserData);
    on<StartListeningToUserData>(_onStartListeningToUserData);
    on<UserDataLoadedEvent>(_onUserDataLoaded);
    on<UpdateCurrentOrderId>(_onUpdateCurrentOrderId);
    on<GetFcmToken>(_onGetFcmToken);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<UpdateCustomerProfilePicture>(_onUpdateCustomerProfilePicture);



    authCubit.state.status == AuthStatus.authenticated
        ? add(StartListeningToUserData())
        : add(StopListeningToUserData());

    _authSubscription = authCubit.stream.listen((authState) {
      if (authState.status == AuthStatus.authenticated) {
        add(StartListeningToUserData());
      } else {
        _userSubscription?.cancel();
        // emit(UserDataInitial());
        add(StopListeningToUserData());
      }
    });
  }
  final AuthCubit authCubit;

  final GetUserDataAsStreamUsecase getUserDataAsStreamUsecase =
      locator<GetUserDataAsStreamUsecase>();



  final UpdateUserDetailsUsecase updateUserDetailsUsecase =
      locator<UpdateUserDetailsUsecase>();

  final SaveUserDetailsLocallyUsecase saveUserDetailsLocallyUsecase =
      locator<SaveUserDetailsLocallyUsecase>();

  final DeleteAccountUsecase deleteAccountUsecase =
      locator<DeleteAccountUsecase>();

  final UploadCustomerProfilePictureUsecase
      uploadCustomerProfilePictureUsecase =
      locator<UploadCustomerProfilePictureUsecase>();

  StreamSubscription<UserDataEntity>? _userSubscription;
  StreamSubscription<AuthState>? _authSubscription;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStartListeningToUserData(
    StartListeningToUserData event,
    Emitter<UserDataState> emit,
  ) async {
    add(GetFcmToken());
    final userStreamEither = getUserDataAsStreamUsecase.call(NoParams());

    await userStreamEither.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(UserDataFetchError(failure));
        }
      },
      (userStream) async {
        await _userSubscription?.cancel();
        _userSubscription = userStream.listen(
          (userData) {
            add(UserDataLoadedEvent(userData));
          },
          onError: (error) {
            if (!emit.isDone) {
              emit(
                UserDataFetchError(
                  ServerFailure(
                    ErrorResponseModel(
                      code: 0,
                      status: 'error',
                      message: error.toString(),
                      response: error.toString(),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  FutureOr<void> _onStopListeningToUserData(
    StopListeningToUserData event,
    Emitter<UserDataState> emit,
  ) {
    _userSubscription?.cancel();
    emit(UserDataInitial());
  }

  FutureOr<void> _onUserDataLoaded(
    UserDataLoadedEvent event,
    Emitter<UserDataState> emit,
  ) {
    emit(UserDataLoaded(userDataEntity: event.userDataEntity));
    saveUserDetailsLocallyUsecase.call(
      SaveUserDetailsParams(userDetails: event.userDataEntity as UserDataModel),
    );
  }



  Future<void> _onUpdateCurrentOrderId(
    UpdateCurrentOrderId event,
    Emitter<UserDataState> emit,
  ) async {
    final result = await updateUserDetailsUsecase(
      UpdateUserDetailsParams(
        data: {
          'current_order_id': event.currentOrderId,
        },
      ),
    );

    result.fold(
      (failure) {
        emit(UserDataUpdateError(failure));
      },
      (_) {
        // emit(UserDataUpdated());
      },
    );
  }

  Future<void> _onGetFcmToken(
    GetFcmToken event,
    Emitter<UserDataState> emit,
  ) async {
    try {
      final token = await locator<FirebaseMessaging>().getToken();

      if (authCubit.state.status == AuthStatus.authenticated) {
        final userId = authCubit.state.user!.id;

        await locator<FirebaseFirestore>()
            .collection('users')
            .doc(userId)
            .update(
          {
            'fcm_token': token,
          },
        );
      }
    } catch (e) {}
  }

  Future<void> _onDeleteAccount(
    DeleteAccountEvent event,
    Emitter<UserDataState> emit,
  ) async {
    final result = await deleteAccountUsecase(NoParams());

    result.fold(
      (failure) {
        emit(UserDataUpdateError(failure));
      },
      (_) {
        emit(UserDataDeleted());
      },
    );
  }

  Future<void> _onUpdateCustomerProfilePicture(
    UpdateCustomerProfilePicture event,
    Emitter<UserDataState> emit,
  ) async {
    final currentState = state;

    if (currentState is UserDataLoaded) {
      // emit(UserDataUpdating());

      final result = await uploadCustomerProfilePictureUsecase(
        UploadCustomerProfilePictureParams(profilePicture: event.file),
      );
      await result.fold(
        (failure) {
          emit(UserDataUpdateError(failure));
        },
        (imageUrl) async {
          //
          final result = await updateUserDetailsUsecase(
            UpdateUserDetailsParams(
              data: {
                'customer_profile_picture_url': imageUrl,
              },
            ),
          );

          result.fold(
            (failure) {
              emit(UserDataUpdateError(failure));
            },
            (_) {
              // emit(UserDataUpdated());
              // final updatedUserData = currentState.userDataEntity.copyWith(
              //   customerProfilePictureUrl: imageUrl,
              // );
              // emit(
              //   currentState.copyWith(
              //     userDataEntity: updatedUserData,
              //     detailsUpdated: true,
              //   ),
              // );
            },
          );
        },
      );
    }
  }
}

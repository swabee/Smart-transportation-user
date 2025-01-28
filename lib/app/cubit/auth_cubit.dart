import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/app/domain/entities/current_user.dart';
import 'package:user_app/app/domain/usecase/get_current_user_usecase.dart';
import 'package:user_app/app/domain/usecase/logout_user_usecase.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.getCurrentUserUsecase,
  ) : super(const AuthState()) {
    _startListeningToUser();
  }

  StreamSubscription<CurrentUser>? _userSubscription;

  final GetCurrentUserUsecase getCurrentUserUsecase;

  final LogoutUserUsecase logoutUserUsecase = locator<LogoutUserUsecase>();

  void _startListeningToUser() {
    final userStreamEither = getCurrentUserUsecase.call(NoParams());

    userStreamEither.fold(
      (failure) {
        _userSubscription?.cancel();

        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
      (userStream) {
        _userSubscription?.cancel();
        _userSubscription = userStream.listen(
          (currentUser) {
            if (currentUser.isEmpty) {
              emit(const AuthState(status: AuthStatus.unauthenticated));
            } else {
              emit(
                AuthState(
                  status: AuthStatus.authenticated,
                  user: currentUser,
                ),
              );
            }
          },
          onError: (error) {
            emit(const AuthState(status: AuthStatus.unauthenticated));
          },
        );
      },
    );
  }

  ///sing out the user
  Future<void> signOut() async {
    final signOutEither = await logoutUserUsecase.call(NoParams());
    signOutEither.fold(
      (failure) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
      (_) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

part of 'auth_cubit.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({this.status = AuthStatus.initial, this.user, this.failure});
  final AuthStatus status;
  final CurrentUser? user;
  final Failure? failure;

  @override
  List<Object?> get props => [status, user, failure];
}

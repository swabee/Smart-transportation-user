part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.failure,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final Failure? failure;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    Failure? failure,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, email, password, failure];
}

final class LoginErrorState extends LoginState {
  const LoginErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class LoginSuccessState extends LoginState {}

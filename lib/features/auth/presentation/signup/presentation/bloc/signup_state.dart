part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  const SignupState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.firstName = const GeneralField.pure(),
    this.lastName = const GeneralField.pure(),
    // this.mobileNumber = const GeneralField.pure(),
    this.isValid = false,
    this.error,
    this.agreeToTerms = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final GeneralField firstName;
  final GeneralField lastName;
  // final GeneralField mobileNumber;
  final bool agreeToTerms;
  final bool isValid;

  final Failure? error;

  SignupState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    Password? confirmPassword,
    GeneralField? firstName,
    GeneralField? lastName,
    GeneralField? mobileNumber,
    bool? isValid,
    Failure? error,
    bool? agreeToTerms,
  }) {
    return SignupState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      // mobileNumber: mobileNumber ?? this.mobileNumber,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        // mobileNumber,
        isValid,
        agreeToTerms,
      ];
}

final class SignupInitial extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupErrorState extends SignupState {
  const SignupErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class SignupSuccessState extends SignupState {}

final class UserCreateSuccessState extends SignupState {}

final class UserCreateErrorState extends SignupState {
  const UserCreateErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

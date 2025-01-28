part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupFirstNameChanged extends SignupEvent {
  const SignupFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class SignupLastNameChanged extends SignupEvent {
  const SignupLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignupConfirmPasswordChanged extends SignupEvent {
  const SignupConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

//agree to terms and conditions
class SignupAgreeToTermsChanged extends SignupEvent {
  const SignupAgreeToTermsChanged({required this.agreeToTerms});

  final bool agreeToTerms;

  @override
  List<Object> get props => [agreeToTerms];
}

class SignupSubmitted extends SignupEvent {}

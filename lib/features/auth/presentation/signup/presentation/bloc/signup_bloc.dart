import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:user_app/global/form_models/email.dart';
import 'package:user_app/global/form_models/general_field.dart';
import 'package:user_app/service_locator/service_locator.dart';

import '../../../../../../global/form_models/password.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupFirstNameChanged>(_onFirstNameChanged);
    on<SignupLastNameChanged>(_onLastNameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupAgreeToTermsChanged>(_onAgreeToTermsChanged);
    on<SignupSubmitted>(_onSubmitted);
  }

  final SignupWithEmailPasswordUsecase _signupWithEmailPasswordUsecase =
      locator<SignupWithEmailPasswordUsecase>();

  void _onFirstNameChanged(
    SignupFirstNameChanged event,
    Emitter<SignupState> emit,
  ) {
    final firstName = GeneralField.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: _validateForm(firstName: firstName),
      ),
    );
  }

  void _onLastNameChanged(
    SignupLastNameChanged event,
    Emitter<SignupState> emit,
  ) {
    final lastName = GeneralField.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: _validateForm(lastName: lastName),
      ),
    );
  }

  void _onEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: _validateForm(email: email),
      ),
    );
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: _validateForm(password: password),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignupConfirmPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final confirmPassword = Password.dirty(event.confirmPassword);
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: _validateForm(confirmPassword: confirmPassword),
      ),
    );
  }

  FutureOr<void> _onAgreeToTermsChanged(
    SignupAgreeToTermsChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        agreeToTerms: event.agreeToTerms,
        isValid: _validateForm(
          agreeToTerms: event.agreeToTerms,
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      // Add your signup logic here
      final result = await _signupWithEmailPasswordUsecase.call(
        SignupParams(
          email: state.email.value,
          password: state.password.value,
          firstName: state.firstName.value,
          lastName: state.lastName.value,
        ),
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              error: failure,
            ),
          );
        },
        (_) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        },
      );
      // On failure:
      // emit(state.copyWith(status: FormzSubmissionStatus.failure, error: Failure('Signup failed')));
    }
  }

  bool _validateForm({
    GeneralField? firstName,
    GeneralField? lastName,
    Email? email,
    Password? password,
    Password? confirmPassword,
    bool? agreeToTerms,
  }) {
    final firstNameField = firstName ?? state.firstName;
    final lastNameField = lastName ?? state.lastName;
    final emailField = email ?? state.email;
    final passwordField = password ?? state.password;
    final confirmPasswordField = confirmPassword ?? state.confirmPassword;

    final agreeTerms = agreeToTerms ?? state.agreeToTerms;

    return Formz.validate([
          firstNameField,
          lastNameField,
          emailField,
          passwordField,
          confirmPasswordField,
        ]) &&
        confirmPasswordField.value == passwordField.value &&
        agreeTerms == true;
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:user_app/global/form_models/email.dart';
import 'package:user_app/global/form_models/password.dart';
import 'package:user_app/service_locator/service_locator.dart';

import '../../../../../../errors/failures.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final LoginUsecase loginUsecase = locator<LoginUsecase>();

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final result = await loginUsecase.call(
          LoginParams(
            email: state.email.value,
            password: state.password.value,
          ),
        );
        // emit(state.copyWith(status: FormzSubmissionStatus.success));
        result.fold((l) {
          emit(state.copyWith(
              status: FormzSubmissionStatus.failure, failure: l,),);
        }, (r) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        });
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}

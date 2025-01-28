import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:user_app/features/auth/presentation/social_login/bloc/social_login_state.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/usecase.dart';

part 'social_login_event.dart';

class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  SocialLoginBloc() : super(const SocialLoginState()) {
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
  }
  final SignInWithGoogleUsecase signInWithGoogleUsecase =
      locator<SignInWithGoogleUsecase>();

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<SocialLoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await signInWithGoogleUsecase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) => emit(state.copyWith(isLoading: false)),
    );
  }
}

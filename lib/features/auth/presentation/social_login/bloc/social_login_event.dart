part of 'social_login_bloc.dart';

sealed class SocialLoginEvent extends Equatable {
  const SocialLoginEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleRequested extends SocialLoginEvent {}

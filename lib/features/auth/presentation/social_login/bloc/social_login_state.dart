import 'package:equatable/equatable.dart';
import 'package:user_app/errors/failures.dart';

class SocialLoginState extends Equatable {
  const SocialLoginState({
    this.isLoading = false,
    this.failure,
  });

  final bool isLoading;
  final Failure? failure;

  SocialLoginState copyWith({
    bool? isLoading,
    Failure? failure,
  }) {
    return SocialLoginState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure];
}

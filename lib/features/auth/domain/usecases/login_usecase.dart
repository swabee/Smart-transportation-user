import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/utils/usecase.dart';

class LoginUsecase extends UseCase<Unit, LoginParams> {
  LoginUsecase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Unit>> call(LoginParams params) async {
    return authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

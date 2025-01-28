import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/utils/usecase.dart';

class SignupWithEmailPasswordUsecase extends UseCase<Unit, SignupParams> {
  SignupWithEmailPasswordUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Unit>> call(SignupParams params) async {
    return authRepository.signUpUsingEmailPassword(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
    );
  }
}

class SignupParams extends Equatable {
  const SignupParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}

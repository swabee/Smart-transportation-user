import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/utils/usecase.dart';

class SignInWithGoogleUsecase extends UseCase<Unit, NoParams> {
  SignInWithGoogleUsecase(this.repository);
  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return repository.signInWithGoogle();
  }
}

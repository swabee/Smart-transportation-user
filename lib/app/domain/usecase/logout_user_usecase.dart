import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/utils/usecase.dart';


class LogoutUserUsecase extends UseCase<void, NoParams> {
  LogoutUserUsecase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return authRepository.signOut();
  }
}

import 'package:dartz/dartz.dart';
import 'package:user_app/app/domain/entities/current_user.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/utils/usecase.dart';

class GetCurrentUserUsecase
    extends GeneralUseCase<Stream<CurrentUser>, NoParams> {
  GetCurrentUserUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Either<Failure, Stream<CurrentUser>> call(NoParams params) {
    return authRepository.getCurrentUserStream();
  }
}

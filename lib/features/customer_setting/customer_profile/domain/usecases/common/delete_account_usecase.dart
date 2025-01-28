import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/utils/usecase.dart';

class DeleteAccountUsecase extends UseCase<Unit, NoParams> {
  DeleteAccountUsecase(this.repository);

  final UserDataRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.deleteAccount();
  }
}

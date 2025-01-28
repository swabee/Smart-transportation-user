import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/utils/usecase.dart';


class UpdateUserDetailsUsecase extends UseCase<Unit, UpdateUserDetailsParams> {
  UpdateUserDetailsUsecase(this.repository);

  final UserDataRepository repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateUserDetailsParams params) {
    return repository.updateUserDetails(params.data);
  }
}

class UpdateUserDetailsParams {
  const UpdateUserDetailsParams({
    required this.data,
  });

  final Map<String, dynamic> data;
}

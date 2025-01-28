import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/utils/usecase.dart';

import '../../../data/models/user_data_model.dart';

class SaveUserDetailsLocallyUsecase
    extends UseCase<Unit, SaveUserDetailsParams> {
  SaveUserDetailsLocallyUsecase(this.repository);

  final UserDataRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SaveUserDetailsParams params) {
    return repository.saveUserDetails(params.userDetails);
  }
}

class SaveUserDetailsParams {
  const SaveUserDetailsParams({
    required this.userDetails,
  });

  final UserDataModel userDetails;
}

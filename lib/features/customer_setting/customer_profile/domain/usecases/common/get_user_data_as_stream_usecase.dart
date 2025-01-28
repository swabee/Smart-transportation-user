import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/entities/user_data_entity.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/utils/usecase.dart';

class GetUserDataAsStreamUsecase
    extends GeneralUseCase<Stream<UserDataEntity>, NoParams> {
  GetUserDataAsStreamUsecase({required this.userDataRepository});

  final UserDataRepository userDataRepository;

  @override
  Either<Failure, Stream<UserDataEntity>> call(NoParams params) {
    return userDataRepository.getUserDataStream();
  }
}

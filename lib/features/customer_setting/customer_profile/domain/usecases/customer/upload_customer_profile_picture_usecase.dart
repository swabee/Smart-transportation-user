import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/utils/usecase.dart';

class UploadCustomerProfilePictureUsecase
    extends UseCase<String, UploadCustomerProfilePictureParams> {
  UploadCustomerProfilePictureUsecase(this.repository);
  final UserDataRepository repository;

  @override
  Future<Either<Failure, String>> call(
    UploadCustomerProfilePictureParams params,
  ) async {
    return repository.uploadCustomerProfilePicture(params.profilePicture);
  }
}

class UploadCustomerProfilePictureParams {
  UploadCustomerProfilePictureParams({
    required this.profilePicture,
  });
  final File profilePicture;
}

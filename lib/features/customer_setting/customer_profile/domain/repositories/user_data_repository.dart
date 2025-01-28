import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/entities/user_data_entity.dart';


abstract class UserDataRepository {
  Either<Failure, Stream<UserDataEntity>> getUserDataStream();

  Future<Either<Failure, Unit>> updateProviderAvailability(bool isAvailable);

  Future<Either<Failure, Unit>> updateUserDetails(Map<String, dynamic> data);

  Future<Either<Failure, Unit>> saveUserDetails(UserDataModel userDetails);

  Future<Either<Failure, Unit>> deleteAccount();

  Future<Either<Failure, String>> uploadCustomerProfilePicture(
    File profilePicture,
  );
}

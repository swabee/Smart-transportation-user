import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:user_app/errors/exceptions.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/datasource/user_data_datasource.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/entities/user_data_entity.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/local_storage/local_storage.dart';
import 'package:user_app/network/network_info.dart';

import '../../../../../errors/common_error_response.dart';


class UserDataRepositoryImpl extends UserDataRepository {
  UserDataRepositoryImpl({
    required this.userDataDataSource,
    required this.networkInfo,
    required this.localStorage,
  });

  final UserDataDataSource userDataDataSource;
  final NetworkInfo networkInfo;
  final LocalStorage localStorage;

  @override
  Either<Failure, Stream<UserDataEntity>> getUserDataStream() {
    try {
      final response = userDataDataSource.getUserDataStream();
      return Right(response);
    } on AuthException catch (ex) {
      return Left(AuthFailure(ex.errorResponseModel));
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.errorResponseModel));
    } catch (e) {
      return Left(
        ServerFailure(
          ErrorResponseModel(
            message: e.toString(),
            response: e.toString(),
            status: '',
            code: 0,
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProviderAvailability(
    bool isAvailable,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await userDataDataSource.updateProviderAvailability(isAvailable);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserDetails(
    Map<String, dynamic> data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await userDataDataSource.updateUserDetails(data);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveUserDetails(
    UserDataModel userDetails,
  ) async {
    try {
      await localStorage.saveUserDetails(userDetails);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount() async {
    try {
      await userDataDataSource.deleteAccount();
      return const Right(unit);
    } on AuthException catch (ex) {
      return Left(AuthFailure(ex.errorResponseModel));
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.errorResponseModel));
    } catch (e) {
      return Left(
        ServerFailure(
          ErrorResponseModel(
            message: e.toString(),
            response: e.toString(),
            status: '',
            code: 0,
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadCustomerProfilePicture(
      File profilePicture,) async {
    try {
      final imageUrl =
          await userDataDataSource.uploadCustomerProfilePicture(profilePicture);
      return Right(imageUrl);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorResponseModel));
    }
  }
}

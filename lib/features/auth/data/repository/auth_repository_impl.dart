import 'package:dartz/dartz.dart';
import 'package:user_app/errors/common_error_response.dart';
import 'package:user_app/errors/exceptions.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/network/network_info.dart';

import '../../../../app/domain/entities/current_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authDataSource,
    // required this.appSharedData,
  });

  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authDataSource;
  // final AppSharedData appSharedData;
  @override
  Future<Either<Failure, Unit>> signUpUsingEmailPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    // required String mobileNumber,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authDataSource.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final response = await authDataSource.saveUserData(
          uid: result,
          email: email,
          // password: password,
          firstName: firstName,
          lastName: lastName,
          socialLoginType: SocialLoginType.na,
          // mobileNumber: mobileNumber,
        );
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on AuthException catch (ex) {
        return Left(AuthFailure(ex.errorResponseModel));
      } catch (e) {
        // if (e is UsernameExistsException) {
        //   return Left(
        //     ServerFailure(ErrorResponseModel(status: '', message: e.message)),
        //   );
        // }
        return Left(
          ServerFailure(
            ErrorResponseModel(
              message: e.toString(),
              status: '',
              code: 0,
              response: e.toString(),
            ),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signIn({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await authDataSource.signIn(email: email, password: password);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on AuthException catch (ex) {
        return Left(AuthFailure(ex.errorResponseModel));
      } catch (e) {
        return Left(
          ServerFailure(
            ErrorResponseModel(
              message: e.toString(),
              status: '',
              code: 0,
              response: e.toString(),
            ),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, Unit>> confirmSignUp(
  //     {required String userName, required String confirmationCode}) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final response = await remoteDataSource.confirmSignUp(
  //         userName: userName,
  //         confirmationCode: confirmationCode,
  //       );
  //       return Right(response);
  //     } on ServerException catch (ex) {
  //       return Left(ServerFailure(ex.errorResponseModel));
  //     } on UnAuthorizedException catch (ex) {
  //       return Left(AuthorizedFailure(ex.errorResponseModel));
  //     } catch (e) {
  //       return Left(
  //         ServerFailure(
  //           ErrorResponseModel(
  //             message: e.toString(),
  //             status: '',
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.resetPassword(email: email);
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on AuthException catch (ex) {
        return Left(AuthFailure(ex.errorResponseModel));
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
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.updatePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
        );
        return Right(response);
      } on ServerException catch (ex) {
        return Left(ServerFailure(ex.errorResponseModel));
      } on AuthException catch (ex) {
        return Left(AuthFailure(ex.errorResponseModel));
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
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Either<Failure, Stream<CurrentUser>> getCurrentUserStream() {
    try {
      final response = authDataSource.getCurrentUserStream();
      return Right(response);
    } on AuthException catch (ex) {
      return Left(AuthFailure(ex.errorResponseModel));
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
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.signOut();
        return Right(response);
      } on AuthException catch (ex) {
        return Left(AuthFailure(ex.errorResponseModel));
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
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await authDataSource.signInWithGoogle();

        final res =
            await authDataSource.checkUserDataExists(email: user.email!);

        if (res) {
          return const Right(unit);
        } else {
          await authDataSource.saveUserData(
            uid: user.uid,
            email: user.email!,
            // password: password,
            firstName: user.displayName!.split(' ')[0],
            lastName: user.displayName!.split(' ').length > 1
                ? user.displayName!.split(' ')[1]
                : '', // mobileNumber: mobileNumber,
            socialLoginType: SocialLoginType.google,
          );
          return const Right(unit);
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on SaveUserDataException catch (e) {
        return Left(SaveUserDataFailure(e.errorResponseModel));
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
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, GetStudentEntity>> getStudent({
  //   required String email,
  // }) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final response = await remoteDataSource.getStudent(email: email);
  //       // appSharedData.setGetStudentResponse(response.response.)
  //       return Right(response);
  //     } on ServerException catch (ex) {
  //       return Left(ServerFailure(ex.errorResponseModel));
  //     } on UnAuthorizedException catch (ex) {
  //       return Left(AuthorizedFailure(ex.errorResponseModel));
  //     } catch (e) {
  //       return Left(
  //         ServerFailure(
  //           ErrorResponseModel(
  //             message: e.toString(),
  //             status: '',
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, Unit>> createStudent({
  //   required CreateStudentParams createStudentParams,
  // }) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final response = await remoteDataSource.createStudent(
  //         createStudentParams: createStudentParams,
  //       );
  //       return Right(response);
  //     } on ServerException catch (ex) {
  //       return Left(ServerFailure(ex.errorResponseModel));
  //     } on UnAuthorizedException catch (ex) {
  //       return Left(AuthorizedFailure(ex.errorResponseModel));
  //     } catch (e) {
  //       return Left(
  //         ServerFailure(
  //           ErrorResponseModel(
  //             message: e.toString(),
  //             status: '',
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }
}

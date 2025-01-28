import 'package:dartz/dartz.dart';
import 'package:user_app/app/domain/entities/current_user.dart';
import 'package:user_app/errors/failures.dart';


abstract class AuthRepository {
  Future<Either<Failure, Unit>> signUpUsingEmailPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    // required String mobileNumber,
  });

  Future<Either<Failure, Unit>> signIn({
    required String email,
    required String password,
  });

  ///Sign in with google
  Future<Either<Failure, Unit>> signInWithGoogle();

  // Future<Either<Failure, Unit>> confirmSignUp({
  //   required String userName,
  //   required String confirmationCode,
  // });

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
  });

  Future<Either<Failure, Unit>> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  ///Get current user from a stream

  Either<Failure, Stream<CurrentUser>> getCurrentUserStream();

  ///Sign out method
  Future<Either<Failure, Unit>> signOut();

  // Future<Either<Failure, Unit>> createStudent(
  //     {required CreateStudentParams createStudentParams});

  // Future<Either<Failure, GetStudentEntity>> getStudent({required String email});
}

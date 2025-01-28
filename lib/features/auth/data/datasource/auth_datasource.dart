import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:user_app/app/domain/entities/current_user.dart';
import 'package:user_app/constant/firebse_constants.dart';
import 'package:user_app/errors/common_error_response.dart';
import 'package:user_app/errors/exceptions.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/local_storage/local_storage.dart';

enum SocialLoginType {
  na,
  google,
  facebook,
}

abstract class AuthRemoteDataSource {
  //create user with email and password
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Unit> saveUserData({
    required String email,
    required String firstName,
    required String lastName,
    // required String mobileNumber,
    required String uid,
    required SocialLoginType socialLoginType,
  });

  Future<Unit> signIn({
    required String email,
    required String password,
  });

  // Future<Unit> confirmSignUp({
  //   required String userName,
  //   required String confirmationCode,
  // });

  Future<Unit> resetPassword({
    required String email,
  });

  Future<Unit> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  ///Get current logged in user
  Stream<CurrentUser> getCurrentUserStream();

  ///Sign out method
  Future<Unit> signOut();

  Future<User> signInWithGoogle();

  ///Check if user data exists in the database
  Future<bool> checkUserDataExists({required String email});

  /// calls the 'http://64.226.114.43:8080/api/v1/student' endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  // Future<Unit> createStudent({
  //   required CreateStudentParams createStudentParams,
  // });

  /// calls the 'http://64.226.114.43:8080/api/v1/student' endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  // Future<GetStudentEntity> getStudent({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    // required this.apiHelper,
    required LocalStorage appLocalStorage,
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required GoogleSignIn googleSignIn,
  })  : _appLocalStorage = appLocalStorage,
        _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _googleSignIn = googleSignIn;

  // final APIHelper apiHelper;
  final LocalStorage _appLocalStorage;

  final FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn;

  final FirebaseFirestore _firebaseFirestore;

  final Logger logger = Logger();

  @override
  Future<Unit> saveUserData({
    required String email,
    required String firstName,
    required String lastName,
    // required String mobileNumber,
    required String uid,
    required SocialLoginType socialLoginType,
  }) async {
    try {
      if (socialLoginType == SocialLoginType.na) {
        final userModel = UserDataModel(
            id: uid,
            email: email,
            fName: firstName,
            lName: lastName,
            currentBusId: null,
            isInsideBus: false,
            isSocialLogin: false,
            phoneNumber: '',
            profilePicUrl: null,
            userAge: 0.0,
            walletBalance: 0.0

            // phoneNumber: mobileNumber,
            // profilePictureUrl: null,
            );

        await _firebaseFirestore
            .collection(FirebaseConstants.usersCollectionName)
            .doc(uid)
            .set(userModel.toJson());
        return unit;
      } else {
        final userModel = UserDataModel(
          id: uid,
            email: email,
            fName: firstName,
            lName: lastName,
            currentBusId: null,
            isInsideBus: false,
            isSocialLogin: false,
            phoneNumber: '',
            profilePicUrl: null,
            userAge: 0.0,
            walletBalance: 0.0
          // phoneNumber: mobileNumber,
          // profilePictureUrl: null,
        );

        await _firebaseFirestore
            .collection(FirebaseConstants.usersCollectionName)
            .doc(uid)
            .set(userModel.toJson());
        return unit;
      }
    } catch (e) {
      logger.e('Save user data failed: $e');
      throw SaveUserDataException(
        ErrorResponseModel(
          status: 'save-user-data',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
      // rethrow;
    }
  }

  @override
  Future<Unit> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await getStudent(email: email);
      logger.i('Sign in successful: $res');
      return unit;
    } on FirebaseAuthException catch (e) {
      logger.e('Sign in failed: $e');
      throw AuthException(
        ErrorResponseModel(
          status: e.code,
          message: e.message ?? 'Unknown error',
          code: 0,
          response: e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      logger.e('Sign in failed: $e');
      rethrow;
    }
  }

  // @override
  // Future<Unit> confirmSignUp({
  //   required String userName,
  //   required String confirmationCode,
  // }) async {
  //   try {
  //     SignUpResult res = await Amplify.Auth.confirmSignUp(
  //       username: userName,
  //       confirmationCode: confirmationCode,
  //     );
  //     print('Sign up confirmation successful: $res');
  //     return unit;
  //   } catch (e) {
  //     print('Sign up confirmation failed: $e');
  //     rethrow;
  //   }
  // }

  @override
  Future<Unit> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      logger.i('Reset password link sent to: $email');
      return unit;
    } on FirebaseAuthException catch (e) {
      logger.e('Reset password link sent failure: $e');
      throw AuthException(
        ErrorResponseModel(
          status: e.code,
          message: e.message ?? 'Unknown error',
          code: 0,
          response: e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      logger.e('Reset password link sent failure: $e');
      rethrow;
    }
  }

  @override
  Future<Unit> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final res = await _firebaseAuth.currentUser?.updatePassword(newPassword);

      logger.i('Password updated .');
      return unit;
    } on FirebaseAuthException catch (e) {
      logger.e('Password update failed: $e');
      throw AuthException(
        ErrorResponseModel(
          status: e.code,
          message: e.message ?? 'Unknown error',
          code: 0,
          response: e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      logger.e('Password update failed: $e');
      rethrow;
    }
  }

  @override
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = res.user;
      if (user == null) {
        throw AuthException(
          const ErrorResponseModel(
            status: 'user-null',
            message: 'Sign in failed: user is null',
            code: 0,
            response: 'Sign in failed: user is null',
          ),
        );
      }

      logger.i('User creation successful: $res');
      return user.uid;
    } on FirebaseAuthException catch (e) {
      logger.e('User creation failed: $e');
      throw AuthException(
        ErrorResponseModel(
          status: e.code,
          message: e.message ?? 'Unknown error',
          code: 0,
          response: e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      logger.e('User creation failed: $e');
      rethrow;
    }
  }

  @override
  Stream<CurrentUser> getCurrentUserStream() {
    try {
      return _firebaseAuth.authStateChanges().map((user) {
        if (user == null) {
          return CurrentUser.empty;
        }
        return CurrentUser(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          photo: user.photoURL ?? '',
          // mobileNumber: '',
        );
      });
    } catch (e) {
      throw AuthException(
        ErrorResponseModel(
          status: 'auth-state-changes',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await _firebaseAuth.signOut();

      await _appLocalStorage.clearAllData();
      return unit;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        ErrorResponseModel(
          status: e.code,
          message: e.message ?? 'Unknown error',
          code: 0,
          response: e.message ?? 'Unknown error',
        ),
      );
    } catch (e) {
      throw AuthException(
        ErrorResponseModel(
          status: 'sign-out',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException(
          const ErrorResponseModel(
            status: 'google-sign-in',
            code: 400,
            response: 'Google sign in failed',
            message: 'Sign in aborted by user',
          ),
        );
      }

      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw ServerException(
          const ErrorResponseModel(
            status: 'google-sign-in',
            code: 400,
            response: 'Google sign in failed',
            message: 'Sign in aborted by user',
          ),
        );
      } else {
        return userCredential.user!;
      }
    } catch (e) {
      throw ServerException(
        const ErrorResponseModel(
          status: 'google-sign-in',
          code: 400,
          response: 'Google sign in failed',
          message: 'Sign in aborted by user',
        ),
      );
    }
  }

  @override
  Future<bool> checkUserDataExists({required String email}) async {
    try {
      final res = await _firebaseFirestore
          .collection(FirebaseConstants.usersCollectionName)
          .where('email', isEqualTo: email)
          .get();

      return res.docs.isNotEmpty;
    } catch (e) {
      logger.e('Check user data exists failed: $e');
      // rethrow;
      throw ServerException(
        ErrorResponseModel(
          status: 'check-user-data-failed',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
    }
  }

  // @override
  // Future<GetStudentEntity> getStudent({required String email}) async {
  //   try {
  //     final response = await apiHelper.get('student', {'email': email});
  //     appLocalStorage.setGetStudentResponse(
  //       GetStudentResponseModel.fromJson(
  //         response.data["response"] as Map<String, dynamic>,
  //       ),
  //     );
  //     return GetStudentModel.fromJson(response.data as Map<String, dynamic>);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<Unit> createStudent({
  //   required CreateStudentParams createStudentParams,
  // }) async {
  //   try {
  //     await apiHelper.post(
  //       'student',
  //       body: createStudentParams.toJson(),
  //     );
  //     return unit;
  //   } on Exception {
  //     rethrow;
  //   }
  // }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:user_app/backend/storage_service.dart';
import 'package:user_app/constant/firebse_constants.dart';
import 'package:user_app/errors/common_error_response.dart';
import 'package:user_app/errors/exceptions.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';
import 'package:user_app/local_storage/local_storage.dart';


abstract class UserDataDataSource {
  Stream<UserDataModel> getUserDataStream();

  Future<Unit> updateProviderAvailability(bool isAvailable);

  Future<Unit> updateUserDetails(Map<String, dynamic> data);

  Future<Unit> deleteAccount();

  Future<String> uploadCustomerProfilePicture(File profilePicture);
}

class UserDataDataSourceImpl implements UserDataDataSource {
  UserDataDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseDatabase firebaseDatabase,
    required FirebaseFunctions functions,
    required LocalStorage localStorage,
    required StorageService storageService,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _firebaseDatabase = firebaseDatabase,
        _functions = functions,
        _localStorage = localStorage,
        _storageService = storageService;

  final FirebaseAuth _firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;

  final FirebaseDatabase _firebaseDatabase;

  final FirebaseFunctions _functions;

  final LocalStorage _localStorage;

  final StorageService _storageService;

  final Logger logger = Logger();

  @override
  Stream<UserDataModel> getUserDataStream() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      logger.e('User is not logged in');
      throw AuthException(
        const ErrorResponseModel(
          status: 'user-not-logged-in',
          message: 'User is not logged in',
          code: 401,
          response: 'User is not logged in',
        ),
      );
    }

    try {
      return _firebaseFirestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(user.uid)
          .snapshots()
          .map(
        (snapshot) {
          if (snapshot.exists) {
            return UserDataModel.fromJson(snapshot.data()!);
          } else {
            return UserDataModel.empty;
          }
        },
      );
    } catch (e) {
      logger.e('Get user data stream failed: $e');
      throw ServerException(
        ErrorResponseModel(
          status: 'get-user-data-stream',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Unit> updateProviderAvailability(bool isAvailable) async {
    try {
      final docRef = _firebaseFirestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(_firebaseAuth.currentUser!.uid);

      await docRef.update({'is_provider_online': isAvailable});

      final dataMap = {
        'last_update': ServerValue.timestamp,
        'is_provider_online': isAvailable,
      };
      _firebaseDatabase
          .ref()
          .child('users/${_firebaseAuth.currentUser!.uid}')
          .update(dataMap);

      return unit;
    } catch (e) {
      throw ServerException(
        ErrorResponseModel(
          status: 'update-provider-availability-failed',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Unit> updateUserDetails(Map<String, dynamic> data) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final docRef = _firebaseFirestore.collection('users').doc(user.uid);
        await docRef.update(data);
        return unit;
      } else {
        throw ServerException(
          const ErrorResponseModel(
            status: 'update-user-details-failed',
            message: 'User not authenticated',
            code: 0,
            response: 'User not authenticated',
          ),
        );
      }
    } catch (e) {
      throw ServerException(
        ErrorResponseModel(
          status: 'update-user-details-failed',
          message: e.toString(),
          code: 0,
          response: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Unit> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        final deleteAccountRequest =
            _functions.httpsCallable('deleteAccountRequest');

        final response = await deleteAccountRequest.call({
          'user_id': user.uid,
          'type': 'user',
        });

        final data = response.data;

        if (data['type'] == 'error') {
          // return left(data['message']);
          throw ServerException(
            ErrorResponseModel(
              status: 'delete-account-failed',
              message: data['error'] as String,
              code: 0,
              response: data['error'] as String,
            ),
          );
        } else {
          await _firebaseAuth.signOut();

          await _localStorage.clearAllData();

          return unit;
        }
      } on ServerException catch (e) {
        throw ServerException(
          ErrorResponseModel(
            status: 'delete-account-failed',
            message: e.errorResponseModel.message,
            code: 0,
            response: e.errorResponseModel.response,
          ),
        );
      } catch (e) {
        throw ServerException(
          ErrorResponseModel(
            status: 'delete-account-failed',
            message: e.toString(),
            code: 0,
            response: e.toString(),
          ),
        );
      }
    } else {
      throw AuthException(
        const ErrorResponseModel(
          status: 'user-not-logged-in',
          message: 'User is not logged in',
          code: 401,
          response: 'User is not logged in',
        ),
      );
    }
  }

  @override
  Future<String> uploadCustomerProfilePicture(File profilePicture) async {
    try {
      final url = await _storageService.uploadFileToFirebase(
        profilePicture,
        'customer_profile_pictures/${_firebaseAuth.currentUser!.uid}',
      );

      if (url != null) {
        return url;
      } else {
        throw ServerException(
          const ErrorResponseModel(
            status: 'upload-profile-picture-failed',
            message: 'Failed to upload profile picture',
            code: 0,
            response: 'Failed to upload profile picture',
          ),
        );
      }
    } on ServerException {
      rethrow;
    }
  }
}

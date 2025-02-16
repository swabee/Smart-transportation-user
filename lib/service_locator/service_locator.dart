import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/app/domain/usecase/get_current_user_usecase.dart';
import 'package:user_app/app/domain/usecase/logout_user_usecase.dart';
import 'package:user_app/backend/storage_service.dart';
import 'package:user_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:user_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:user_app/features/auth/domain/repository/auth_repository.dart';
import 'package:user_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:user_app/features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:user_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/datasource/user_data_datasource.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/repositories/user_data_repository_impl.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/repositories/user_data_repository.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/delete_account_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/get_user_data_as_stream_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/save_user_details_locally_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/common/update_user_details_usecase.dart';
import 'package:user_app/features/customer_setting/customer_profile/domain/usecases/customer/upload_customer_profile_picture_usecase.dart';
import 'package:user_app/local_storage/local_storage.dart';
import 'package:user_app/network/network_info.dart';
import 'package:user_app/push_notifications/firebase_messaging_service.dart';
import 'package:user_app/utils/auth_service.dart';
import 'package:user_app/utils/snackbar_service.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocatorAndInitDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  //! Firebase Messaging Service
  registerLazySingleton(FirebaseMessagingService());

  //! Firebase Auth
  registerLazySingleton<FirebaseAuth>(FirebaseAuth.instance);

  registerLazySingleton<GoogleSignIn>(GoogleSignIn());

  //! Firebase Firestore
  registerLazySingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  // FirebaseFirestore.instance.clearPersistence();

  //! Firebase Real Time Database
  registerLazySingleton<FirebaseDatabase>(FirebaseDatabase.instance);

  //! Firebase Functions
  registerLazySingleton<FirebaseFunctions>(FirebaseFunctions.instance);

  //! Firebase Analytics
  registerLazySingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);

  //! Firebase messaging
  registerLazySingleton<FirebaseMessaging>(FirebaseMessaging.instance);

  //! Firebase Storage
  registerLazySingleton<FirebaseStorage>(FirebaseStorage.instance);

  //! Crashlytics
  registerLazySingleton<FirebaseCrashlytics>(FirebaseCrashlytics.instance);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  //! Services

  //! Storage Service
  registerLazySingleton<StorageService>(
    StorageService(firebaseStorage: locator()),
  );

  //! network
  registerLazySingleton<Connectivity>(Connectivity());

  //! network info
  registerLazySingleton<NetworkInfo>(NetworkInfoImpl(locator()));

  //! local storage
  registerLazySingleton<LocalStorage>(LocalStorage(prefs));

  //! snack bar service
  registerLazySingleton<SnackBarService>(SnackBarService());

  //! Auth service
  locator.registerLazySingleton(() => AuthService());
  //   //! Firebase messaging
  // registerLazySingleton<FirebaseMessaging>(FirebaseMessaging.instance);

  //! Auth Data source
  registerLazySingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(
      appLocalStorage: locator(),
      firebaseAuth: locator(),
      firebaseFirestore: locator(),
      googleSignIn: locator(),
    ),
  );

  //! Auth repository
  registerLazySingleton<AuthRepository>(
    AuthRepositoryImpl(
      authDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //! Auth usecases
  registerLazySingleton(GetCurrentUserUsecase(authRepository: locator()));

  registerLazySingleton(
    SignupWithEmailPasswordUsecase(authRepository: locator()),
  );

  registerLazySingleton(
    SignInWithGoogleUsecase(locator()),
  );

  registerLazySingleton(LogoutUserUsecase(authRepository: locator()));

  registerLazySingleton(LoginUsecase(authRepository: locator()));

  //? User data
  registerLazySingleton<UserDataDataSource>(
    UserDataDataSourceImpl(
      firebaseAuth: locator<FirebaseAuth>(),
      firebaseFirestore: locator<FirebaseFirestore>(),
      firebaseDatabase: locator<FirebaseDatabase>(),
      functions: locator<FirebaseFunctions>(),
      localStorage: locator<LocalStorage>(),
      storageService: locator<StorageService>(),
    ),
  );

  registerLazySingleton<UserDataRepository>(
    UserDataRepositoryImpl(
      userDataDataSource: locator<UserDataDataSource>(),
      networkInfo: locator<NetworkInfo>(),
      localStorage: locator<LocalStorage>(),
    ),
  );

  registerLazySingleton(
    GetUserDataAsStreamUsecase(
      userDataRepository: locator<UserDataRepository>(),
    ),
  );

  registerLazySingleton(
    DeleteAccountUsecase(
      locator<UserDataRepository>(),
    ),
  );

  //Auth cubit
  // registerLazySingleton<AuthCubit>(AuthCubit(locator()));

//update user  details
  registerLazySingleton(
    UpdateUserDetailsUsecase(
      locator(),
    ),
  );
  registerLazySingleton(
    UploadCustomerProfilePictureUsecase(
      locator(),
    ),
  );

  registerLazySingleton(
    SaveUserDetailsLocallyUsecase(
      locator(),
    ),
  );
}

void registerLazySingleton<T extends Object>(T object) {
  return locator.registerLazySingleton<T>(() => object);
}

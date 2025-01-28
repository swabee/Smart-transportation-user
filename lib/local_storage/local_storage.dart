import 'dart:convert';

import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/features/customer_setting/customer_profile/data/models/user_data_model.dart';


class LocalStorage {
  LocalStorage(SharedPreferences preferences) {
    secureStorage = preferences;
  }
  late SharedPreferences secureStorage;

  bool getIsManual() {
    return secureStorage.getBool('isManual') ?? false;
  }

  void clearStudentData() {
    secureStorage.remove('getStudentResponse');
  }

  Future<void> saveUserDetails(UserDataModel userDetails) async {
    try {
      await secureStorage.setString(
        'userDetails',
        jsonEncode(userDetails.toSaveLocally()),
      );

      Logger().i('User details saved successfully');
    } catch (e) {
      Logger().e('Error saving user details: $e');
    }
  }

  Map<String, dynamic> getUserDetails() {
    final userDetails = secureStorage.getString('userDetails');
    if (userDetails != null) {
      return jsonDecode(userDetails) as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  ///Clear all the stored data from cache
  Future<void> clearAllData() async {
    await secureStorage.clear();
  }
}

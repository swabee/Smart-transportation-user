import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/errors/failures.dart';
import 'package:user_app/models/notification_model.dart';
import 'package:user_app/models/wallet_history_model.dart';
import 'package:user_app/service_locator/service_locator.dart';

Future<bool> addNotification(
    {required String title,
    required String content,
    required String type}) async {
  FirebaseAuth firebaseAuth = locator<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = locator<FirebaseFirestore>();
  try {
    DocumentReference documentReference = firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notifications')
        .doc();
    final notificationModel = NotificationModel(
        id: documentReference.id,
        title: title,
        content: content,
        createdAt: Timestamp.now(),
        type: type);

    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notifications')
        .doc(notificationModel.id)
        .set(notificationModel.toJson());

    return true;
  } catch (e) {
    return false;
  }
}

class GeneralFailure extends Failure {
  @override
  final String message;
  const GeneralFailure([this.message = "An error occurred"]);

  @override
  String toString() => message;
}

Future<bool> addTranscationHistory(
    {required String title,
    required String content,
    required bool isCredit}) async {
  FirebaseAuth firebaseAuth = locator<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = locator<FirebaseFirestore>();
  try {
    DocumentReference documentReference = firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('transactions')
        .doc();
    final notificationModel = WalletHistoryModel(
        id: documentReference.id,
        title: title,
        content: content,
        createdAt: Timestamp.now(),
        isCredited: isCredit);

    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('transactions')
        .doc(notificationModel.id)
        .set(notificationModel.toJson());
    return true;
  } catch (e) {
    return false;
  }
}

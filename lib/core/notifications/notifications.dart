import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:user_app/constant/firebse_constants.dart';
import 'package:user_app/service_locator/service_locator.dart';
import 'package:user_app/utils/auth_service.dart';


//! local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupNotifications() async {
final res=await  getTokenAndSave();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
   ); //todo enabele this for ios
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //!

  // final firebaseMessaging = locator<FirebaseMessaging>();
  // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

  NotificationSettings settings =
      await locator<FirebaseMessaging>().requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen(_handleBackgroundMessage);

  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
  });
}

void showFlutterNotification(RemoteMessage message) {
  Map<String, dynamic> payLoad = message.data;

  final String title = payLoad['title'];
  final String body = payLoad['body'];

  if (!kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'notification',
            'notification',
            // icon: android.smallIcon,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            // subtitle: notification.body,
          )),
    );
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: Text(title),
  //     content: Text(body),
  //     actions: [
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         child: Text('Ok'),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => SecondScreen(payload),
  //             ),
  //           );
  //         },
  //       )
  //     ],
  //   ),
  // );
}

void saveTokenToDatabase(String token) async {
  // Assume the user is logged in for this example

  if (locator<AuthService>().currentUser != null) {
    String userId = locator<AuthService>().currentUser!.uid;

    await locator<FirebaseFirestore>()
        .collection(FirebaseConstants.usersCollectionName)
        .doc(userId)
        .update(
      {
        'fcm_token': token,
      },
    );
  }
}

Future<void> getTokenAndSave() async {
  //check if the user is logged in
  if (locator<AuthService>().currentUser == null) {
    return;
  }
  String? token = await locator<FirebaseMessaging>().getToken();
  // print('FCM Token: $token');
  saveTokenToDatabase(token!);
  return;
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  showFlutterNotification(message);
}

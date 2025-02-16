import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:user_app/backend/firebase_options.dart';

/// Service to handle all Firebase Cloud Messaging (FCM) related functionality
/// This includes:
/// - Initialization of FCM
/// - Handling background messages
/// - Handling foreground messages
/// - Managing notifications
/// - Handling notification taps
class FirebaseMessagingService {
  // Singleton instance

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Flutter Local Notifications Plugin instance
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize channel as const
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  // Flag to track if notifications are initialized
  bool isFlutterLocalNotificationsInitialized = false;

  /// Initialize the Firebase Messaging service
  /// This should be called when the app starts
  Future<void> initialize() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      // Initialize notifications
      await setupFlutterNotifications();

      // Register background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Set up foreground message handler
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Request permission for iOS
      await _requestIOSPermissions();

      // Set up FCM token
      await setupToken();
    } catch (e) {
      _logger.e('Error initializing Firebase Messaging: $e');
    }
  }

  /// Initialize messaging specifically for the root page
  /// Handles initial message and app open scenarios
  Future<void> initializeMessaging(BuildContext context) async {
    try {
      // Get any initial message
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleInitialMessage(initialMessage, context);
      }

      // Listen for app open from background
      FirebaseMessaging.onMessageOpenedApp
          .listen((message) => _handleMessageOpenedApp(message, context));
    } catch (e) {
      _logger.e('Error initializing messaging in root: $e');
    }
  }

  /// Handle messages when app is in foreground
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _logger.i('Got a message whilst in the foreground!');
    _logger.d('Message data: ${message.data}');
    if (message.notification != null) {
      _logger.d('Message notification: ${message.notification}');
    }

    showFlutterNotification(message);
  }

  /// Handle when app is launched from terminated state
  void _handleInitialMessage(RemoteMessage message, BuildContext context) {
    _logger.i('Handling initial message: ${message.messageId}');
    // Add navigation logic here based on message data
  }

  /// Handle when app is opened from background state
  Future<void> _handleMessageOpenedApp(
      RemoteMessage message, BuildContext context) async {
    _logger.i('Message opened app from background');
    _logger.d('Message data: ${message.data}');
    // Add navigation logic here based on message data
  }

  /// Set up Flutter Local Notifications
  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) return;

    // Initialize Flutter Local Notifications
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _handleNotificationTap,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Create the Android Notification Channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Update iOS foreground notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  /// Show a Flutter Local Notification
  void showFlutterNotification(RemoteMessage message) {
    if (kIsWeb) return;

    final payLoad = message.data;
    final title = payLoad['title'] as String? ?? 'test title';
    final body = payLoad['body'] as String? ?? 'test body';
    final orderId = payLoad['info_id'] as String? ?? '';
    final notificationType = payLoad['type'] as String? ?? '';

    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: orderId,
    );
  }

  /// Handle notification tap in foreground
  void _handleNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      _logger.i('Notification tapped with payload: ${response.payload}');
      // Add navigation logic here based on payload
    }
  }

  /// Request iOS notification permissions
  Future<void> _requestIOSPermissions() async {
    if (!kIsWeb) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  /// Saves FCM token to user document in Firestore
  /// Updates token and related metadata
  Future<void> saveTokenToDatabase(String token) async {
    try {
      // Get current user ID
      final String? userId = _auth.currentUser?.uid;

      if (userId == null) {
        _logger.w('No user logged in - cannot save FCM token');
        return;
      }

      // Reference to user document
      final userRef = _firestore.collection('users').doc(userId);

      // Token data to save
      final tokenData = {
        'fcm_token': token,
        'last_fcm_token_update': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
        'device_info': {
          'platform': Platform.operatingSystem,
          'version': Platform.operatingSystemVersion,
        }
      };

      // Update user document
      await userRef.update(tokenData);
      _logger.i('FCM Token saved for user: $userId');
    } catch (e) {
      _logger.e('Error saving FCM token: $e');
    }
  }

  /// Initialize FCM token setup
  /// Gets current token and listens for token refreshes
  Future<void> setupToken() async {
    try {
      // Get the current token
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        await saveTokenToDatabase(token);
      }

      // Listen to token refreshes
      // FirebaseMessaging.instance.onTokenRefresh.listen((String token) async {
      //   print('FCM Token refreshed');
      //   await saveTokenToDatabase(token);
      // });
    } catch (e) {
      _logger.e('Error setting up FCM token: $e');
    }
  }
}

/// Handle notification tap in background
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  Logger().i(
      'Notification tapped in background with payload: ${notificationResponse.payload}');
  // Handle background notification tap
}

/// Background message handler
/// This must be a top-level or static function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    // Initialize Firebase for background messages
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessagingService().setupFlutterNotifications();
    FirebaseMessagingService().showFlutterNotification(message);
    Logger().i('Handling a background message ${message.messageId}');
  } catch (e) {
    Logger().e('Error handling background message: $e');
  }
}

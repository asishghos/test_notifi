import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification/main.dart';
import 'dart:developer'; // Use for logging instead of print

class FirebaseApi {
  // Instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications
  Future<void> initNotifications() async {
    try {
      // Request permission from the user
      NotificationSettings settings = await _firebaseMessaging.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted notification permissions.');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        log('User granted provisional notification permissions.');
      } else {
        log('User declined or has not granted notification permissions.');
        return; // Exit if permissions are not granted
      }

      // Fetch the FCM token for this device
      final fcmToken = await _firebaseMessaging.getToken();
      log('FCM Token: $fcmToken');
    } catch (e, stack) {
      log('Error initializing notifications: $e', stackTrace: stack);
    }
  }

  // Handle received messages
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    log('Message received: ${message.notification?.title ?? "No Title"}');
    navigatorKey.currentState?.pushNamed(
      '/notification_page',
      arguments: message,
    );
  }

  // Initialize push notification settings for foreground, background, and terminated states
  Future<void> initPushNotifications() async {
    try {
      // Handle messages when the app is launched from a terminated state
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

      // Handle messages when the app is opened from the background
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

      // Handle messages while the app is in the foreground
      FirebaseMessaging.onMessage.listen((message) {
        log('Foreground message received: ${message.notification?.title ?? "No Title"}');
        // Optionally handle foreground notifications
      });
    } catch (e, stack) {
      log('Error initializing push notifications: $e', stackTrace: stack);
    }
  }
}
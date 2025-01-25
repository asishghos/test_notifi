import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notification/api/firebase_api.dart';
import 'package:notification/pages/home_page.dart';
import 'package:notification/pages/notification_page.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseApi = FirebaseApi();
  await firebaseApi.initNotifications();
  await firebaseApi.initPushNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {'/notification_page': (context) => NotificationPage()},
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

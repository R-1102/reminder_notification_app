import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'DetailScreen.dart';
import 'InputScreen.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;
      if (payload != null) {
        runApp(MyApp(payload: payload));
      } else {
        runApp(MyApp());
      }
    },
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String? payload;

  const MyApp({super.key, this.payload});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: payload == null ? '/' : '/detail',
      routes: {
        '/': (context) => InputScreen(),
        '/detail': (context) => DetailScreen(payload: payload ?? ''),
      },
    );
  }
}

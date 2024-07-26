import 'package:flutter/material.dart';
import 'package:pequod/Screens/SplashScreen.dart';
import 'package:pequod/Theme/LightTheme.dart';
import 'package:pequod/Theme/DarkTheme.dart';
import 'package:pequod/Services//Notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterLocalNotification.init().then((_) {
      FlutterLocalNotification.requestNotificationPermission().then((_) {
        FlutterLocalNotification.instance.selectedDatePushAlarm();
      });
    }).catchError((error) {
      print('Error initializing notifications: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      darkTheme: DarkTheme().theme,
      home: SplashScreen(),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: child!,
          )),
    );
  }
}

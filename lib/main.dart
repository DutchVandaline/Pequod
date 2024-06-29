import 'package:flutter/material.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Theme/LightTheme.dart';
import 'package:pequod/Theme/DarkTheme.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      darkTheme: DarkTheme().theme,
      home: MainScreen(),
    );
  }
}
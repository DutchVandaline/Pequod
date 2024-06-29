import 'package:flutter/material.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class TragedyScreen extends StatefulWidget {
  const TragedyScreen({super.key});

  @override
  State<TragedyScreen> createState() => _TragedyScreenState();
}

class _TragedyScreenState extends State<TragedyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: ClimateChangeTextWidget("Tragedy"),
      ),
    );
  }
}

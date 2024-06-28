import 'package:flutter/material.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: ClimateChangeTextWidget("Settings"),
      ),

    );
  }
}

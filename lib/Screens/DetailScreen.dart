import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Screens/VerificationScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class DetailScreen extends StatefulWidget {
  final String habitName;
  final int habitId;

  const DetailScreen(
      {super.key, required this.habitId, required this.habitName});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: ClimateChangeTextWidget("Detail"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificationScreen(
                            habitName: widget.habitName,
                            habitId: widget.habitId)));
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                ApiServices.deleteHabit(widget.habitId);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                        (route) => false);
              },
              icon: const Icon(
                Icons.delete_forever_outlined,
                size: 30.0,
              )),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}

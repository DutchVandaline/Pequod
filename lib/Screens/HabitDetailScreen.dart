import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Screens/VerificationScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class HabitDetailScreen extends StatefulWidget {
  final String habitName;
  final int habitId;

  const HabitDetailScreen(
      {super.key, required this.habitId, required this.habitName});

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
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
      body: FutureBuilder(
          future: ApiServices.getHabitbyId(widget.habitId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "🏴‍☠️ Error",
                  style: TextStyle(
                    fontFamily: 'FjallaOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic>? habitData =
              snapshot.data as Map<String, dynamic>;
              if (habitData.isNotEmpty) {
                return Column(
                  children: [
                    Text(habitData['id'].toString()),
                    Text(widget.habitName),
                    Text(habitData['date'].toString()),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(
                      fontFamily: 'FjallaOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                );
              }
            } else {
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(
                    fontFamily: 'FjallaOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              );
            }
          }),
    );
  }
}

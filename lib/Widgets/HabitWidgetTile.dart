import 'package:flutter/material.dart';
import 'package:pequod/Screens/VerificationScreen.dart';
import 'package:pequod/Widgets/HabitTrackWidget.dart';

class HabitWidgetTile extends StatefulWidget {
  String habitName;

  HabitWidgetTile({super.key, required this.habitName});

  @override
  State<HabitWidgetTile> createState() => _HabitWidgetTileState();
}

class _HabitWidgetTileState extends State<HabitWidgetTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VerificationScreen(habitName: widget.habitName,)));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorLight),
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "50%",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Row(
                    children: [
                      HabitTrackWidget(completed: false),
                      HabitTrackWidget(completed: true),
                      HabitTrackWidget(completed: true),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.habitName,
                  style: const TextStyle(
                    fontFamily: 'ClimateCrisis',
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

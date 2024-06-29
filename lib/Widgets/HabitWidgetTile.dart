import 'package:flutter/material.dart';
import 'package:pequod/Widgets/HabitTrackWidget.dart';

class HabitWidget extends StatefulWidget {
  String habitName;

  HabitWidget({super.key, required this.habitName});

  @override
  State<HabitWidget> createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorLight),
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "50%",
                      style:
                          TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Row(
                    children: [
                      HabitTrackWidget(completed: false),
                      HabitTrackWidget(completed: true),
                      HabitTrackWidget(completed: false),
                      HabitTrackWidget(completed: true),
                      HabitTrackWidget(completed: true),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Use Tumbler rather than un-recyclable cups.",
                  style: TextStyle(
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

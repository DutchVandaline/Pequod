import 'package:flutter/material.dart';

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
      child: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColorLight),
            borderRadius: BorderRadius.circular(5.0)),
        child: Text("data"),
      ),
    );
  }
}

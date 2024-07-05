import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HabitDateWidget extends StatefulWidget {
  DateTime inputDate;

  HabitDateWidget({required this.inputDate});

  @override
  State<HabitDateWidget> createState() => _HabitDateWidgetState();
}

class _HabitDateWidgetState extends State<HabitDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Theme.of(context).primaryColorLight)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.inputDate.day.toString().padLeft(2, '0'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            Text(DateFormat('EEE').format(widget.inputDate),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
          ],
        ),
      ),
    );
  }
}

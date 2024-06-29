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
        width: MediaQuery.of(context).size.width * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat('EEE').format(widget.inputDate),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
            Text(widget.inputDate.day.toString().padLeft(2, '0'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ],
        ),
      ),
    );
  }
}

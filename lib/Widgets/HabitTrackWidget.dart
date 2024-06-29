import 'package:flutter/material.dart';

class HabitTrackWidget extends StatefulWidget {
  HabitTrackWidget({super.key, required this.completed});

  bool completed;

  @override
  State<HabitTrackWidget> createState() => _HabitTrackWidgetState();
}

class _HabitTrackWidgetState extends State<HabitTrackWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.completed ? "✓" :"✘",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ],
        ),
      ),
    );
  }
}

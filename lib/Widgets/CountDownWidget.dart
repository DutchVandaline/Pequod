import 'package:flutter/material.dart';
import 'dart:async';

class CountDownWidget extends StatefulWidget {
  final DateTime deadline;

  CountDownWidget({required this.deadline});

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late Duration timeLeft;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timeLeft = const Duration(days: 0, hours: 0, seconds: 0, minutes: 0, milliseconds: 0, microseconds: 0,);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft = widget.deadline.isAfter(DateTime.now())
            ? widget.deadline.difference(DateTime.now())
            : const Duration(
                days: 0,
                hours: 0,
                seconds: 0,
                minutes: 0,
                milliseconds: 0,
                microseconds: 0,
              );
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(
              fontFamily: 'FjallaOne',
              fontWeight: FontWeight.bold,
              color: Colors.white),
          children: [
            TextSpan(
                text: timeLeft.inDays.toString().padLeft(2, '0'),
                style: const TextStyle(fontSize: 40.0)),
            const TextSpan(
                text: " Days ",
                style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
            TextSpan(
                text: "${(timeLeft.inHours % 24).toString().padLeft(2, '0')}:"
                    "${(timeLeft.inMinutes % 60).toInt().toString().padLeft(2, '0')}:"
                    "${(timeLeft.inSeconds % 60).toInt().toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 40.0)),
          ]),
    );
  }
}

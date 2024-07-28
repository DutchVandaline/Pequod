import 'dart:async';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  final DateTime? deadline;
  final bool dead;
  final TextStyle inputTextStyle;

  const CountDownWidget({Key? key, required this.deadline, required this.dead, required this.inputTextStyle}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  Duration timeLeft = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (widget.deadline != null) {
        final now = DateTime.now();
        if (now.isBefore(widget.deadline!)) {
          setState(() {
            timeLeft = widget.deadline!.difference(now);
          });
        } else {
          if (timer != null) {
            timer!.cancel();
            timer = null;
          }
          setState(() {
            timeLeft = Duration.zero; // Time expired
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.dead  && timeLeft == Duration.zero
        ? Text(
            "☠️ Your Animal is Dead. ☠️",
            style: widget.inputTextStyle
          )
        : RichText(
      text: TextSpan(
          style: widget.inputTextStyle,
          children: [
            TextSpan(
                text: timeLeft.inDays
                    .toString()
                    .padLeft(2, '0'),
                style:
                widget.inputTextStyle),
            TextSpan(
                text: " Days ",
                style: widget.inputTextStyle),
            TextSpan(
                text:
                "${(timeLeft.inHours % 24).toString().padLeft(2, '0')}:"
                    "${(timeLeft.inMinutes % 60).toInt().toString().padLeft(2, '0')}:"
                    "${(timeLeft.inSeconds % 60).toInt().toString().padLeft(2, '0')}",
                style:
                widget.inputTextStyle),
          ]),
    );
  }
}

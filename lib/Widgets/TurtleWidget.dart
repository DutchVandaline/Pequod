import 'dart:async';

import 'package:flutter/material.dart';

import 'GarbageWidget.dart';

class TurtleWidget extends StatefulWidget {
  DateTime deadline;

  TurtleWidget({super.key, required this.deadline});

  @override
  State<TurtleWidget> createState() => _TurtleWidgetState();
}

class _TurtleWidgetState extends State<TurtleWidget> {
  late Timer _timer;
  late Duration leftTime;

  @override
  void initState() {
    super.initState();
    leftTime = widget.deadline.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newLeftTime = widget.deadline.difference(DateTime.now());
      if (newLeftTime != leftTime) {
        setState(() {
          leftTime = newLeftTime;
          if (leftTime.isNegative) {
            leftTime = Duration.zero;
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool isGarbageVisible(int index) {
    if (leftTime.inHours <= 2) {
      return true;
    } else if (leftTime.inHours <= 24) {
      return index <= 8;
    } else if (leftTime.inHours <= 36) {
      return index <= 4;
    } else if (leftTime.inHours <= 72) {
      return index <= 2;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Image.asset(
          'assets/images/animals/sea_turtle.png',
          alignment: Alignment.bottomCenter,
        ),
        if(isGarbageVisible(0)) GarbageWidget(top: 0.2, left: 0.14, size: 0.03, angle: 0.5, asset: "tribotblood_orange"),
        if(isGarbageVisible(8)) GarbageWidget(top: 0.1, left: 0.4, size: 0.05, angle: 0.4, asset: "bottletop_blood"),
        if(isGarbageVisible(2)) GarbageWidget(top: 0.16, left: 0.2, size: 0.06, angle: 5, asset: "bottlebottom_blood"),
        if(isGarbageVisible(1)) GarbageWidget(top: 0.03, left: 0.05, size: 0.04, angle: -0.5, asset: "tribotblood_sky"),
        if(isGarbageVisible(7)) GarbageWidget(top: 0.04, left: 0.3, size: 0.05, angle: -0.4, asset: "tribot_green"),
        if(isGarbageVisible(3)) GarbageWidget(top: 0.12, left: 0.1, size: 0.06, angle: 3.3, asset: "tribotblood_blue"),
        if(isGarbageVisible(6)) GarbageWidget(top: 0.2, left: 0.56, size: 0.035, angle: 5, asset: "tribotblood_yellow"),

      ]),
    );
  }
}

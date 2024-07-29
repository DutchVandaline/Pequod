import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pequod/Widgets/GarbageWidget.dart';

class PolarBearWidget extends StatefulWidget {
  final DateTime deadline;

  PolarBearWidget({required this.deadline, super.key});

  @override
  State<PolarBearWidget> createState() => _PolarBearWidgetState();
}

class _PolarBearWidgetState extends State<PolarBearWidget> {
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
    } else if (leftTime.inHours <= 12) {
      return index <= 8;
    } else if (leftTime.inHours <= 24) {
      return index <= 4;
    } else if (leftTime.inHours <= 48) {
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
        //if(isGarbageVisible(8))
          GarbageWidget(top: 0.05, left: 0.32, size: 0.06, angle: 0.5, asset: "tribot_orange"),
        Image.asset(
          'assets/images/animals/polar_bear.png',
          alignment: Alignment.bottomCenter,
        ),
        //if(isGarbageVisible(0))
          GarbageWidget(top: 0.06, left: 0.3, size: 0.05, angle: 0.4, asset: "bottletop_blood"),
        //if(isGarbageVisible(2))
          GarbageWidget(top: 0.16, left: 0.03, size: 0.06, angle: 5, asset: "bottlebottom_blood"),
        //if(isGarbageVisible(1))
          GarbageWidget(top: 0.1, left: 0.4, size: 0.04, angle: 0, asset: "tribotblood_blue"),
        //if(isGarbageVisible(7))
          GarbageWidget(top: 0.17, left: 0.37, size: 0.03, angle: 2, asset: "tribotblood_green"),
        //if(isGarbageVisible(3))
          GarbageWidget(top: 0.2, left: 0.5, size: 0.04, angle: 2.6, asset: "bottletop_blood"),
        //if(isGarbageVisible(6))
          GarbageWidget(top: 0.11, left: 0.15, size: 0.035, angle: 5, asset: "tribotblood_sky"),

      ]),
    );
  }
}

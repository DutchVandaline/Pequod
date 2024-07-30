import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pequod/Widgets/GarbageWidget.dart';

class WhaleWidget extends StatefulWidget {
  DateTime deadline;

  WhaleWidget({required this.deadline, super.key});

  @override
  State<WhaleWidget> createState() => _WhaleWidgetState();
}

class _WhaleWidgetState extends State<WhaleWidget> {
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
    if (leftTime.inHours <= 12) {
      return true;
    } else if (leftTime.inHours <= 24) {
      return index <= 6;
    } else if (leftTime.inHours <= 36) {
      return index <= 4;
    } else if (leftTime.inHours <= 48) {
      return index <= 2;
    } else if (leftTime.inHours <= 72) {
      return index <= 1;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.4,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            if(isGarbageVisible(4)) GarbageWidget(top: 0, left: 0.03, size: 0.1, angle: 3, asset: "bottle_withblack"),
            if(isGarbageVisible(8)) GarbageWidget(top: 0.01, left: 0.32, size: 0.05, angle: 0.5, asset: "tribot_orange"),
            Image.asset(
              'assets/images/animals/whale.png',
              alignment: Alignment.bottomCenter,
            ),
            if(isGarbageVisible(0)) GarbageWidget(top: 0.04, left: 0.4, size: 0.05, angle: 0.4, asset: "bottletop_blood"),
            if(isGarbageVisible(2)) GarbageWidget(top: 0.02, left: -0.02, size: 0.06, angle: 5, asset: "bottlebottom_blood"),
            if(isGarbageVisible(1)) GarbageWidget(top: 0.02, left: 0.3, size: 0.04, angle: 0, asset: "tribotblood_yellow"),
            if(isGarbageVisible(7)) GarbageWidget(top: 0.05, left: 0.3, size: 0.03, angle: 2, asset: "tribotblood_green"),
            if(isGarbageVisible(3)) GarbageWidget(top: 0.12, left: 0.1, size: 0.06, angle: 3.3, asset: "tribotblood_blue"),
            if(isGarbageVisible(6)) GarbageWidget(top: 0.02, left: 0.65, size: 0.035, angle: 5, asset: "tribotblood_orange"),
          ]),
        ),
      ),
    );
  }
}

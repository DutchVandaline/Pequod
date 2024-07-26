import 'package:flutter/material.dart';
import 'package:pequod/Widgets/GarbageWidget.dart';

class WhaleWidget extends StatefulWidget {
  String animalName;
  Duration leftTime;

  WhaleWidget({required this.animalName, required this.leftTime, super.key});

  @override
  State<WhaleWidget> createState() => _WhaleWidgetState();
}

class _WhaleWidgetState extends State<WhaleWidget> {
  bool isGarbageVisible(int index) {
    if (widget.leftTime.inHours <= 2) {
      return true;
    } else if (widget.leftTime.inHours <= 12) {
      return index <= 8;
    } else if (widget.leftTime.inHours <= 24) {
      return index <= 4;
    } else if (widget.leftTime.inHours <= 48) {
      return index <= 2;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Stack(alignment: Alignment.bottomCenter, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.animalName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFamily: 'FjallaOne',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.22,
                     color: Color(0xFF202023),
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if(isGarbageVisible(4)) GarbageWidget(top: 0.15, left: 0.03, size: 0.15, angle: 3, asset: "bottle_withblack"),
            if(isGarbageVisible(8)) GarbageWidget(top: 0.18, left: 0.4, size: 0.08, angle: 0.5, asset: "tribot_orange"),
            Image.asset(
              'assets/images/animals/whale.png',
              alignment: Alignment.bottomCenter,
            ),
            if(isGarbageVisible(0)) GarbageWidget(top: 0.22, left: 0.5, size: 0.08, angle: 0.4, asset: "bottletop_blood"),
            if(isGarbageVisible(2)) GarbageWidget(top: 0.21, left: -0.01, size: 0.06, angle: 5, asset: "bottlebottom_blood"),
            if(isGarbageVisible(1)) GarbageWidget(top: 0.2, left: 0.4, size: 0.04, angle: 0, asset: "tribotblood_yellow"),
            if(isGarbageVisible(7)) GarbageWidget(top: 0.3, left: 0.36, size: 0.03, angle: 2, asset: "tribotblood_green"),
            if(isGarbageVisible(3)) GarbageWidget(top: 0.335, left: 0.1, size: 0.06, angle: 3.3, asset: "tribotblood_blue"),
            if(isGarbageVisible(6)) GarbageWidget(top: 0.2, left: 0.75, size: 0.04, angle: 5, asset: "tribotblood_orange"),
          ]),
        ),
      ),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    print(widget.leftTime.inSeconds);
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
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GarbageWidget(top: 0.15, left: 0.03, size: 0.15, angle: 3, asset: "bottle_withblack"),
            Image.asset(
              'assets/images/animals/whale.png',
              alignment: Alignment.bottomCenter,
            ),
            GarbageWidget(top: 0.22, left: 0.5, size: 0.08, angle: 0.4, asset: "bottletop_blood"),
            GarbageWidget(top: 0.21, left: -0.01, size: 0.06, angle: 5, asset: "bottlebottom_blood"),
            GarbageWidget(top: 0.2, left: 0.4, size: 0.04, angle: 0, asset: "tribotblood_yellow"),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pequod/Widgets/GarbageWidget.dart';

class PolarBearWidget extends StatefulWidget {
  final String animalName;
  final Duration leftTime;

  PolarBearWidget({required this.animalName, required this.leftTime, super.key});

  @override
  State<PolarBearWidget> createState() => _PolarBearWidgetState();
}

class _PolarBearWidgetState extends State<PolarBearWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
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
              overflow: TextOverflow.clip,
            ),
          ),
          Image.asset(
            'assets/images/animals/polar_bear.png',
            alignment: Alignment.bottomCenter,
          ),
          GarbageWidget(top: 0.2, left: 0.6, size: 0.07, angle: 0.4, asset: "bottletop_blood")
        ]),
      ),
    );
  }
}

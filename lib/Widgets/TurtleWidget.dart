import 'package:flutter/material.dart';

class TurtleWidget extends StatefulWidget {
  String animalName;

  TurtleWidget({super.key, required this.animalName});

  @override
  State<TurtleWidget> createState() => _TurtleWidgetState();
}

class _TurtleWidgetState extends State<TurtleWidget> {
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
              style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.22),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.21,
            child: Transform.rotate(
              angle: 2.6,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                        'assets/images/garbages/bottle_withblack.png')),
              ),
            ),
          ),
          Image.asset(
            'assets/images/animals/sea_turtle.png',
            alignment: Alignment.bottomCenter,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.17,
            left: MediaQuery.of(context).size.width * 0.54,
            child: Transform.rotate(
              angle: 0.4,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                        'assets/images/garbages/bottletop_blood.png')),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
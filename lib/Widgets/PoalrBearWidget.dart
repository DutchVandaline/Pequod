import 'package:flutter/material.dart';


class PolarBearWidget extends StatefulWidget {
  String animalName;

  PolarBearWidget({required this.animalName, super.key});

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
              style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.22),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            left: MediaQuery.of(context).size.width * 0.03,
            child: Transform.rotate(
              angle: 3,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child:
                    Image.asset('assets/images/garbages/bottle_withblack.png')),
              ),
            ),
          ),
          Image.asset(
            'assets/images/animals/polar_bear.png',
            alignment: Alignment.bottomCenter,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: MediaQuery.of(context).size.width * 0.5,
            child: Transform.rotate(
              angle: 0.4,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child:
                    Image.asset('assets/images/garbages/bottletop_blood.png')),
              ),
            ),
          ),

        ]),
      ),
    );
  }
}

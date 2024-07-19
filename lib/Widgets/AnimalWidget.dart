import 'package:flutter/material.dart';

class AnimalWidget extends StatefulWidget {
  const AnimalWidget({super.key});

  @override
  State<AnimalWidget> createState() => _AnimalWidgetState();
}

class _AnimalWidgetState extends State<AnimalWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Positioned(
            top: 140.0,
            left: 100.0,
            child: Transform.rotate(
              angle: 2.6,
              child: SizedBox(
                height: 160.0,
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child:
                    Image.asset('assets/images/garbages/bottle_withblack.png')),
              ),
            ),
          ),
          Image.asset(
            'assets/images/animals/sea_turtle.png',
            alignment: Alignment.bottomCenter,
          ),
          Positioned(
            top: 130.0,
            left: 200.0,
            child: Transform.rotate(
              angle: 0.3,
              child: SizedBox(
                height: 130.0,
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child:
                        Image.asset('assets/images/garbages/bottletop_withside.png')),
              ),
            ),
          ),

        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class WhaleWidget extends StatefulWidget {
  const WhaleWidget({super.key});

  @override
  State<WhaleWidget> createState() => _WhaleWidgetState();
}

class _WhaleWidgetState extends State<WhaleWidget> {
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
              "WHALE",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.22),
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
            'assets/images/animals/whale.png',
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
                    Image.asset('assets/images/garbages/bottletop_withside.png')),
              ),
            ),
          ),

        ]),
      ),
    );
  }
}

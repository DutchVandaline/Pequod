import 'package:flutter/material.dart';

class GarbageWidget extends StatelessWidget {
  double top;
  double left;
  double angle;
  double size;
  String asset;

  GarbageWidget({
    super.key,
    required this.top,
    required this.left,
    required this.size,
    required this.angle,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * top,
      left: MediaQuery.of(context).size.width * left,
      child: Transform.rotate(
        angle: angle,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * size,
          child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset('assets/images/garbages/$asset.png')),
        ),
      ),
    );
  }
}

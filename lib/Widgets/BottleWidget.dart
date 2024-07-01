import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BottleWidget extends StatefulWidget {
  const BottleWidget({super.key});

  @override
  State<BottleWidget> createState() => _PositionedBottleWidgetState();
}

class _PositionedBottleWidgetState extends State<BottleWidget> {
  double _left = 0.0;
  double _top = 0.0;
  double _rotation = 0;
  final Random random = Random();
  bool _visible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _randomizePosition();
    _startTimer();
    _timer.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _randomizePosition();
          _visible = true;
          _checkVisibility();
        });
      }
    });
  }

  void _randomizePosition() {
    _left = random.nextDouble() * 300;
    _top = random.nextDouble() * 500;
    _rotation = random.nextDouble() * 2 * pi;
  }

  void _checkVisibility() {
      if (!_visible) {
        _startTimer();
      } else {
        _timer.cancel();
      }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: _left,
      top: _top,
      duration: const Duration(milliseconds: 0),
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _visible = false;
              _checkVisibility();
            });
          },
          child: Transform.rotate(
            angle: _rotation,
            child: Container(
              width: 20.0,
              height: 20.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

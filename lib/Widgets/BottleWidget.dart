import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottleWidget extends StatefulWidget {
  final VoidCallback onBottleTap; // Callback to notify when bottle is tapped

  const BottleWidget({Key? key, required this.onBottleTap}) : super(key: key);

  @override
  State<BottleWidget> createState() => _PositionedBottleWidgetState();
}

class _PositionedBottleWidgetState extends State<BottleWidget> {
  double _left = 0.0;
  double _top = 0.0;
  double _rotation = 0;
  double _size = 20.0;
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
    _size = random.nextInt(130) + 50;
    _rotation = random.nextDouble() * 2 * pi;
  }

  void _checkVisibility() {
    if (!_visible) {
      _startTimer();
    } else {
      _timer.cancel();
    }
  }

  Future<void> _incrementBottleCount() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt('bottle_count') ?? 0;
    await prefs.setInt('bottle_count', currentCount + 1);
    widget.onBottleTap(); // Notify the parent about the change
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
          onTap: () async {
            setState(() {
              _visible = false;
              _checkVisibility();
            });
            await _incrementBottleCount();
          },
          child: Transform.rotate(
            angle: _rotation,
            child: Container(
              height: _size,
              color: Colors.transparent,
              child: AspectRatio(
                  aspectRatio: 58 / 138,
                  child: Center(
                      child: Image.asset('assets/images/garbages/water_bottle.png'))),
            ),
          ),
        ),
      ),
    );
  }
}

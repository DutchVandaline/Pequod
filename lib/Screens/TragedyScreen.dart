import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Widgets/BottleWidget.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TragedyScreen extends StatefulWidget {
  const TragedyScreen({super.key});

  @override
  State<TragedyScreen> createState() => _TragedyScreenState();
}

class _TragedyScreenState extends State<TragedyScreen> {
  int _bottleCount = 0;

  Future<void> _loadBottleCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bottleCount = prefs.getInt('bottle_count') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBottleCount();
  }

  void _refreshBottleCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bottleCount = prefs.getInt('bottle_count') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: ClimateChangeTextWidget("Tragedy"),
      ),
      body: SafeArea(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  const Color(0xFF0d4ba7),
                  const Color(0xFF0d3ba7),
                  const Color(0xFF072137),
                  const Color(0xFF202023)
                ],
              ),
            ),
            child: Center(
              child: Text(
                _bottleCount.toString(),
                style: TextStyle(
                    fontFamily: "FjallaOne",
                    fontSize: 50.0,
                    color: Theme.of(context).primaryColor
                ),
              ),
            ),
          ),
          CustomPaint(painter: CirclePainter(context: context)),
          BottleWidget(onBottleTap: _refreshBottleCount),
          BottleWidget(onBottleTap: _refreshBottleCount),
          BottleWidget(onBottleTap: _refreshBottleCount),
          BottleWidget(onBottleTap: _refreshBottleCount),
          BottleWidget(onBottleTap: _refreshBottleCount),
        ]),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final BuildContext context;

  CirclePainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(Offset.zero, MediaQuery.of(context).size.width * 0.2, paint);
    canvas.drawCircle(Offset.zero, MediaQuery.of(context).size.width * 0.4, paint);
    canvas.drawCircle(Offset.zero, MediaQuery.of(context).size.width * 0.6, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:pequod/Widgets/BottleWidget.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class TragedyScreen extends StatefulWidget {
  const TragedyScreen({super.key});

  @override
  State<TragedyScreen> createState() => _TragedyScreenState();
}

class _TragedyScreenState extends State<TragedyScreen> {
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
          ),
          CustomPaint(painter: CirclePainter(context: context)),
          const BottleWidget(),
          const BottleWidget(),
          const BottleWidget(),
          const BottleWidget(),
          const BottleWidget(),
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
      ..strokeWidth = 1.0; // You can adjust the stroke width here

    canvas.drawCircle(
        Offset.zero, MediaQuery.of(context).size.width * 0.2, paint);
    canvas.drawCircle(
        Offset.zero, MediaQuery.of(context).size.width * 0.4, paint);
    canvas.drawCircle(
        Offset.zero, MediaQuery.of(context).size.width * 0.6, paint);
    // Add more circles as needed
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

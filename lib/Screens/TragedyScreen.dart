import 'package:flutter/material.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Screens/MainScreen.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                showBuyDialog(context, _bottleCount);
              },
              icon: const Icon(
                Icons.price_change_outlined,
                size: 30.0,
              )),
        ],
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
                style: const TextStyle(
                    fontFamily: "FjallaOne",
                    fontSize: 50.0,
                    color: Color(0xFFe5e3d8)),
              ),
            ),
          ),
          CustomPaint(painter: CirclePainter(context: context)),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 0,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 0,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 0,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 0,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 0,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 1,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 1,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 1,),
          BottleWidget(onBottleTap: _refreshBottleCount, garbagetype: 1,),
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

    canvas.drawCircle(
        Offset.zero, MediaQuery.of(context).size.width * 0.2, paint);
    canvas.drawCircle(
        Offset.zero, MediaQuery.of(context).size.width * 0.4, paint);
    canvas.drawCircle(
        Offset.zero, MediaQuery.of(context).size.width * 0.6, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void showBuyDialog(BuildContext context, int currentBottle) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Exchange',
          style: TextStyle(
              fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "You can get change bottles with additional points.\n(10 bottles = 1 point)",
              style: TextStyle(fontSize: 19.0, fontFamily: 'FjallaOne'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "$currentBottle bottles = ${currentBottle ~/ 10} points",
              style: const TextStyle(fontSize: 30.0, fontFamily: 'FjallaOne'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextButton(
                  onPressed: () async {
                    try {
                      if (currentBottle ~/ 10 == 0) {
                        print("Nothing Happended");
                      } else {
                        await ApiServices.patchAddPoints((currentBottle ~/ 10).toInt());
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('bottle_count', 0);
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, a1, a2) => const MainScreen(initialIndex: 3,),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                          (route) => false,
                        );
                      }
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Text(
                        'Change',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'FjallaOne',
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Constants/EnvironmentTips.dart';
import 'package:pequod/Screens/AnimalDetailScreen.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Services/Notification.dart';
import 'package:pequod/Widgets/DeathWidget.dart';
import 'package:pequod/Widgets/PoalrBearWidget.dart';
import 'package:pequod/Widgets/TurtleWidget.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Constants/Constants.dart';
import 'package:pequod/Widgets/WhaleWidget.dart';

String animalName = "";
int animalType = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int rndNumb = 0;
  late Future<List<dynamic>?> animalFuture;
  DateTime? deadline;
  bool? dead;
  Timer? timer;
  Duration timeLeft = const Duration();

  @override
  void initState() {
    super.initState();
    Random random = Random();
    rndNumb = random.nextInt(envTips.length);
    animalFuture = ApiServices.getAnimal();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      DateTime now = DateTime.now();
      if (deadline != null && deadline!.isBefore(now)) {
        if (!dead!) {
          dead = true;
          await ApiServices.patchDead();
          setState(() {});
          refreshData();
        }
      } else if (deadline != null && deadline!.isAfter(now)) {
        setState(() {
          timeLeft = deadline!.difference(now);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> refreshData() async {
    setState(() {
      animalFuture = ApiServices.getAnimal();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timeLeft.inSeconds == 0) {
      refreshData();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        title: ClimateChangeTextWidget("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArchiveScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.book_outlined,
              size: MediaQuery.of(context).size.width * 0.07,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const MainScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30.0,
                color: Theme.of(context).primaryColorLight,
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Marquee(
                    text: Constants.newsLine,
                    style: TextStyle(
                      fontFamily: 'FjallaOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red, Colors.amber]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FutureBuilder(
                    future: animalFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CountDownPlaceholder();
                      } else if (snapshot.hasError) {
                        return const ErrorText(
                            '🏴‍☠️ Error Occurred Loading Deadline');
                      } else if (!snapshot.hasData ||
                          snapshot.data?.isEmpty == true) {
                        return const ErrorText(
                            '🏴‍☠️ There is no animal Data.');
                      } else {
                        deadline = DateTime.parse(
                            snapshot.data?.first['animal_deadline']);
                        dead = snapshot.data?.first['dead'];
                        if (deadline!.isBefore(DateTime.now()) &&
                            deadline?.second == 0) {
                          ApiServices.patchDead();
                        }

                        return dead == true
                            ? const Center(
                                child: Text(
                                  "☠️ Your Animal is Dead. ☠️",
                                  style: TextStyle(
                                      fontFamily: 'FjallaOne',
                                      fontSize: 25.0,
                                      color: Colors.white),
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        fontFamily: 'FjallaOne',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: timeLeft.inDays
                                              .toString()
                                              .padLeft(2, '0'),
                                          style:
                                              const TextStyle(fontSize: 40.0)),
                                      const TextSpan(
                                          text: " Days ",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text:
                                              "${(timeLeft.inHours % 24).toString().padLeft(2, '0')}:"
                                              "${(timeLeft.inMinutes % 60).toInt().toString().padLeft(2, '0')}:"
                                              "${(timeLeft.inSeconds % 60).toInt().toString().padLeft(2, '0')}",
                                          style:
                                              const TextStyle(fontSize: 40.0)),
                                    ]),
                              );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  dead == true
                      ? ()
                      : Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return AnimalDetailScreen(
                                animalName: animalName,
                                animalType: animalType,
                                leftTime: timeLeft,
                              );
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return Align(
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: FutureBuilder(
                    future: animalFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const ErrorText(
                            '🏴‍☠️ Error Occurred Loading Animal');
                      } else if (!snapshot.hasData ||
                          snapshot.data?.isEmpty == true) {
                        return DeathWidget();
                      } else {
                        animalName = snapshot.data?.first['animal_name'];
                        animalType = snapshot.data?.first['animal_type'];
                        return dead == true
                            ? DeathWidget()
                            : AnimalWidget(
                                animalType: animalType,
                                animalName: animalName,
                                leftTime: timeLeft);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: const Center(
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'FjallaOne',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "💡Tips",
                                  style: TextStyle(
                                    fontFamily: 'FjallaOne',
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  envTips[rndNumb],
                                  style: const TextStyle(
                                    fontFamily: 'FjallaOne',
                                    fontSize: 18.0,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountDownPlaceholder extends StatelessWidget {
  const CountDownPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'FjallaOne',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        children: [
          TextSpan(text: "--", style: TextStyle(fontSize: 40.0)),
          TextSpan(
              text: " Days ",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
          TextSpan(text: "--:--:--", style: TextStyle(fontSize: 40.0)),
        ],
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String message;

  const ErrorText(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          fontFamily: 'FjallaOne',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

class AnimalWidget extends StatelessWidget {
  final int animalType;
  final String animalName;
  final Duration leftTime;

  const AnimalWidget({
    required this.animalType,
    required this.animalName,
    required this.leftTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animalType == 0) {
      return Hero(
          tag: animalType,
          child: TurtleWidget(
            animalName: animalName,
            leftTime: leftTime,
          ));
    } else if (animalType == 1) {
      return Hero(
          tag: animalType,
          child: WhaleWidget(
            animalName: animalName,
            leftTime: leftTime,
          ));
    } else {
      return Hero(
          tag: animalType,
          child: PolarBearWidget(
            animalName: animalName,
            leftTime: leftTime,
          ));
    }
  }
}

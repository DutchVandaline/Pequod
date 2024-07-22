import 'dart:math';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Constants/EnvironmentTips.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Widgets/TurtleWidget.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/CountDownWidget.dart';
import 'package:pequod/Constants//Constants.dart';
import 'package:pequod/Widgets/WhaleWidget.dart';

int percentage = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Habit> habits = [];
  List<dynamic>? habitDone = [];
  int rndNumb = 0;

  @override
  void initState() {
    super.initState();
    Random random = new Random();
    rndNumb = random.nextInt(envTips.length);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<Habit> fetchedHabits = await ApiServices.getHabit();
      List? fetchedHabitDone = await ApiServices.getTodayHabitStatus(
          Constants.changeDateFormat(DateTime.now()));

      setState(() {
        habits = fetchedHabits;
        habitDone = fetchedHabitDone;
        habitDone ??= [];
        percentage = (habitDone!.length / habits.length * 100).toInt()!;
        print(percentage);
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          title: ClimateChangeTextWidget("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ArchiveScreen()));
                },
                icon: Icon(
                  Icons.book_outlined,
                  size: MediaQuery.of(context).size.width * 0.07,
                  color: Theme.of(context).primaryColorLight,
                )),
            const SizedBox(
              width: 10.0,
            ),
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
                            color: Theme.of(context).primaryColor),
                      )),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.amber])),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FutureBuilder(
                          future: ApiServices.getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'FjallaOne',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "--",
                                          style: TextStyle(fontSize: 40.0)),
                                      TextSpan(
                                          text: " Days ",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: "--:--:--",
                                          style: TextStyle(fontSize: 40.0)),
                                    ]),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  '🏴‍☠️ Error Occurred Loading Deadline',
                                  style: TextStyle(
                                    fontFamily: 'FjallaOne',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            } else {
                              Map<String, dynamic>? myPoint =
                                  snapshot.data as Map<String, dynamic>;
                              DateTime deadline =
                                  DateTime.parse(myPoint['animal_deadline']);
                              return CountDownWidget(deadline: deadline);
                            }
                          }),
                    )),
              ],
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: const TurtleWidget(),
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
                              borderRadius: BorderRadius.circular(13.0)),
                          child: Center(
                            child: Text(
                              "$percentage%",
                              style: const TextStyle(
                                  fontSize: 40.0, fontFamily: 'FjallaOne'),
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
                              borderRadius: BorderRadius.circular(13.0)),
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
                                SizedBox(height: 15.0,),
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
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

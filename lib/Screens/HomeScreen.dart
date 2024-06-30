import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/Screens/QuizScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/CountDownWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClimateChangeTextWidget("Quiz"),
                              const Text(
                                "You can solve Environment Quiz to earn additional points and time.",
                                style: TextStyle(fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QuizScreen()));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Solve Quiz to earn points",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 22.0),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ));
                    });
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              color: Theme.of(context).primaryColorLight,
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Marquee(
                    text: "DEADLINE Your Character is Suffering... ",
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
                  child: CountDownWidget(deadline: DateTime(2024, 06, 30)),
                )),
          ],
        ));
  }
}

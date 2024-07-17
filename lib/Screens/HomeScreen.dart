import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/Screens/QuizScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/CountDownWidget.dart';
import 'package:pequod/Constants//Constants.dart';

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
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Solve Quiz to earn points",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
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
                      child: CountDownWidget(deadline: DateTime(2024, 07, 02)),
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
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "SEA TURTLE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'FjallaOne',
                                fontWeight: FontWeight.bold,
                                fontSize: 90.0),
                          ),
                          Text(
                            "2024.07.04",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'FjallaOne',
                                fontWeight: FontWeight.bold,
                                fontSize: 90.0),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset('assets/images/death_screen.png', alignment: Alignment.bottomCenter,),
                        ),
                      ),
                    ],
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
                              borderRadius: BorderRadius.circular(13.0)),
                          child: const Center(
                            child: Text(
                              "80%",
                              style: TextStyle(
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
                          child: const Center(child: Text("data")),
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

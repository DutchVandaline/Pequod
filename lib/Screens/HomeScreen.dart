import 'package:flutter/material.dart';
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuizScreen()));
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
              color: Theme.of(context).primaryColorLight,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: RichText(
                  text: TextSpan(
                    text: " DEADLINE ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor),
                    children: [
                      TextSpan(
                        text: "YOUR CHARACTER IS SUFFERING...",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
              ),
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

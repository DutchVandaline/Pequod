import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Widgets/AnimalWidget.dart';
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArchiveScreen()));
                },
                icon: Icon(
                  Icons.book_outlined,
                  size: MediaQuery.of(context).size.width * 0.07,
                  color: Theme.of(context).primaryColorLight,
                )),
            SizedBox(width: 10.0,),
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
                                        style:
                                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
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
                            Map<String, dynamic>? myPoint = snapshot.data as Map<String, dynamic>;
                            DateTime deadline = DateTime.parse(myPoint['animal_deadline']);
                            return CountDownWidget(
                                deadline: deadline);
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
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "SEA TURTLE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'FjallaOne',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.22),
                          ),
                          const Text(
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'FjallaOne',
                                fontWeight: FontWeight.bold,
                                fontSize: 90.0),
                          ),
                        ],
                      ),
                      const AnimalWidget(),
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

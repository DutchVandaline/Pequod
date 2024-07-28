import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/Screens/AnimalSelectionScreen.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Constants/Constants.dart';
import 'package:pequod/Widgets/CountdownWidget.dart';

String animalName = "";
int animalType = 0;
int animalId = 0;

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int rndNumb = 0;
  late Future<List<dynamic>?> animalFuture;
  late bool dead;
  DateTime? deadline;
  List<double> left = [-10.0, 90.0, 180.0, 290.0];

  @override
  void initState() {
    super.initState();
    animalFuture = ApiServices.getAnimal();
  }

  Future<void> refreshData() async {
    setState(() {
      animalFuture = ApiServices.getAnimal();
    });
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
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: FutureBuilder(
                  future: animalId > 0
                      ? ApiServices.getAnimalbyId(animalId)
                      : Future.value(null),
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
                      return const Center(
                        child: Text(
                          "Select animal from the bottom!",
                          style: TextStyle(
                              fontFamily: 'FjallaOne',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      dead = snapshot.data['dead'];
                      deadline =
                          DateTime.parse(snapshot.data['animal_deadline']);
                      animalName = snapshot.data['animal_name'];
                      animalType = snapshot.data['animal_type'];
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.red, Colors.amber]),
                            ),
                            child: dead == true
                                ? const Center(
                                    child: Text(
                                      "☠️ Your Animal is Dead. ☠️",
                                      style: TextStyle(
                                          fontFamily: 'FjallaOne',
                                          fontSize: 25.0,
                                          color: Colors.white),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CountDownWidget(
                                      deadline: deadline,
                                      dead: dead,
                                      inputTextStyle: const TextStyle(
                                          fontFamily: 'FjallaOne',
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AnimalWidget(
                              animalType: animalType,
                              animalId: snapshot.data['id'],
                              dead: snapshot.data['dead'],
                            ),
                          ),
                          Container(
                            child: Text(
                              animalName,
                              style: const TextStyle(
                                  fontFamily: 'FjallaOne', fontSize: 70.0),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: animalFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "🏴‍☠️Error Occurred",
                  style: TextStyle(
                      fontFamily: 'FjallaOne',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ));
              } else if (snapshot.hasData && snapshot.data != null) {
                List<dynamic>? animals = snapshot.data;
                int? filledSlots = animals?.length;

                List<Widget> animalWidgets = animals!
                    .map((animal) {
                      double leftPosition =
                          left[animals.indexOf(animal) % left.length];
                      return Positioned(
                        left: leftPosition,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              animalId = animal['id'];
                            });
                            if (deadline != null &&
                                deadline!.isBefore(DateTime.now())) {
                              ApiServices.patchDead(animalId);
                            }
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.4,
                            child: AnimalWidget(
                              animalId: animal['id'],
                              animalType: animal['animal_type'],
                              dead: animal['dead'],
                            ),
                          ),
                        ),
                      );
                    })
                    .cast<Widget>()
                    .toList();
                if (filledSlots! < 4) {
                  animalWidgets.add(
                    Positioned(
                      left: left[3],
                      bottom: 50.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AnimalSelectionScreen()));
                        },
                        child: SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    children: animalWidgets,
                  ),
                );
              } else {
                return const Center(child: Text("No Animals Found"));
              }
            },
          )
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
          TextSpan(
              text: "--",
              style: TextStyle(fontSize: 40.0, color: Colors.white)),
          TextSpan(
              text: " Days ",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
          TextSpan(
              text: "--:--:--",
              style: TextStyle(fontSize: 40.0, color: Colors.white)),
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

class AnimalWidget extends StatefulWidget {
  final int animalType;
  final bool dead;
  final int animalId;

  const AnimalWidget(
      {super.key,
      required this.animalId,
      required this.animalType,
      required this.dead});

  @override
  State<AnimalWidget> createState() => _AnimalWidgetState();
}

class _AnimalWidgetState extends State<AnimalWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.dead == true) {
      return GestureDetector(
          onTap: () {
            showDeleteDialog(context);
          },
          child: Image.asset('assets/images/animals/death_screen.png'));
    } else {
      if (widget.animalType == 0) {
        return Image.asset('assets/images/animals/sea_turtle.png');
      } else if (widget.animalType == 1) {
        return Image.asset('assets/images/animals/whale.png');
      } else if (widget.animalType == 2) {
        return Image.asset('assets/images/animals/polar_bear.png');
      } else {
        return Image.asset('assets/images/animals/death_screen.png');
      }
    }
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete',
            style: TextStyle(
                fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600),
          ),
          content: const Text(
            "Do you really want Collect the Garbage and make another room for new animal?",
            style: TextStyle(fontSize: 20.0, fontFamily: 'FjallaOne'),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          actions: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () async {
                      ApiServices.deleteAnimal(widget.animalId);
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, a1, a2) => const MainScreen(
                              initialIndex: 2,
                            ),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                          (route) => false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Text(
                          'Collect',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
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
}

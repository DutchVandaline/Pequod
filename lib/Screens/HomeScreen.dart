import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pequod/Screens/AnimalDetailScreen.dart';
import 'package:pequod/Screens/AnimalSelectionScreen.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Constants/Constants.dart';
import 'package:pequod/Widgets/CountdownWidget.dart';
import 'package:pequod/Widgets/PoalrBearWidget.dart';
import 'package:pequod/Widgets/TurtleWidget.dart';
import 'package:pequod/Widgets/WhaleWidget.dart';

String animalName = "";
int animalType = 0;
int animalId = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int rndNumb = 0;
  late Future<List<dynamic>?> animalFuture;
  late bool dead;
  late DateTime deadline = DateTime.now().add(Duration(days: 2));

  List<double> left = [0.0, 90.0, 190.0, 300.0];

  @override
  void initState() {
    super.initState();
    animalFuture = ApiServices.getAnimal();
    initializeAnimalId();
  }

  Future<void> refreshData() async {
    setState(() {
      animalFuture = ApiServices.getAnimal();
      initializeAnimalId();
    });
  }

  void initializeAnimalId() async {
    final animals = await ApiServices.getAnimal();
    if (animals != null && animals.isNotEmpty) {
      setState(() {
        animalId = animals.last['id'];
      });
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.9,
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
                                          fontSize: 33.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: Hero(
                              tag: "type",
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 300),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>secondaryAnimation) {
                                        return AnimalDetailScreen(
                                          animalType: animalType,
                                          animalId: snapshot.data['id'],
                                          animalName:
                                              snapshot.data['animal_name'],
                                          dead: snapshot.data['dead'],
                                          deadline: deadline,
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
                                child: AnimalWidget(
                                  animalType: animalType,
                                  animalId: snapshot.data['id'],
                                  animalName: snapshot.data['animal_name'],
                                  dead: snapshot.data['dead'],
                                  deadline: deadline,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            animalName,
                            style: const TextStyle(
                                fontFamily: 'FjallaOne', fontSize: 60.0),
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
                  "📡Please check your Internet Connection",
                  style: TextStyle(fontFamily: 'FjallaOne', fontSize: 20.0),
                ));
              } else if (snapshot.hasData && snapshot.data != null) {
                List<dynamic>? animals = snapshot.data;
                int? filledSlots = animals?.length;

                List<Widget> animalWidgets = animals!.map((animal) {
                  double leftPosition =
                      left[animals.indexOf(animal) % left.length];
                  return Positioned(
                    left: leftPosition,
                    bottom: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          animalId = animal['id'];
                        });
                        checkAndPatchAnimalDeath(
                            animal['id'], animal['animal_deadline']);
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.33,
                        child: AnimalBottomWidget(
                          animalType: animal['animal_type'],
                          dead: animal['dead'],
                        ),
                      ),
                    ),
                  );
                }).toList();

                if (filledSlots! < 4) {
                  animalWidgets.add(
                    Positioned(
                      left: filledSlots == 0
                          ? MediaQuery.of(context).size.width * 0.45
                          : left[3],
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
                  child: Stack(children: animalWidgets),
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

void checkAndPatchAnimalDeath(int animalId, String deadlineStr) {
  DateTime deadline = DateTime.parse(deadlineStr);
  if (deadline.isBefore(DateTime.now())) {
    ApiServices.patchDead(animalId);
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
  final String animalName;
  final DateTime deadline;

  const AnimalWidget(
      {super.key,
      required this.animalId,
      required this.animalType,
      required this.dead,
      required this.animalName,
      required this.deadline});

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
      return widget.animalType == 0
          ? TurtleWidget(deadline: widget.deadline)
          : widget.animalType == 1
              ? WhaleWidget(deadline: widget.deadline)
              : widget.animalType == 2
                  ? PolarBearWidget(deadline: widget.deadline)
                  : Image.asset('assets/images/animals/death_screen.png');
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

class AnimalBottomWidget extends StatefulWidget {
  final int animalType;
  final bool dead;

  const AnimalBottomWidget(
      {Key? key, required this.animalType, required this.dead})
      : super(key: key);

  @override
  _AnimalBottomWidgetState createState() => _AnimalBottomWidgetState();
}

class _AnimalBottomWidgetState extends State<AnimalBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.dead ? deadAnimalWidget() : aliveAnimalWidget();
  }

  Widget deadAnimalWidget() {
    return Image.asset(
        'assets/images/animals/death_screen.png'); // Display dead animal image
  }

  Widget aliveAnimalWidget() {
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

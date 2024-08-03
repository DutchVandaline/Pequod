import 'package:flutter/material.dart';
import 'package:pequod/Screens/HomeScreen.dart';
import 'package:bubble/bubble.dart';

class AnimalDetailScreen extends StatefulWidget {
  final int animalType;
  final bool dead;
  final int animalId;
  final String animalName;
  final DateTime deadline;

  AnimalDetailScreen(
      {super.key,
      required this.animalId,
      required this.animalName,
      required this.animalType,
      required this.deadline,
      required this.dead});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
    ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Bubble(
                  nip: BubbleNip.rightBottom,
                  margin: const BubbleEdges.symmetric(horizontal: 10.0, vertical: 5.0),
                  padding: BubbleEdges.symmetric(horizontal: 10.0, vertical: 10.0),
                  alignment: Alignment.center,
                  child: const Text(
                    "Help me. These plastics are hurting it.",
                    style: TextStyle(fontFamily: 'FjallaOne', fontSize: 20.0),
                  ),
                ),
                Hero(
                  tag: "type",
                  child: SizedBox(
                    width : MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 17.0),
                      child: AnimalWidget(
                        animalId: widget.animalId,
                        animalType: widget.animalType,
                        dead: widget.dead,
                        animalName: widget.animalName,
                        deadline: widget.deadline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Center(
                    child: Text(
                      "Go back",
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          color: Theme.of(context).cardColor,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

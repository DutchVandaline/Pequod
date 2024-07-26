import 'package:flutter/material.dart';
import 'package:pequod/Widgets/PoalrBearWidget.dart';
import 'package:pequod/Widgets/TurtleWidget.dart';
import 'package:pequod/Widgets/WhaleWidget.dart';

class AnimalDetailScreen extends StatefulWidget {
  String animalName;
  int animalType;
  Duration leftTime;

  AnimalDetailScreen(
      {super.key, required this.animalName, required this.animalType, required this.leftTime});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Hero(
                  tag: widget.animalType,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: animalWidget(widget.animalType, widget.animalName, widget.leftTime)),
                  )),
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


Widget animalWidget(int animalType, String animalName, Duration leftTime){
  if(animalType == 0){
    return TurtleWidget(animalName: animalName, leftTime: leftTime,);
  } else if(animalType == 1){
    return WhaleWidget(animalName: animalName, leftTime: leftTime,);
  } else{
    return PolarBearWidget(animalName: animalName, leftTime: leftTime,);
  }
}
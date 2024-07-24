import 'package:flutter/material.dart';
import 'package:pequod/Widgets/PoalrBearWidget.dart';
import 'package:pequod/Widgets/TurtleWidget.dart';
import 'package:pequod/Widgets/WhaleWidget.dart';

class AnimalDetailScreen extends StatefulWidget {
  String animalName;
  int animalType;

  AnimalDetailScreen(
      {super.key, required this.animalName, required this.animalType});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
              tag: widget.animalType,
              child: animalWidget(widget.animalType, widget.animalName)),
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
    );
  }
}


Widget animalWidget(int animalType, String animalName){
  if(animalType == 0){
    return TurtleWidget(animalName: animalName);
  } else if(animalType == 1){
    return WhaleWidget(animalName: animalName);
  } else{
    return PolarBearWidget(animalName: animalName);
  }
}
import 'package:flutter/material.dart';
import 'package:pequod/Screens/VerificationScreen.dart';

class HabitWidgetTile extends StatefulWidget {
  String habitName;

  HabitWidgetTile({super.key, required this.habitName});

  @override
  State<HabitWidgetTile> createState() => _HabitWidgetTileState();
}

class _HabitWidgetTileState extends State<HabitWidgetTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationScreen(
                        habitName: widget.habitName,
                      )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Studying",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.habitName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontFamily: 'Pretendard',
                    fontSize: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

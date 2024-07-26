import 'package:flutter/material.dart';
import 'package:pequod/Screens/AnimalSelectionScreen.dart';

class DeathWidget extends StatefulWidget {
  DeathWidget({super.key});

  @override
  State<DeathWidget> createState() => _DeathWidgetState();
}

class _DeathWidgetState extends State<DeathWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showNewAnimalDialog(context);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/animals/death_screen.png',
                alignment: Alignment.bottomCenter,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Touch to Choose!",
                  style: TextStyle(fontFamily: 'FjallaOne', fontSize: 20.0),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showNewAnimalDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'New Animal',
          style: TextStyle(
              fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600),
        ),
        content: const Text(
          "Do you want to choose another animal?",
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AnimalSelectionScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Text(
                        'Choose',
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

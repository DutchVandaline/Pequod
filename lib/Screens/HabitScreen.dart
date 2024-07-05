import 'package:flutter/material.dart';
import 'package:pequod/Screens/AddHabitScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/HabitDateWidget.dart';
import 'package:intl/intl.dart';
import 'package:pequod/Widgets/HabitWidgetTile.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: false,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: ClimateChangeTextWidget(
              DateFormat.yMMMM().format(DateTime.now())),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddHabitScreen()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 35.0,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: HabitDateWidget(
                        inputDate:
                            DateTime.now().subtract(const Duration(days: 3))),
                  ),
                  Flexible(
                    flex: 1,
                    child: HabitDateWidget(
                        inputDate:
                            DateTime.now().subtract(const Duration(days: 2))),
                  ),
                  Flexible(
                    flex: 1,
                    child: HabitDateWidget(
                        inputDate:
                            DateTime.now().subtract(const Duration(days: 1))),
                  ),
                  Flexible(
                    flex: 1,
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.red,
                        ),
                      ),
                      HabitDateWidget(inputDate: DateTime.now())
                    ]),
                  ),
                  Flexible(
                    flex: 1,
                    child: HabitDateWidget(
                        inputDate: DateTime.now().add(const Duration(days: 1))),
                  ),
                  Flexible(
                    flex: 1,
                    child: HabitDateWidget(
                        inputDate: DateTime.now().add(const Duration(days: 2))),
                  ),
                  Flexible(
                    flex: 1,
                    child: HabitDateWidget(
                        inputDate: DateTime.now().add(const Duration(days: 3))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Flexible(
              flex: 10,
              child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return HabitWidgetTile(
                      habitName: "Use laptop and code",
                    );
                  }, ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/HabitDateWidget.dart';
import 'package:pequod/Widgets/HabitWidget.dart';
import 'package:intl/intl.dart';

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
          title: ClimateChangeTextWidget("Habits"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: () {},
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      DateFormat.yMMMM().format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      HabitDateWidget(inputDate: DateTime.now().subtract(const Duration(days: 2))),
                      HabitDateWidget(inputDate: DateTime.now().subtract(const Duration(days:1))),
                      HabitDateWidget(inputDate: DateTime.now()),
                      HabitDateWidget(inputDate: DateTime.now().add(const Duration(days: 1))),
                      HabitDateWidget(inputDate: DateTime.now().add(const Duration(days: 2))),
                    ],
                  )
                ],
              ),
            ),
            Flexible(
              flex: 15,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return HabitWidget(
                      habitName: "Data",
                    );
                  }),
            )
          ],
        ));
  }
}

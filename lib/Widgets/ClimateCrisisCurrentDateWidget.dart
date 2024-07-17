import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClimateCrisisCurrentDateWidget extends StatefulWidget {
  const ClimateCrisisCurrentDateWidget({super.key});

  @override
  State<ClimateCrisisCurrentDateWidget> createState() =>
      _ClimateCrisisCurrentDateWidgetState();
}

class _ClimateCrisisCurrentDateWidgetState extends State<ClimateCrisisCurrentDateWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedDefaultTextStyle(
          style: TextStyle(
              fontFamily: 'ClimateCrisis',
              color: Theme.of(context).primaryColorLight,
              fontSize: 25.0,
              fontWeight: selected ? FontWeight.w100 : FontWeight.w800
          ),
          duration: const Duration(milliseconds: 400),
          child: Text(DateFormat("MMMM yyyy").format(DateTime.now()))),
    );
  }
}

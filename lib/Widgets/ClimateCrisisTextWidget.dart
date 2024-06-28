import 'package:flutter/material.dart';

class ClimateChangeTextWidget extends StatefulWidget {
  ClimateChangeTextWidget(this.inputTitle);

  String inputTitle;

  @override
  State<ClimateChangeTextWidget> createState() =>
      _ClimateChangeTextWidgetState();
}

class _ClimateChangeTextWidgetState extends State<ClimateChangeTextWidget> {
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
          child: Text(widget.inputTitle),
          style: TextStyle(
            fontFamily: 'ClimateCrisis',
            color: Theme.of(context).primaryColorLight,
            fontSize: 25.0,
            fontWeight: selected ? FontWeight.w100 : FontWeight.w800
          ),
          duration: Duration(milliseconds: 400)),
    );
  }
}

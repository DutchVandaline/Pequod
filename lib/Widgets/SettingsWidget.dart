import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget(
      {super.key,
      required this.inputTitle,
      required this.inputicon,
      required this.nextScreen});

  IconData inputicon;
  String inputTitle;
  Widget nextScreen;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => widget.nextScreen));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 15.0),
                Icon(
                  widget.inputicon,
                  size: 30.0,
                ),
                const SizedBox(width: 20.0),
                Text(
                  widget.inputTitle,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 25.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

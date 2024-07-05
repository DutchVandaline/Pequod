import 'package:flutter/material.dart';

class ShopScreenWidget extends StatefulWidget {
  String inputTitle;
  String inputWidget;

  ShopScreenWidget({super.key, required this.inputTitle, required this.inputWidget});

  @override
  State<ShopScreenWidget> createState() => _ShopScreenWidgetState();
}

class _ShopScreenWidgetState extends State<ShopScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15.0)
        ),

        child: Text(
          'Grid Item',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

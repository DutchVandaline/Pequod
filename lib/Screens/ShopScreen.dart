import 'package:flutter/material.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        title: ClimateChangeTextWidget("Shop"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              "🪙 230",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
        ),
        itemBuilder: (BuildContext context, int count) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Theme.of(context).primaryColorLight)),
              child: Center(
                child: Text("data"),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          snap: false,
          floating: true,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 0.0,
          title: ClimateChangeTextWidget("Shop"),
          expandedHeight: 90.0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "🪙 120",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'Buying things can affect others.\nThink about the effects before you buy.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text(
                    'Grid Item ${index + 1}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
            childCount: 10,
          ),
        ),
      ],
    ));
  }
}
